import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsg_firebase/Auth/Providers/auth_provider.dart';
import 'package:gsg_firebase/Auth/helpers/auth_helper.dart';
import 'package:gsg_firebase/Auth/helpers/firestorage_helper.dart';
import 'package:gsg_firebase/Auth/helpers/firestore_helper.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  String message;
  static final routeName = 'chat';
  bool delivered;

  String userId = AuthHelper.authHelper.getUserId();

  TextEditingController sendController = TextEditingController();
  ScrollController scrollController = ScrollController();

  sendMessageToFirebase() async {
    sendController.clear();
    FirestoreHelper.firestoreHelper.addMessagesToFirestore({
      'message': this.message ?? '',
      'dateTime': DateTime.now(),
      'imageUrl': ''
    });

    // this.message = '';
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    return Scaffold(
        appBar: AppBar(
          title: Text('My chat'),
        ),
        body: Consumer<AuthProvider>(builder: (context, provider, x) {
          return Container(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream:
                          FirestoreHelper.firestoreHelper.getFirestoreStream(),
                      builder: (context, datasnapshot) {
                        if (!datasnapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }

                        Future.delayed(Duration(milliseconds: 100))
                            .then((value) {
                          //offset : for what position will move
                          //curve : movement effect
                          scrollController.animateTo(
                              scrollController.position.maxScrollExtent,
                              duration: Duration(milliseconds: 100),
                              curve: Curves.easeInOut);
                        });
                        QuerySnapshot<Map<String, dynamic>> querySnapshot =
                            datasnapshot.data;
                        List<Map> messages =
                            querySnapshot.docs.map((e) => e.data()).toList();
                        messages.sort(
                            (a, b) => a['dateTime'].compareTo(b['dateTime']));
                        return ListView.builder(
                            shrinkWrap: true,
                            controller: scrollController,
                            // reverse: true,
                            itemCount: messages.length,
                            itemBuilder: (context, i) {
                              // return messages[i]['message'] == null
                              //     ? Bubble(
                              //         margin: BubbleEdges.only(
                              //           bottom: 10,
                              //           top: 5,
                              //         ),
                              //         alignment:
                              //             this.userId == messages[i]['userId']
                              //                 ? Alignment.topLeft
                              //                 : Alignment.topRight,
                              //         nip: this.userId == messages[i]['userId']
                              //             ? BubbleNip.leftBottom
                              //             : BubbleNip.rightBottom,
                              //         color:
                              //             this.userId == messages[i]['userId']
                              //                 ? Colors.grey[200]
                              //                 : Colors.blue,
                              //         child: Text(
                              //           '',
                              //           textAlign: TextAlign.center,
                              //           style: TextStyle(fontSize: 15.0),
                              //         ),
                              //         elevation: 1,
                              //       ):
                              return messages[i]['imageUrl'] == ''
                                  ? Bubble(
                                      // margin: BubbleEdges.only(
                                      //   bottom: 10,
                                      //   top: 2,
                                      // ),
                                      margin: BubbleEdges.symmetric(
                                        vertical: 5,
                                        horizontal: 5,
                                      ),
                                      padding: BubbleEdges.all(
                                        15,
                                      ),
                                      alignment:
                                          this.userId == messages[i]['userId']
                                              ? Alignment.topLeft
                                              : Alignment.topRight,
                                      nip: this.userId == messages[i]['userId']
                                          ? BubbleNip.leftBottom
                                          : BubbleNip.rightBottom,
                                      color:
                                          this.userId == messages[i]['userId']
                                              ? Colors.grey[200]
                                              : Colors.blue,
                                      child: Text(
                                        messages[i]['message'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 15.0),
                                      ),
                                      elevation: 1,
                                    )
                                  : Bubble(
                                      margin: BubbleEdges.symmetric(
                                        vertical: 5,
                                        horizontal: 5,
                                      ),
                                      padding: BubbleEdges.all(
                                        15,
                                      ),
                                      alignment:
                                          this.userId == messages[i]['userId']
                                              ? Alignment.topLeft
                                              : Alignment.topRight,
                                      nip: this.userId == messages[i]['userId']
                                          ? BubbleNip.leftBottom
                                          : BubbleNip.rightBottom,
                                      color:
                                          this.userId == messages[i]['userId']
                                              ? Colors.grey[200]
                                              : Colors.blue,
                                      child: Image.network(
                                          messages[i]['imageUrl']),
                                      elevation: 1,
                                    );
                            });
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  provider.sendImageToChat();
                                },
                                icon: Icon(Icons.attach_file),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: sendController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (x) {
                                    this.message = x;
                                    // sendController.text = ;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: IconButton(
                          color: Colors.blue,
                          onPressed: () {
                            sendMessageToFirebase();
                            // _scrollToBottom();
                          },
                          icon: Icon(Icons.send),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }));
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

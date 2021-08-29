import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsg_firebase/Auth/helpers/auth_helper.dart';
import 'package:gsg_firebase/Auth/helpers/firestorage_helper.dart';
import 'package:gsg_firebase/Auth/helpers/firestore_helper.dart';

class ChatPage extends StatelessWidget {
  static final routeName = 'chat';
  String message;
  bool delivered;
  String userId = AuthHelper.authHelper.getUserId();
  TextEditingController sendController = TextEditingController();
  sendMessageToFirebase() async {
    FirestoreHelper.firestoreHelper.addMessagesToFirestore({
      'message': this.sendController.text,
      'dateTime': DateTime.now(),
    });
    this.sendController.clear();
    sendController.text = '';
    this.message = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My chat'),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirestoreHelper.firestoreHelper.getFirestoreStream(),
                  builder: (context, datasnapshot) {
                    QuerySnapshot<Map<String, dynamic>> querySnapshot =
                        datasnapshot.data;
                    List<Map> messages =
                        querySnapshot.docs.map((e) => e.data()).toList();
                    messages
                        .sort((a, b) => a['dateTime'].compareTo(b['dateTime']));
                    return ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, i) {
                          return messages[i]['message'] == null
                              ? Bubble(
                                  margin: BubbleEdges.only(
                                    bottom: 10,
                                    top: 5,
                                  ),
                                  alignment:
                                      this.userId == messages[i]['userId']
                                          ? Alignment.topLeft
                                          : Alignment.topRight,
                                  nip: this.userId == messages[i]['userId']
                                      ? BubbleNip.leftBottom
                                      : BubbleNip.rightBottom,
                                  color: this.userId == messages[i]['userId']
                                      ? Colors.grey[200]
                                      : Colors.blue,
                                  child: Text(
                                    '',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                  elevation: 1,
                                )
                              : Bubble(
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
                                  color: this.userId == messages[i]['userId']
                                      ? Colors.grey[200]
                                      : Colors.blue,
                                  child: Text(
                                    messages[i]['message'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 15.0),
                                  ),
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
                    child: TextField(
                      controller: sendController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onEditingComplete: () {
                        // this.message = x;
                        // sendController.text = ;
                      },
                    ),
                  ),
                  Container(
                    child: IconButton(
                      color: Colors.blue,
                      onPressed: () {
                        sendMessageToFirebase();
                      },
                      icon: Icon(Icons.send),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

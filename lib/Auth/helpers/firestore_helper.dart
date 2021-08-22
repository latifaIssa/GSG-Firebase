import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gsg_firebase/Auth/models/register_request.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  addUserToFirestore(RegisterRequest registerRequest) async {
    try {
      DocumentReference documentReference = await firebaseFirestore
          .collection('Users')
          .add(registerRequest.toMap());
      print(documentReference.id);
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }
}

import 'package:allnotes/common/constants/firestore_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreClient {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User _user = FirebaseAuth.instance.currentUser;

  Future<List<QueryDocumentSnapshot>> getAllNotes() async {
    String collectionName = getCollectionName();
    QuerySnapshot collection =
        await _firestore.collection(collectionName).get();
    List<QueryDocumentSnapshot> documents = collection.docs;
    return documents;
  }

  String getCollectionName() {
    return '${FirestoreConstants.BASE_USER_DOCUMENT}${_user.uid}';
  }
}

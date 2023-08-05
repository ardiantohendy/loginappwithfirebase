import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  //collection references

  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection("brews");

  Future updateUserData(sugars, name, strength) async {
    return await brewCollection.doc(uid).set(
      {
        "sugars": sugars,
        "name": name,
        "strength": strength,
      },
    );
  }

  //get brew stream

  Stream<QuerySnapshot> get brews {
    return brewCollection.snapshots();
  }
}

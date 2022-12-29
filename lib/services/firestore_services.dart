import 'package:shop_app/consts/consts.dart';

class FirestoreServices {
  //retrieve user data from firestore.
  static getUser(uid) {
    return firestore
        .collection(usersCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }
}

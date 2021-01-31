import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  final CollectionReference userData =
      FirebaseFirestore.instance.collection('userData');
  Future<void> createUserData(
      String name, String phone, String city, String uid) async {
    return await userData
        .doc(uid)
        .set({'name': name, 'phone': phone, 'city': city});
  }

  Future getUsersList() async {
    List itemsList = [];

    try {
      await userData.get().then((querySnapshot) {
        querySnapshot.docChanges.forEach((element) {
          itemsList.add(element.doc);
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future updateUserData(
      String name, String phone, String city, String uid) async {
    return await userData
        .doc(uid)
        .update({'name': name, 'phone': phone, 'city': city});
  }
}

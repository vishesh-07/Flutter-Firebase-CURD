import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_fire/Database/database.dart';

class Authentication{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  Future createNewUser(String name, String email, String password,String phone,String city) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      await DatabaseManager().createUserData(name, phone, city, user.uid);
      return user;
    } catch (e) {
      print(e.toString());
    }
  }
  Future loginUser(String email,String password)async{
    try {
      UserCredential result=await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (e) {
      print(e.toString());
    }
  }
  Future logoutUser()async{
    try {
     return _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
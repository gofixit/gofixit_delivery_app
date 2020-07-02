import 'package:firebase_auth/firebase_auth.dart';
import 'package:gofixit_demo_one/model/UserModel.dart';
import 'package:gofixit_demo_one/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? UserModel(userId: user.uid) : null;
  }

  Stream<UserModel> get user {
    return _auth.onAuthStateChanged
        // .map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // signout
  Future signOut() async {
    try {
      print("logging out");
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // signin as anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      // print(e.toString());
      return null;
    }
  }

  // signup with email and password
  Future registerWithEmailAndPassword(
    String email,
    String password,
    String username,
    String phone,
  ) async {
    try {
      // String username = 'Aceknoxx';
      // String phone = '09072574580';
      String gender = '';
      int strength = 0;
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid)
          .updateUserDetails(username, phone, gender, strength);
      return _userFromFirebaseUser(user);
    } catch (e) {
      //  print(e.toString());
      return null;
    }
  }

  // signin with email and password
  Future signInwithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/users.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// sign up user
  Future<String> signUpUser(
      {required String email,
      required String password,
      required String name,
      required String username}) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          name.isNotEmpty) {
        // register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        // store user to firestore db
        model.User user = model.User(
          uid: cred.user!.uid,
          email: email,
          name: name,
          username: username,
        );
        await _firestore.collection("users").doc(cred.user!.uid).set(
              user.toJson(),
            );
        res = "Success";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  // login user
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error occured";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Success";
      } else {
        res = "Please enter all field";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

// logout user
  Future<void> signOut() async {
    await _auth.signOut();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
String error='';
User? user;
class GoogleAuth{
  static Future<User?> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
        await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          error = 'account exists with different credentials';
        }
        else if (e.code == 'invalid-credential') {
          error = 'invalid credentials';
        }
      } catch (e) {
        // handle the error here
      }
    }
    return user;
  }
}
class GoogleFireStoreInit{
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static Future<void> Init()async{
    FirebaseFirestore.instance
        .collection('UsersData')
        .doc(user?.uid)
        .set({
      'profileurl': user?.photoURL,
      'online': null,'lastseen': null,
    });
    firestore.collection(
        'users').doc(user?.uid).set({
      'email': user?.email,
      'nickname': user?.displayName,
      'number': user?.phoneNumber,
      'verification': true,
    }).then((_) => {
      print('success')
    });
  }
}
class GoogleAutherrors{
  static String Error(){
    return error;
  }
}
import 'package:chat_up/Services/Auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
String error='';
User? user;
class FbAuth{
  static Future<User?> signInWithFacebook() async {
    try{
      //Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();
      //Create a credential from the access token
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
      //Once signed in, return the UserCredential
      UserCredential Credential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      user = Credential.user;
      return Credential.user;
    } on FirebaseException catch(e){
      error =e.code;
      print(e.code);
      print('above should be error');
    }
  }
}
class FBFireStoreInit{
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
class FbAutherrors{
  static String Error(){
    return error;
  }
}
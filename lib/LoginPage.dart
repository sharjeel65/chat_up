import 'package:chat_up/UserHome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:chat_up/SignupPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:move_to_background/move_to_background.dart';
import 'Auth.dart';
import 'Validator.dart';
import 'SignupPage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void _navigatetosignup(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SignupPage(verificat: false, userfromsignin: _user,)));
  }

  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  bool _isProcessing = false;
  late DocumentSnapshot snapshot;
  User? _user = FirebaseAuth.instance.currentUser;

  Future<bool> userVerification() async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    snapshot = data as DocumentSnapshot<Object?>;
    var map = snapshot.data() as Map;
    var verification = map['verification'];
    bool verify = verification;
    print(map);
    print(verification);
    return verify;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        MoveToBackground.moveTaskToBack();
        return false;
      },
      child: GestureDetector(
        onTap: () {
          _focusEmail.unfocus();
          _focusPassword.unfocus();
        },
        child: Scaffold(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                stops: [
                  0.1,
                  0.72,
                  0.86,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFb0b4e5),
                  Color(0xFF202c77),
                  Color(0xFF141468),
                ],
              ),
            ),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width,
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                            image: AssetImage("assets/images/user.png"),
                            fit: BoxFit.contain,
                          ),
                        ),
                        margin: EdgeInsets.fromLTRB(50, 100, 50, 50),
                        height: 83,
                        width: 101,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              width: 245,
                              height: 60,
                              padding: EdgeInsets.only(bottom: 0),
                              child: Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                    padding: EdgeInsets.fromLTRB(2, 0, 0, 5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(6)),
                                    height: 40,
                                    width: 245,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    textDirection: TextDirection.ltr,
                                    controller: _emailTextController,
                                    focusNode: _focusEmail,
                                    validator: (value) => Validator.validateEmail(
                                      email: value,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(5),
                                      hintText: 'Enter email',
                                      hintStyle: TextStyle(
                                        color: Color(0xFFF338BFF),
                                        fontSize: 14,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6.0),
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                        ),
                                      ),
                                      errorStyle: TextStyle(
                                        height: 1,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 245,
                              height: 60,
                              padding: EdgeInsets.only(bottom: 0),
                              child: Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                    padding: EdgeInsets.fromLTRB(2, 0, 0, 5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(6)),
                                    height: 40,
                                    width: 245,
                                  ),
                                  TextFormField(
                                    controller: _passwordTextController,
                                    focusNode: _focusPassword,
                                    obscureText: true,
                                    validator: (value) =>
                                        Validator.validatePassword(
                                      password: value,
                                    ),
                                    keyboardType: TextInputType.text,
                                    textDirection: TextDirection.ltr,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(5),
                                      hintText: 'Password',
                                      hintStyle: TextStyle(
                                        color: Color(0xFFF338BFF),
                                        fontSize: 14,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6.0),
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                        ),
                                      ),
                                      errorStyle: TextStyle(
                                        height: 1,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                _focusEmail.unfocus();
                                _focusPassword.unfocus();

                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _isProcessing = true;
                                  });

                                  User? user =
                                      await FireAuth.signInUsingEmailPassword(
                                    email: _emailTextController.text,
                                    password: _passwordTextController.text,
                                  );

                                  setState(() {
                                    _isProcessing = false;
                                  });

                                  if (user != null) {
                                    if (await userVerification()) {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              UserHome(user: user),
                                        ),
                                      );
                                    } else{
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignupPage(verificat: true, userfromsignin: user,)));
                                    }
                                  } else if (user == null) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Container(
                                            child: Text(errormessage),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                height: 35,
                                width: 245,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    gradient: LinearGradient(
                                        stops: [0.18, 0.4, 0.8],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color(0xFFF6256D8),
                                          Color(0xFFFAAB3CE),
                                          Color(0xFFF8564B4)
                                        ])),
                                child: !_isProcessing
                                    ? Center(
                                        child: Text(
                                          'Submit',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Times New Roman',
                                          ),
                                        ),
                                      )
                                    : Center(
                                        child: Container(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator()),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: Center(
                          child: Text(
                            'Or Log In with',
                            style: TextStyle(
                              color: Color(0xfff338BFF),
                              fontFamily: 'Times New Roman',
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 500,
                        margin: EdgeInsets.fromLTRB(140, 0, 140, 0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _navigatetosignup(context);
                              },
                              child: Container(
                                height: 26,
                                width: 26,
                                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/google.png"),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _navigatetosignup(context);
                              },
                              child: Container(
                                height: 26,
                                width: 26,
                                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage("assets/images/twitter.png"),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _navigatetosignup(context);
                              },
                              child: Container(
                                height: 26,
                                width: 26,
                                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage("assets/images/facebook.png"),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _navigatetosignup(context);
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                          height: 35,
                          width: 245,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              gradient: LinearGradient(
                                  stops: [0.18, 0.4, 0.8],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFFF6256D8),
                                    Color(0xFFFAAB3CE),
                                    Color(0xFFF8564B4)
                                  ])),
                          child: Center(
                            child: Text(
                              'Create an account first',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Times New Roman',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

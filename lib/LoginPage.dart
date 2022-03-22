import 'dart:ui';
import 'package:chat_up/UserHome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:chat_up/SignupPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        .push(MaterialPageRoute(builder: (context) => SignupPage()));
  }

  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  bool _isProcessing = false;

  User? user = FirebaseAuth.instance.currentUser;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                          image: AssetImage("assets/images/profile.png"),
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
                            padding: EdgeInsets.fromLTRB(2, 0, 0, 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6)),
                            height: 50,
                            width: 245,
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              textDirection: TextDirection.ltr,
                              controller: _emailTextController,
                              focusNode: _focusEmail,
                              validator: (value) => Validator.validateEmail(
                                email: value,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(5),
                                hintText: 'Enter username or number',
                                hintStyle: TextStyle(
                                  color: Color(0xFFF338BFF),
                                  fontSize: 14,
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(2, 0, 0, 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6)),
                            height: 50,
                            width: 245,
                            margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                            child: TextFormField(
                              controller: _passwordTextController,
                              focusNode: _focusPassword,
                              obscureText: true,
                              validator: (value) => Validator.validatePassword(
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
                                errorBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
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
                            child: GestureDetector(
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
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => UserHome(user: user),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: Center(
                                child: Text(
                                  'Submit',
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
                      margin: EdgeInsets.fromLTRB(150, 0, 150, 0),
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
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFF56066E),
                                spreadRadius: 1,
                                blurRadius: 16,
                                offset: Offset(
                                    1.5, 4), // changes position of shadow
                              ),
                            ],
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
    );
  }
}

import 'package:flutter/material.dart';
import 'UserHome.dart';
import 'Validator.dart';
import 'Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  ///////FUNCTIONS DECLARATION/////////////
  void showCustomDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              decoration: BoxDecoration(
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
              height: 400,
              width: 300,
              child: IntrinsicHeight(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Form(
                      // key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                            width: 245,
                            height: 60,
                            padding: EdgeInsets.only(bottom: 0),
                            child: Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(2, 0, 0, 5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6)),
                                  height: 40,
                                  width: 245,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  textDirection: TextDirection.ltr,
                                  //controller: _emailTextController,
                                  focusNode: _focusEmail,
                                  validator: (value) => Validator.validateEmail(
                                    email: value,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(5),
                                    hintText: 'Mobile Number',
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
                                  padding: EdgeInsets.fromLTRB(2, 0, 0, 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  height: 40,
                                  width: 245,
                                ),
                                TextFormField(
                                  // controller: _passwordTextController,
                                  focusNode: _focusPassword,
                                  validator: (value) =>
                                      Validator.validatePassword(
                                    password: value,
                                  ),
                                  keyboardType: TextInputType.number,
                                  textDirection: TextDirection.ltr,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(5),
                                    hintText: 'Verification Code',
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
                            height: 35,
                            width: 245,
                            margin: EdgeInsets.fromLTRB(0, 80, 0, 0),
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
                          ),
                          Container(
                            height: 35,
                            width: 245,
                            margin: EdgeInsets.only(top: 30),
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
                            /*  child: GestureDetector(
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
                                        builder: (context) =>
                                            UserHome(user: user),
                                      ),
                                    );
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
                            ),*/
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  ////////VARIABLES DECLARATION//////////
  String dropdownvalue = 'List of Countries';
  final _nicknameController = TextEditingController();
  final _numberController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _conPasswordController = TextEditingController();
  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  final _focusNumber = FocusNode();
  final _focusConfPassword = FocusNode();
  final _registerFormKey = GlobalKey<FormState>();
  bool _isProcessing = false;

  /////////////BUILD STARTED//////////////
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusConfPassword.unfocus();
        _focusPassword.unfocus();
        _focusEmail.unfocus();
        _focusNumber.unfocus();
        _focusName.unfocus();
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
                    //////USER IMAGE AREA/////
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          image: AssetImage("assets/images/add-user.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                      margin: EdgeInsets.fromLTRB(50, 80, 50, 40),
                      height: 83,
                      width: 101,
                    ),
                    ///////FORM STARTED///////
                    Form(
                      key: _registerFormKey,
                      child: Column(
                        children: [
                          ///////NICKNAME CONTAINER AND FORMFIELD///////
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
                                  validator: (value) => Validator.validateName(
                                    name: value,
                                  ),
                                  focusNode: _focusName,
                                  controller: _nicknameController,
                                  textDirection: TextDirection.ltr,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(8, 8, 8, 8),
                                    errorStyle: TextStyle(height: 1),
                                    hintText: 'Enter nickname',
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
                                  ),
                                ),
                              ],
                            ),
                          ),
                          /////// NUMBER FIELD///////
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
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  height: 40,
                                  width: 245,
                                ),
                                TextFormField(
                                  focusNode: _focusNumber,
                                  validator: (value) =>
                                      Validator.validateNumber(
                                    number: value,
                                  ),
                                  controller: _numberController,
                                  keyboardType: TextInputType.number,
                                  textDirection: TextDirection.ltr,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(8, 8, 8, 8),
                                    errorStyle:
                                        TextStyle(height: 1, fontSize: 12),
                                    border: InputBorder.none,
                                    hintMaxLines: 2,
                                    hintText: 'Enter number',
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
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ///////EMAIL FORMFIELD///////
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
                                  focusNode: _focusEmail,
                                  validator: (value) => Validator.validateEmail(
                                    email: value,
                                  ),
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  textDirection: TextDirection.ltr,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(8),
                                    hintText: 'Enter email',
                                    hintStyle: TextStyle(
                                      color: Color(0xFFF338BFF),
                                      fontSize: 14,
                                    ),
                                    errorStyle: TextStyle(
                                      height: 1,
                                      fontSize: 12,
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ///////PASSWORD FORMFIELD///////
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
                                  focusNode: _focusPassword,
                                  validator: (value) =>
                                      Validator.validatePassword(
                                    password: value,
                                  ),
                                  controller: _passwordController,
                                  obscureText: true,
                                  keyboardType: TextInputType.text,
                                  textDirection: TextDirection.ltr,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(8),
                                    hintText: 'Enter Password',
                                    hintStyle: TextStyle(
                                      color: Color(0xFFF338BFF),
                                      fontSize: 14,
                                    ),
                                    errorStyle: TextStyle(
                                      height: 1,
                                      fontSize: 12,
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ///////CONFIRM PASSWORD FORMFIELD//////
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
                                  focusNode: _focusConfPassword,
                                  validator: (value) =>
                                      Validator.ValidateConfPassword(
                                    password: _passwordController.text,
                                    Confpassword: value,
                                  ),
                                  controller: _conPasswordController,
                                  obscureText: true,
                                  keyboardType: TextInputType.text,
                                  textDirection: TextDirection.ltr,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(8),
                                    hintText: 'Confirm Password',
                                    hintStyle: const TextStyle(
                                      color: Color(0xFFF338BFF),
                                      fontSize: 14,
                                    ),
                                    errorStyle: const TextStyle(
                                      fontSize: 12,
                                      height: 1,
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ///////SUBMIT BUTTON///////
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                            height: 35,
                            width: 245,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              gradient: const LinearGradient(
                                stops: [0.18, 0.4, 0.8],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFFF6256D8),
                                  Color(0xFFFAAB3CE),
                                  Color(0xFFF8564B4)
                                ],
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                showCustomDialog(context);

                                setState(() {
                                  print(_numberController.text);
                                });
/*
                                setState(
                                  () {
                                    _isProcessing = true;
                                  },
                                );

                                if (_registerFormKey.currentState!.validate()) {
                                  User? user =
                                      await FireAuth.registerUsingEmailPassword(
                                    name: _nicknameController.text,
                                    number: _numberController.text,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  );
                                  setState(
                                    () {
                                      _isProcessing = false;
                                    },
                                  );

                                  if (user != null) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            UserHome(user: user),
                                      ),
                                    );
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
                                }*/
                              },
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
                    ///////SIGNUP WITH TEXT AREA///////
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: const Center(
                        child: Text(
                          'Or Sign Up with',
                          style: TextStyle(
                            color: Color(0xfff338BFF),
                            fontFamily: 'Times New Roman',
                          ),
                        ),
                      ),
                    ),
                    ///////SIGNUPWITH GOOGLE///////
                    Container(
                      height: 50,
                      width: 500,
                      margin: EdgeInsets.fromLTRB(150, 0, 150, 0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // _navigatetosignup(context);
                            },
                            child: Container(
                              height: 26,
                              width: 26,
                              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/google.png"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              //_navigatetosignup(context);
                            },
                            ///////SIGNUP WITH TWITTER///////
                            child: Container(
                              height: 26,
                              width: 26,
                              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              decoration: const BoxDecoration(
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
                              // _navigatetosignup(context);
                            },
                            ///////SIGNUP WITH FACEBOOK///////
                            child: Container(
                              height: 26,
                              width: 26,
                              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              decoration: const BoxDecoration(
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

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
  void _navigatetoHomePage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SignupPage()));
  }

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
                    Form(
                      key: _registerFormKey,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                            padding: EdgeInsets.fromLTRB(2, 0, 0, 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6)),
                            height: 40,
                            width: 245,
                            child: TextFormField(
                              validator: (value) => Validator.validateName(
                                name: value,
                              ),
                              focusNode: _focusName,
                              controller: _nicknameController,
                              textDirection: TextDirection.ltr,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(8),
                                hintText: 'Enter nickname',
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
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                            padding: EdgeInsets.fromLTRB(2, 0, 0, 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6)),
                            height: 40,
                            width: 245,
                            child: TextFormField(
                              focusNode: _focusNumber,
                              validator: (value) => Validator.validateNumber(
                                number: value,
                              ),
                              controller: _numberController,
                              keyboardType: TextInputType.number,
                              textDirection: TextDirection.ltr,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(4),
                                hintMaxLines: 2,
                                hintText:
                                    'Enter number with country code e.g 923xxxxxxxxxxx',
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
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                            padding: EdgeInsets.fromLTRB(2, 0, 0, 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6)),
                            height: 40,
                            width: 245,
                            child: TextFormField(
                              focusNode: _focusEmail,
                              validator: (value) => Validator.validateEmail(
                                email: value,
                              ),
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              textDirection: TextDirection.ltr,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(8),
                                hintText: 'Enter email',
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
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                            padding: EdgeInsets.fromLTRB(2, 0, 0, 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6)),
                            height: 40,
                            width: 245,
                            child: TextFormField(
                              focusNode: _focusPassword,
                              validator: (value) => Validator.validatePassword(
                                password: value,
                              ),
                              controller: _passwordController,
                              obscureText: true,
                              keyboardType: TextInputType.text,
                              textDirection: TextDirection.ltr,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(8),
                                hintText: 'Enter Password',
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
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                            padding: EdgeInsets.fromLTRB(2, 0, 0, 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6)),
                            height: 40,
                            width: 245,
                            child: TextFormField(
                              focusNode: _focusConfPassword,
                              validator: (value) => Validator.ValidateConfPassword(
                                password: _passwordController.text,
                                Confpassword: value,
                              ),
                              controller: _conPasswordController,
                              obscureText: true,
                              keyboardType: TextInputType.text,
                              textDirection: TextDirection.ltr,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(8),
                                hintText: 'Confirm Password',
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
                                setState(() {
                                  _isProcessing = true;
                                });

                                if (_registerFormKey.currentState!
                                    .validate()) {
                                  User? user = await FireAuth
                                      .registerUsingEmailPassword(
                                    name: _nicknameController.text,
                                    number: _numberController.text,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    ConPassword: _conPasswordController.text,
                                  );

                                  setState(() {
                                    _isProcessing = false;
                                  });

                                  if (user != null) {
                                    Navigator.of(context)
                                        .push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            UserHome(user: user),
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
                          'Or Sign Up with',
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
                              // _navigatetosignup(context);
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
                              //_navigatetosignup(context);
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
                              // _navigatetosignup(context);
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

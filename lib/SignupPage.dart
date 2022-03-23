import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'UserHome.dart';
import 'Validator.dart';
import 'Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'CountryCodeLists.dart';
import 'package:dropdown_search/dropdown_search.dart';

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
  var list = CountryCodeList.Codes;

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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 3, 0, 15),
                                padding:
                                    EdgeInsets.fromLTRB(0.1, 0.1, 0.1, 0.1),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                height: 40,
                                width: 70,
                                child: DropdownSearch<String>(
                                    autoValidateMode: AutovalidateMode.always,
                                    mode: Mode.BOTTOM_SHEET,
                                    showSearchBox: true,
                                    showSelectedItems: false,
                                    items: CountryCodeList.Codes,
                                    dropdownButtonBuilder: (_) => Container(
                                          /*
                                      decoration: BoxDecoration(
                                        color: Colors.lightGreenAccent,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      width: 40,
                                          height: 40,
                                          child: const Icon(
                                            Icons.arrow_drop_down,
                                            size: 24,

                                          ),
                                          */
                                          color: Colors.black,
                                        ),
                                    dropdownSearchBaseStyle:
                                        TextStyle(fontSize: 10),
                                    popupItemDisabled: (String s) =>
                                        s.startsWith('I'),
                                    onChanged: print,
                                    selectedItem: CountryCodeList.Codes[0]),
                              ),
                              Container(
                                height: 62,
                                width: 170,
                                padding: EdgeInsets.fromLTRB(5, 1, 0, 0),
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      height: 40,
                                      width: 170,
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
                                        errorStyle: TextStyle(height: 1,
                                        fontSize: 12),
                                        border: InputBorder.none,
                                        hintMaxLines: 2,
                                        hintText: 'Enter number',
                                        hintStyle: TextStyle(
                                          color: Color(0xFFF338BFF),
                                          fontSize: 14,
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          borderSide: BorderSide(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
                                  validator: (value) => Validator.validatePassword(
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
                                    hintStyle: TextStyle(
                                      color: Color(0xFFF338BFF),
                                      fontSize: 14,
                                    ),
                                    errorStyle: TextStyle(
                                      fontSize: 12,
                                      height: 1,
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

                                if (_registerFormKey.currentState!.validate()) {
                                  User? user =
                                      await FireAuth.registerUsingEmailPassword(
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
                                    Navigator.of(context).push(
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

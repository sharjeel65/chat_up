import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                    padding: EdgeInsets.fromLTRB(2, 0, 0, 5),
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(6)),
                    height: 40,
                    width: 245,
                    child: const TextField(
                      textDirection: TextDirection.ltr,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        hintText: 'Enter nickname',
                        hintStyle: TextStyle(
                          color: Color(0xFFF338BFF),
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                    padding: EdgeInsets.fromLTRB(2, 0, 0, 5),
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(6)),
                    height: 40,
                    width: 245,
                    child: const TextField(
                      keyboardType: TextInputType.number,
                      textDirection: TextDirection.ltr,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(4),
                        hintMaxLines: 2,
                        hintText: 'Enter number with country code e.g 923xxxxxxxxxxx',
                        hintStyle: TextStyle(
                          color: Color(0xFFF338BFF),
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                    padding: EdgeInsets.fromLTRB(2, 0, 0, 5),
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(6)),
                    height: 40,
                    width: 245,
                    child: const TextField(
                      keyboardType: TextInputType.emailAddress,
                      textDirection: TextDirection.ltr,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        hintText: 'Enter email',
                        hintStyle: TextStyle(
                          color: Color(0xFFF338BFF),
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                    padding: EdgeInsets.fromLTRB(2, 0, 0, 5),
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(6)),
                    height: 40,
                    width: 245,
                    child: const TextField(
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
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                    padding: EdgeInsets.fromLTRB(2, 0, 0, 5),
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(6)),
                    height: 40,
                    width: 245,
                    child: const TextField(
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
                      onTap: null,
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
                                image: AssetImage("assets/images/twitter.png"),
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
                                image: AssetImage("assets/images/facebook.png"),
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
    );
  }
}

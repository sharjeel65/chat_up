import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            stops: [
              0.052,
              0.72,
              0.96,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFb0b4e5),
              Color(0xFF202c77),
              Color(0xFF141468),
            ],
          ),
        ),
        child: Column(
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
            Container(
              padding: EdgeInsets.fromLTRB(2, 0, 0, 5),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(6)),
              height: 50,
              width: 245,
              child: const TextField(
                textDirection: TextDirection.ltr,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  hintText: 'Enter username, email or number',
                  hintStyle: TextStyle(
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(2, 0, 0, 5),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(6)),
              height: 50,
              width: 245,
              margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: const TextField(
                keyboardType: TextInputType.text,
                obscureText: true,
                textDirection: TextDirection.ltr,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
              decoration: BoxDecoration(),
              child: GestureDetector(
                onTap: null,
                child: Center(
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

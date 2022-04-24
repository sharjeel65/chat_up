import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrentUserProfile extends StatefulWidget {
  late final User user;

  CurrentUserProfile({Key? key, required this.user}) : super(key: key);

  @override
  State<CurrentUserProfile> createState() => _CurrentUserProfileState();
}

class _CurrentUserProfileState extends State<CurrentUserProfile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentUser = widget.user;
  }
  @override
  late User _currentUser;

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          stops: [
            0.50,
            1.0,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFfefefe),
            Color(0xFF6372a1),
          ],
        )),
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        height: 150,
                        width: 150,
                        child: Image.network(
                          _currentUser.photoURL!,
                          fit: BoxFit.contain,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blueAccent,
                            width: 2,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print('tapped');
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(95, 105, 0, 0),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/camera.png'),
                                fit: BoxFit.fitWidth,
                              ),
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 5,
                                color: Colors.black12,
                              )),
                        ),
                      )
                    ],
                  ),
                  Center(
                    child: Container(
                      child: Text(
                        _currentUser.displayName!,
                        style: TextStyle(
                          color: Colors.blue.shade700,
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue,width: 1)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '   Password',
                          style: TextStyle(
                            color: Colors.blue.shade700,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        IconButton(
                          onPressed: (){
                            print('tapped');
                          },
                          icon: Icon(
                            CupertinoIcons.pen,
                            size: 30,
                            color: Colors.blue,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

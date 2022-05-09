import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  final ImagePicker _picker = ImagePicker();

  void displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        XFile? image = await _picker.pickImage(
                            source: ImageSource.gallery, imageQuality: 40);
                        dynamic myFile = File(image!.path);
                        FirebaseStorage storage = FirebaseStorage.instance;
                        Reference ref = storage
                            .ref()
                            .child('users/Profile_Pics/${_currentUser.uid}');
                        UploadTask uploadTask = ref.putFile(myFile);
                        uploadTask.then((res) async {
                          String url = await res.ref.getDownloadURL();
                          print('this is url' + url);
                          await _currentUser.updatePhotoURL(url).then(
                                (_) => {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text("Completed"),
                                      content: Text(
                                          "Your Profile has been successfully updated"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                          },
                                          child: Text("Ok"),
                                        ),
                                      ],
                                    ),
                                  ),
                                },
                              );
                          print("This is updated url" + _currentUser.photoURL!);
                          FirebaseFirestore.instance
                              .collection('UsersData')
                              .doc(_currentUser.uid)
                              .set({
                            'profileurl': url,
                          });
                        });
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 2,
                              color: Colors.grey,
                            )),
                        padding: EdgeInsets.all(5),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/picture.png'),
                              fit: BoxFit.fitWidth,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Gallery',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        XFile? image = await _picker.pickImage(
                            source: ImageSource.camera, imageQuality: 40);
                        dynamic myFile = File(image!.path);
                        FirebaseStorage storage = FirebaseStorage.instance;
                        Reference ref = storage
                            .ref()
                            .child('users/Profile_Pics/${_currentUser.uid}');
                        UploadTask uploadTask = ref.putFile(myFile);
                        uploadTask.then((res) async {
                          String url = await res.ref.getDownloadURL();
                          print('this is url' + url);
                          await _currentUser.updatePhotoURL(url).then(
                                (_) => {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("Completed"),
                                  content: Text(
                                      "Your Profile has been successfully updated"),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: Text("Ok"),
                                    ),
                                  ],
                                ),
                              ),
                            },
                          );
                          print("This is updated url" + _currentUser.photoURL!);
                          FirebaseFirestore.instance
                              .collection('UsersData')
                              .doc(_currentUser.uid)
                              .set({
                            'profileurl': url,
                          });
                        });
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 2,
                              color: Colors.grey,
                            )),
                        padding: EdgeInsets.all(5),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/camera.png'),
                              fit: BoxFit.fitWidth,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Camera',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

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
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(_currentUser.photoURL!),
                          maxRadius: 20,
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
                          displayBottomSheet(context);
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(95, 105, 0, 0),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/camera.png'),
                                fit: BoxFit.scaleDown,
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
                        border: Border.all(color: Colors.blue, width: 1)),
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
                          onPressed: () {
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

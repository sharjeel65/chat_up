import 'package:chat_up/ChatCard.dart';
import 'package:chat_up/CurrentUserProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ChatroomCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:move_to_background/move_to_background.dart';
class UserHome extends StatefulWidget {
  final User? user;

  const UserHome({required this.user});

  @override
  State<UserHome> createState() => _UserHomeState();
}


class _UserHomeState extends State<UserHome> {
  late User? _currentUser;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  final _mFirestore = FirebaseFirestore.instance;
  bool extended = false;
  bool extended1 = false;

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:   () async {
        MoveToBackground.moveTaskToBack();
        return false;
      },
      child: Scaffold(
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
                    SizedBox(
                      width: double.maxFinite,
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CurrentUserProfile(
                                          user: _currentUser!,
                                        )));
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                child: Image.network(
                                  _currentUser!.photoURL!,
                                  fit: BoxFit.contain,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value:
                                            loadingProgress.expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
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
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Container(
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _currentUser!.displayName! ,
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Online',
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/setting (1).png'),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    //Second Row Started
                    Container(
                      height: 40,
                      width: double.infinity,
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFE2EDFC),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          height: 35,
                          width: 245,
                          child: Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(2, 1, 0, 0),
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/search (2).png'),
                                  ),
                                ),
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(40, 0, 0, 10),
                                  hintText: 'Search Chat Rooms',
                                  hintStyle: TextStyle(
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(200, 5, 0, 0),
                                height: 25,
                                width: 30,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/edit.png'))),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //3rd row started
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (null),
                            child: Text(
                              'Recents',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (null),
                            child: Text(
                              'All',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //4th row started
                    !extended1
                        ? Container(
                            width: double.infinity,
                            height: extended ? 500 : 250,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: _mFirestore.collection('friends').doc(_currentUser!.uid).collection(_currentUser!.uid).snapshots(),
                        builder: (context, snapshots) {
                          if (snapshots.hasData) {
                            return ListView.builder(
                              itemCount: snapshots.data!.docs.length,
                              itemBuilder: (context, index) {
                                QueryDocumentSnapshot<Object?>? doc =
                                snapshots.data?.docs[index];
                                return ChatCard(data: doc, index: index,);
                              },
                            );
                          } else {
                            return Center(
                              child: Text(
                                'Data not available',
                              ),
                            );
                          }
                        },
                      ),
                          )
                        : Container(
                            width: double.infinity,
                            height: 10,
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          ),
                    //5th Row started
                    GestureDetector(
                      onTap: () {
                        if (!extended) {
                          setState(() {
                            extended = true;
                            extended1 = false;
                          });
                        } else {
                          setState(() {
                            extended = false;
                          });
                        }
                      },
                      child: Container(
                        color: Colors.black12,
                        width: double.infinity,
                        height: 20,
                        child: Center(
                          child: Icon(
                            !extended
                                ? CupertinoIcons.arrow_down
                                : CupertinoIcons.arrow_up,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    //6th row started
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (null),
                            child: Text(
                              'Recents',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (null),
                            child: Text(
                              'All',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (!extended1) {
                          setState(
                            () {
                              extended1 = true;
                            },
                          );
                        } else {
                          setState(
                            () {
                              extended1 = false;
                            },
                          );
                        }
                      },
                      child: Container(
                        color: Colors.black12,
                        width: double.infinity,
                        height: 20,
                        child: Center(
                          child: Icon(
                            !extended1
                                ? CupertinoIcons.arrow_up
                                : CupertinoIcons.arrow_down,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    //7th row started
                    Container(
                      width: double.infinity,
                      height: !extended1 ? 250 : 450,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: _mFirestore.collection('chatrooms').snapshots(),
                        builder: (context, snapshots) {
                          if (snapshots.hasData) {
                            return ListView.builder(
                              itemCount: snapshots.data!.docs.length,
                              itemBuilder: (context, index) {
                                QueryDocumentSnapshot<Object?>? doc =
                                    snapshots.data?.docs[index];
                                return ChatroomCard(data: doc, index: index,);
                              },
                            );
                          } else {
                            return Center(
                              child: Text(
                                'Data not available',
                              ),
                            );
                          }
                        },
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

import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_up/Services/image_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:time_elapsed/time_elapsed.dart';
import '../Services/Validator.dart';

class UserSingleChat extends StatefulWidget {
  final QueryDocumentSnapshot<Object?>? data;

  const UserSingleChat(
      {Key? key, required this.userID1, required this.UID, required this.data})
      : super(key: key);
  final String userID1;
  final String UID;

  @override
  State<UserSingleChat> createState() => _UserSingleChatState();
}

class _UserSingleChatState extends State<UserSingleChat> {
  final _focusmessage = FocusNode();
  final messageController = TextEditingController();
  late ScrollController _scrollController;
  GlobalKey<FormState> _MessageFormKey = GlobalKey<FormState>();
  var UID;
  final User _user = FirebaseAuth.instance.currentUser!;
  late String userid1;
  late String userid2;
  bool friendchatdbvalue = true;
  bool friendchatdbvalue2 = true;

  String ChatName() {
    var chatName =
        'chat${userid1.compareTo(userid2) < 0 ? '$userid1$userid2' : '$userid2$userid1'}';
    return chatName;
  }

  late DocumentSnapshot snapshot;
  late QueryDocumentSnapshot<Object?>? doc1;

  Future<void> getFriends() async {
    var data = await FirebaseFirestore.instance
        .collection('friends')
        .doc(_user.uid)
        .collection(_user.uid)
        .doc(ChatName())
        .get();
    if (!data.exists) {
      FirebaseFirestore.instance
          .collection('friends')
          .doc(_user.uid)
          .collection(_user.uid)
          .doc(ChatName())
          .set(
        {
          'ChatroomName': ChatName(),
          'To': UID,
          'idTo': userid1,
          'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
          'name': _user.displayName,
          'friendship': false
        },
      );
      if (kDebugMode) {
        print('getFriends function is executing$friendchatdbvalue');
      }
      friendchatdbvalue = false;
    }
  }

  Future<void> InitializeFriend() async {
    var data = await FirebaseFirestore.instance
        .collection('friends')
        .doc(userid1)
        .collection(userid1)
        .doc(ChatName())
        .get();
    if (!data.exists) {
      FirebaseFirestore.instance
          .collection('friends')
          .doc(userid1)
          .collection(userid1)
          .doc(ChatName())
          .set(
        {
          'ChatroomName': ChatName(),
          'To': _user.displayName,
          'idTo': _user.uid,
          'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
        },
      );
      if (kDebugMode) {
        print('Initialize Friends function is executing$friendchatdbvalue2');
      }
      friendchatdbvalue2 = false;
    }
  }

  bool imageuploadloading = false;
  bool imageBool = false;
  final ImagePicker _picker = ImagePicker();
  late String URL;
  dynamic imagePath;
  void displayBottomSheet(BuildContext context) async {
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
                        setState(() {
                          imageuploadloading = true;
                        });
                        XFile? image = await _picker.pickImage(
                            source: ImageSource.gallery, imageQuality: 40);
                        dynamic myFile = File(image!.path);
                        imagePath = myFile;
                        print("this is imagepath" + imagePath.toString());
                        imageBool = true;
                        setState(() {
                          imageuploadloading = false;
                        });
                        Navigator.pop(context);
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
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/picture.png'),
                              fit: BoxFit.fitWidth,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      'Gallery',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          imageuploadloading = true;
                        });
                        XFile? image = await _picker.pickImage(
                            source: ImageSource.camera, imageQuality: 40);
                        dynamic myFile = File(image!.path);
                        imagePath = myFile;
                        imageBool = true;
                        setState(() {
                          imageuploadloading = false;
                        });
                        Navigator.pop(context);
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
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/camera.png'),
                              fit: BoxFit.fitWidth,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      'Camera',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    UID = widget.UID;
    userid1 = widget.userID1;
    userid2 = _user.uid;
    doc1 = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusmessage.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('UsersData')
                          .doc(doc1?.get('idTo'))
                          .get(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircleAvatar(
                            backgroundColor: Colors.black12,
                          );
                        } else {
                          return CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                                snapshot.data.get('profileurl').toString()),
                            maxRadius: 20,
                          );
                        }
                      }),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          UID,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        StreamBuilder(
                            stream: FirebaseDatabase.instance
                                .ref()
                                .child("presence/$userid1")
                                .onValue,
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text('Fetching Data');
                              } else if (snapshot.hasData) {
                                var data = snapshot.data.snapshot.value;
                                return Text(data['connections'] == null
                                    ? TimeElapsed.fromDateStr(DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                        data['lastOnline'])
                                                .toString()) ==
                                            'Now'
                                        ? 'Few seconds ago'
                                        : '${TimeElapsed.fromDateStr(DateTime.fromMillisecondsSinceEpoch(data['lastOnline']).toString())} ago'
                                    : 'online');
                                //return Text(snapshot.data.get('online') ? 'Online' : TimeElapsed.fromDateStr(DateTime.fromMillisecondsSinceEpoch(int.parse(snapshot.data.get('lastseen'))).toString())+' ago');
                              } else {
                                return Text('no data');
                              }
                            }),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.settings,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('chats')
                    .doc(ChatName())
                    .collection(ChatName())
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshots) {
                  if (snapshots.hasData) {
                    return ListView.builder(
                      controller: _scrollController,
                      reverse: true,
                      itemCount: snapshots.data!.docs.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      itemBuilder: (context, index) {
                        QueryDocumentSnapshot<Object?>? doc =
                            snapshots.data?.docs[index];
                        return Container(
                          margin: EdgeInsets.all(10),
                          child: doc?.get('idFrom') == _user.uid
                              ? doc?.get('type') == 'Text'
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          constraints: BoxConstraints(
                                            maxWidth: 370,
                                            maxHeight: 800,
                                            minHeight: 40,
                                            minWidth: 50,
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.blue.shade100),
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            doc?.get('content'),
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          constraints: BoxConstraints(
                                            maxWidth: 280,
                                            maxHeight: 200,
                                            minHeight: 40,
                                            minWidth: 50,
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.blue.shade100),
                                          padding: EdgeInsets.all(10),
                                          child: GestureDetector(
                                            onTap: () {
                                              ViewImage.showCustomDialog(
                                                  context, doc?.get('content'));
                                              print('tapped');
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              color: Colors.yellow,
                                              child: CachedNetworkImage(
                                                imageUrl: doc?.get('content'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                              : //else material
                              Column(
                                  children: [
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            print('tapped');
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Dialog(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0)),
                                                        //this right here
                                                        child: Center(
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5),
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width -
                                                                150,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height -
                                                                550,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Flexible(
                                                                  flex: 1,
                                                                  fit: FlexFit
                                                                      .loose,
                                                                  child:
                                                                      GestureDetector(
                                                                    // onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserSingleChat()));},
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      height: double
                                                                          .infinity,
                                                                      margin: EdgeInsets
                                                                          .fromLTRB(
                                                                              10,
                                                                              15,
                                                                              2,
                                                                              1),
                                                                      color: Colors
                                                                          .white,
                                                                      child:
                                                                          Text(
                                                                        'View Profile',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          color:
                                                                              Colors.black,
                                                                          fontFamily:
                                                                              'Google Sans',
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Flexible(
                                                                  flex: 1,
                                                                  fit: FlexFit
                                                                      .loose,
                                                                  child:
                                                                      GestureDetector(
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      height: double
                                                                          .infinity,
                                                                      margin: EdgeInsets
                                                                          .fromLTRB(
                                                                              10,
                                                                              15,
                                                                              2,
                                                                              1),
                                                                      color: Colors
                                                                          .white,
                                                                      child:
                                                                          Text(
                                                                        'Add Friend',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          color:
                                                                              Colors.black,
                                                                          fontFamily:
                                                                              'Google Sans',
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Flexible(
                                                                  flex: 1,
                                                                  fit: FlexFit
                                                                      .loose,
                                                                  child:
                                                                      GestureDetector(
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      height: double
                                                                          .infinity,
                                                                      margin: EdgeInsets
                                                                          .fromLTRB(
                                                                              10,
                                                                              15,
                                                                              2,
                                                                              1),
                                                                      color: Colors
                                                                          .white,
                                                                      child:
                                                                          Text(
                                                                        'Block',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          color:
                                                                              Colors.black,
                                                                          fontFamily:
                                                                              'Google Sans',
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )),
                                                  );
                                                });
                                          },
                                          child: Container(
                                            constraints: BoxConstraints(
                                              maxHeight: 40,
                                              maxWidth: 40,
                                              minHeight: 30,
                                              minWidth: 30,
                                            ),
                                            child: FutureBuilder(
                                                future: FirebaseFirestore
                                                    .instance
                                                    .collection('UsersData')
                                                    .doc(doc1?.get('idTo'))
                                                    .get(),
                                                builder: (context,
                                                    AsyncSnapshot snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return CircleAvatar(
                                                      backgroundColor:
                                                          Colors.black12,
                                                      child: Container(
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                    );
                                                  } else {
                                                    return CircleAvatar(
                                                      backgroundImage:
                                                          CachedNetworkImageProvider(
                                                              snapshot.data
                                                                  .get(
                                                                      'profileurl')
                                                                  .toString()),
                                                      maxRadius: 20,
                                                    );
                                                  }
                                                }),
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(10, 25, 0, 0),
                                          constraints: BoxConstraints(
                                            minWidth: 60,
                                            maxWidth: 100,
                                            minHeight: 30,
                                            maxHeight: 40,
                                          ),
                                          child: Text(
                                            doc?.get('name'),
                                            style: TextStyle(
                                              color: Colors.blueGrey.shade700,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: doc?.get('type') == 'Text'
                                          ? Container(
                                              constraints: BoxConstraints(
                                                maxWidth: 370,
                                                maxHeight: 800,
                                                minHeight: 40,
                                                minWidth: 50,
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.grey.shade200),
                                              padding: EdgeInsets.all(10),
                                              child: Text(
                                                doc?.get('content'),
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            )
                                          : Container(
                                              constraints: BoxConstraints(
                                                maxWidth: 280,
                                                maxHeight: 200,
                                                minHeight: 40,
                                                minWidth: 50,
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.blue.shade100),
                                              padding: EdgeInsets.all(10),
                                              child: GestureDetector(
                                                onTap: () {
                                                  ViewImage.showCustomDialog(
                                                      context,
                                                      doc?.get('content'));
                                                  print('tapped');
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  color: Colors.yellow,
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        doc?.get('content'),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text(
                        'No messages',
                      ),
                    );
                  }
                },
              ),
            ),
            Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                    height: 60,
                    width: double.infinity,
                    color: Colors.white,
                    child: Form(
                      key: _MessageFormKey,
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () async {
                              displayBottomSheet(context);
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: !imageBool
                                ? TextFormField(
                                    validator: (value) =>
                                        Validator.validateMessage(
                                            message: value),
                                    focusNode: _focusmessage,
                                    controller: messageController,
                                    decoration: InputDecoration(
                                      hintText: "Write message...",
                                      hintStyle:
                                          TextStyle(color: Colors.black54),
                                      border: InputBorder.none,
                                      errorStyle: TextStyle(
                                        height: 1,
                                        fontSize: 12,
                                      ),
                                      errorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 35,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        border:
                                            Border.all(color: Colors.black26)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Send Image',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Icon(
                                          Icons.image,
                                          size: 30,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                imageBool = false;
                                                imagePath = null;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.cancel,
                                              color: Colors.red,
                                            )),
                                      ],
                                    ),
                                  ),
                          ),
                          FloatingActionButton(
                            onPressed: () async {
                              if (!imageBool) {
                                if (_MessageFormKey.currentState!.validate()) {
                                  FirebaseFirestore.instance
                                      .collection('chats')
                                      .doc(ChatName())
                                      .collection(ChatName())
                                      .doc(DateTime.now()
                                          .millisecondsSinceEpoch
                                          .toString())
                                      .set(
                                    {
                                      'idFrom': _user.uid,
                                      'idTo': userid1,
                                      'timestamp': DateTime.now()
                                          .millisecondsSinceEpoch
                                          .toString(),
                                      'content': messageController.text,
                                      'type': 'Text',
                                      'name': _user.displayName,
                                    },
                                  );
                                  messageController.clear();
                                  _scrollController.animateTo(
                                      _scrollController
                                          .position.minScrollExtent,
                                      duration:
                                          const Duration(milliseconds: 1000),
                                      curve: Curves.easeInOut);
                                }
                              } else {
                                FirebaseStorage storage =
                                    FirebaseStorage.instance;
                                Reference ref = storage.ref().child(
                                    'users/chats/${ChatName()}/${DateTime.now().millisecondsSinceEpoch}');
                                UploadTask uploadTask = ref.putFile(imagePath);
                                uploadTask.then((res) async {
                                  String url = await res.ref.getDownloadURL();
                                  if (kDebugMode) {
                                    print('this is url$url');
                                  }
                                  URL = url;
                                }).then((_) => {
                                      FirebaseFirestore.instance
                                          .collection('chats')
                                          .doc(ChatName())
                                          .collection(ChatName())
                                          .doc(DateTime.now()
                                              .millisecondsSinceEpoch
                                              .toString())
                                          .set(
                                        {
                                          'idFrom': _user.uid,
                                          'idTo': userid1,
                                          'timestamp': DateTime.now()
                                              .millisecondsSinceEpoch
                                              .toString(),
                                          'content': URL,
                                          'type': 'Image',
                                          'name': _user.displayName,
                                        },
                                      )
                                    });
                              }
                              if (friendchatdbvalue) {
                                getFriends();
                              }
                              if (friendchatdbvalue2) {
                                InitializeFriend();
                              }
                              setState(() {
                                imageBool = false;
                              });
                            },
                            backgroundColor: Colors.blue,
                            elevation: 0,
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

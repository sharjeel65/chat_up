import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Validator.dart';
import 'dart:async';
class UserSingleChat extends StatefulWidget {
  const UserSingleChat({Key? key,required this.userID1, required this.UID}) : super(key: key);
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
  String ChatName(){
    var chatName = 'chat${userid1.compareTo(userid2) < 0 ? '$userid1$userid2' : '$userid2$userid1'}';
    return chatName;
  }
  late DocumentSnapshot snapshot;
  Future<void> getFriends()async {
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
          'timestamp': DateTime
              .now()
              .millisecondsSinceEpoch
              .toString(),
          'name': _user.displayName,
          'friendship': false
        },
      );
      print('getFriends function is executing' +friendchatdbvalue.toString());
      friendchatdbvalue = false;
    }
  }
  Future<void> InitializeFriend()async {
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
          'timestamp': DateTime
              .now()
              .millisecondsSinceEpoch
              .toString(),
        },
      );
      print('Initialize Friends function is executing' +friendchatdbvalue2.toString());
      friendchatdbvalue2 = false;
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    UID = widget.UID;
    userid1 = widget.userID1;
    userid2 = _user.uid;
  }

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
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
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        _user.photoURL!),
                    maxRadius: 20,
                  ),
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
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Online",
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 13),
                        ),
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
              child: Container(
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
                                ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                    maxWidth: 380,
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
                            ) ://else material
                            Column(
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        print('tapped');
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return GestureDetector(
                                                onTap: (){
                                                  Navigator.of(context).pop();
                                                },
                                                child: Dialog(
                                                    backgroundColor: Colors.transparent,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(20.0)), //this right here
                                                    child: Center(
                                                      child: Container(
                                                        padding: EdgeInsets.all(5),
                                                        width: MediaQuery.of(context).size.width -150,
                                                        height: MediaQuery.of(context).size.height -  550,
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Flexible(
                                                              flex: 1,
                                                              fit: FlexFit.loose,
                                                              child: GestureDetector(
                                                               // onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserSingleChat()));},
                                                                child: Container(width:double.infinity,height: double.infinity,margin:EdgeInsets.fromLTRB(10, 15, 2, 1),color: Colors.white,child:  Text(
                                                                  'View Profile',
                                                                  style: TextStyle(
                                                                    fontSize: 20,
                                                                    color: Colors.black,
                                                                    fontFamily: 'Google Sans',
                                                                  ),
                                                                ),),
                                                              ),
                                                            ),
                                                            Flexible(
                                                              flex: 1,
                                                              fit: FlexFit.loose,
                                                              child: GestureDetector(
                                                                child: Container(width:double.infinity,height: double.infinity,margin:EdgeInsets.fromLTRB(10, 15, 2, 1),color: Colors.white,child:  Text(
                                                                  'Add Friend',
                                                                  style: TextStyle(
                                                                    fontSize: 20,
                                                                    color: Colors.black,
                                                                    fontFamily: 'Google Sans',
                                                                  ),
                                                                ),),
                                                              ),
                                                            ),
                                                            Flexible(
                                                              flex: 1,
                                                              fit: FlexFit.loose,
                                                              child: GestureDetector(
                                                                child: Container(width:double.infinity,height: double.infinity,margin:EdgeInsets.fromLTRB(10, 15, 2, 1),color: Colors.white,child:  Text(
                                                                  'Block',
                                                                  style: TextStyle(
                                                                    fontSize: 20,
                                                                    color: Colors.black,
                                                                    fontFamily: 'Google Sans',

                                                                  ),
                                                                ),),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                ),
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
                                        child: Image.network(
                                          _user.photoURL!,
                                          fit: BoxFit.contain,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent? loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress
                                                    .expectedTotalBytes !=
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
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(10, 25, 0, 0),
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
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth: 380,
                                      maxHeight: 800,
                                      minHeight: 40,
                                      minWidth: 50,
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.grey.shade200),
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      doc?.get('content'),
                                      style: TextStyle(fontSize: 15),
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
                            onTap: () {},
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
                            child: TextFormField(
                              validator: (value) =>
                                  Validator.validateMessage(message: value),
                              focusNode: _focusmessage,
                              controller: messageController,
                              decoration: InputDecoration(
                                hintText: "Write message...",
                                hintStyle: TextStyle(color: Colors.black54),
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
                            ),
                          ),
                          FloatingActionButton(
                            onPressed: () async {
                              if(_MessageFormKey.currentState!.validate()){
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
                                    _scrollController.position.minScrollExtent,
                                    duration: const Duration(milliseconds: 1000),
                                    curve: Curves.easeInOut);
                              }
                              if(friendchatdbvalue){
                                getFriends();
                              }
                              if(friendchatdbvalue2){
                                InitializeFriend();
                              }
                            },
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 18,
                            ),
                            backgroundColor: Colors.blue,
                            elevation: 0,
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

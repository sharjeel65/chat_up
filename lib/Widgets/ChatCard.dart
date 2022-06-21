import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_elapsed/time_elapsed.dart';
import '../Screens/UserSingleChat.dart';

class ChatCard extends StatefulWidget {
  QueryDocumentSnapshot<Object?>? data;
  late int index;

  ChatCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  late QueryDocumentSnapshot<Object?>? doc;
  late String ChatroomID = doc!.reference.id;
  var stringtimestampfromfirebase;
  var inttimestampfromfirebase;
  late int timestamp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doc = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => UserSingleChat(
              UID: doc!.get('To'),
              userID1: doc?.get('idTo'),
              data: doc!,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(8, 0, 8, 10),
        decoration: BoxDecoration(
          color: Color(0xFFF5F7F9),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(1, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.black12,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('UsersData')
                        .doc(doc?.get('idTo'))
                        .get(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                            color: Colors.transparent,
                            child: Center(
                                child: CircularProgressIndicator(
                              strokeWidth: 3,
                            )));
                      } else {
                        return StreamBuilder(
                            stream: FirebaseDatabase.instance
                                .ref()
                                .child("presence/" + doc?.get('idTo'))
                                .onValue,
                            builder: (context, AsyncSnapshot snapshots) {
                              if (snapshots.connectionState ==
                                  ConnectionState.waiting) {
                                return Text('Fetching Data');
                              } else if (snapshots.hasData) {
                                var data = snapshots.data.snapshot.value;
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: data['connections'] == null
                                            ? Colors.red
                                            : Colors.green,
                                        width: 1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: CircleAvatar(
                                    backgroundImage: CachedNetworkImageProvider(snapshot.data
                                        .get('profileurl')
                                        .toString()),
                                    maxRadius: 20,
                                    backgroundColor: Colors.grey,
                                  ),
                                );
                                //return Text(snapshot.data.get('online') ? 'Online' : TimeElapsed.fromDateStr(DateTime.fromMillisecondsSinceEpoch(int.parse(snapshot.data.get('lastseen'))).toString())+' ago');
                              } else {
                                return Text('no data');
                              }
                            }); /*;*/
                      }
                    }),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: Container(
                        width: double.infinity,
                        child: Text(
                          doc!.get('To'),
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      flex: 3,
                      child: Container(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('chats')
                              .doc(doc!.get('ChatroomName'))
                              .collection(doc!.get('ChatroomName'))
                              .orderBy('timestamp', descending: true)
                              .limit(1)
                              .snapshots(),
                          builder: (context, snapshots) {
                            if (snapshots.hasData) {
                              QueryDocumentSnapshot<Object?>? doc1 =
                                  snapshots.data?.docs[0];
                              return Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      child: Text(
                                        doc1?.get('content') != null
                                            ? doc1?.get('content')
                                            : 'no messages',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: EdgeInsets.only(right: 5),
                                      width: double.infinity,
                                      child: Text(
                                        TimeElapsed.fromDateStr(DateTime
                                                        .fromMillisecondsSinceEpoch(
                                                            int.parse(doc1!.id))
                                                    .toString()) !=
                                                'Now'
                                            ? TimeElapsed.fromDateStr(DateTime
                                                        .fromMillisecondsSinceEpoch(
                                                            int.parse(doc1.id))
                                                    .toString()) +
                                                '  ago'
                                            : 'Seconds ago',
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10,
                                        ),
                                        textAlign: TextAlign.right,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
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
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

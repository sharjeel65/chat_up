import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_elapsed/time_elapsed.dart';
import 'UserSingleChat.dart';

class ChatCard extends StatefulWidget {
  QueryDocumentSnapshot<Object?>? data;
  late int index;

  ChatCard({Key? key, required this.data, required this.index})
      : super(key: key);

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  late int index;
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
    index = widget.index;
    int timestamp = DateTime.now().millisecondsSinceEpoch;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                UserSingleChat(
                  UID: doc!.get('To'), userID1: doc?.get('idTo'),
                )));
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(8, 0, 8, 5),
        decoration: BoxDecoration(
          color: Color(0xFFF5F7F9),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
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
                    image: DecorationImage(
                      image: AssetImage('assets/images/pic.png'),
                    )),
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
                    child: Row(
                      children: [
                      Expanded(
                      flex: 8,
                      child: Container(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection(
                              'chats').doc(doc!.get('ChatroomName')).collection(doc!.get('ChatroomName')).orderBy('timestamp', descending: true).limit(1).snapshots(),
                          builder: (context, snapshots) {
                            if (snapshots.hasData) {
                                  QueryDocumentSnapshot<Object?>? doc1 =
                                  snapshots.data?.docs[0];
                                  return Text(
                                    doc1?.get('content'),
                                    overflow: TextOverflow.ellipsis,
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
                    ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                        child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection(
                        'chats').doc(doc!.get('ChatroomName')).collection(doc!.get('ChatroomName')).orderBy('timestamp', descending: true).limit(1).snapshots(),
                    builder: (context, snapshots) {
                      if (snapshots.hasData) {
                        QueryDocumentSnapshot<Object?>? doc1 =
                        snapshots.data?.docs[0];
                        return Text(
                          TimeElapsed.fromDateStr(DateTime.fromMillisecondsSinceEpoch(int.parse(doc1!.id)).toString())+'  ago',
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w400,
                            fontSize: 10,

                          ),
                          overflow: TextOverflow.ellipsis,
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
            )
          ],
        ),
      ),
    )],
    )
    ,
    )
    ,
    );
  }
}

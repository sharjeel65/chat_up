import 'package:chat_up/ChatroomSinglechat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_elapsed/time_elapsed.dart';

class ChatroomCard extends StatefulWidget {
  QueryDocumentSnapshot<Object?>? data;
  late int index;

  ChatroomCard({Key? key, required this.data, required this.index})
      : super(key: key);

  @override
  State<ChatroomCard> createState() => _ChatroomCardState();
}

class _ChatroomCardState extends State<ChatroomCard> {
  late int index;
  late QueryDocumentSnapshot<Object?>? doc;
  late String ID = doc!.reference.id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doc = widget.data;
    index = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChatroomSingleChat(
              uid: doc?.reference.id,
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
                      flex: 3,
                      child: Container(
                        width: double.infinity,
                        child: Text(
                          doc!.reference.id,
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
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('chatrooms')
                              .doc(ID)
                              .collection(ID)
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
                                            ? doc1?.get('name') +
                                                ': ' +
                                                doc1?.get('content')
                                            : 'no messages',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      padding: EdgeInsets.only(right: 5),
                                      width: double.infinity,
                                      child: Text(
                                        TimeElapsed.fromDateStr(DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                        int.parse(doc1!.id))
                                                .toString()) +
                                            '  ago',
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10,
                                        ),
                                        textAlign: TextAlign.right,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            } else {
                              return Center(
                                child: Text(
                                  'Data not available',
                                ),
                              );
                            }
                          }),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

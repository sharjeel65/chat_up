import 'package:chat_up/ChatroomSinglechat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChatroomSingleChat(
                  uid: doc?.reference.id,
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
                        color: Colors.blue,
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
                      child: Container(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Container(
                                color: Colors.deepOrange,
                                child: Text(
                                  'message from firebase in real time nor snga e',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                color: Colors.blue,
                                width: double.infinity,
                                child: Text(
                                  '2 hours ago',
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
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
            )
          ],
        ),

        /*child: ListTile(
            dense: true,
            leading: CircleAvatar(
              minRadius: 16,
              maxRadius: 25,
              backgroundImage: AssetImage('assets/images/pic.png'),
            ),
            title: Text(
              'Khaperaii',
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Snga e zarhgiya',
              style: TextStyle(
                color: Colors.blueAccent,
                fontStyle: FontStyle.italic,
              ),
            ),
            trailing: Text(
              '2 minutes ago',
              style: TextStyle(
                color: Colors.black12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),*/
      ),
    );
  }
}

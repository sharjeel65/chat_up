import 'package:chat_up/singlechat.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatefulWidget {
  const ChatCard({Key? key}) : super(key: key);

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> singleChat(uid: 'uid',)));
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
                color: Colors.orange,
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        margin: EdgeInsets.only(right: 250),
                        color: Colors.blueAccent,
                        child: Center(
                          child: Text(
                            'Halak',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        color: Colors.green,
                        child: Row(
                          children: [
                            Expanded(flex: 5,
                              child: Container(
                                color: Colors.brown,
                                child: Text(
                                  'this is a message which will come from firebase in real time',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Expanded(flex: 1,
                              child: Container(
                                color: Colors.indigo,
                                child: Text(
                                  '2 hours ago',
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
            ),
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

import 'package:flutter/material.dart';

class ChatCard extends StatefulWidget {
  const ChatCard({Key? key}) : super(key: key);

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(8, 5, 8, 5),
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
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
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
      ),
    );
  }
}

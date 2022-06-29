import 'package:afariat/networking/json/conversation_json.dart';
import 'package:flutter/material.dart';

class ChatUser extends StatelessWidget {
  final Conversation conversation;
  final bool hasConversaton;
  final String email;

  ChatUser({this.conversation, this.hasConversaton = false, this.email});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    conversation.to.username == email
                        ? conversation.from.username
                        : conversation.to.username,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    conversation.message,
                    style: TextStyle(
                        fontWeight: conversation.read
                            ? FontWeight.normal
                            : FontWeight.bold),
                  ),
                ),
              ],
            ),
            if (hasConversaton)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                  child: Center(
                      child: Text(
                    conversation.totalUnreadMessagesCount.toString(),
                    style: TextStyle(color: Colors.white),
                  )),
                  height: 20,
                  width: 20,
                ),
              )
          ],
        ),
      ),
    );
  }
}

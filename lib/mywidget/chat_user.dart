import 'package:flutter/material.dart';

class ChatUser extends StatelessWidget {
  // final User user;
  // ChatUser(this.user);
  @override
  Widget build(BuildContext context) {
    return Container(
      color:Colors.white,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage("https://www.bu.edu/files/2019/09/are-kids-hardwired-for-revenge-1500x1000.jpg"),
            ),
            title: Text('message' ,style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text('message'),
          ),

        ],
      ),
    );
  }
}
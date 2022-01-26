import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import 'tap_chat_viewcontroller.dart';

class TapChatScr extends GetWidget<TapChatViewController> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    //
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Messagerie",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.deepOrange,
      ),
    );
  }
}

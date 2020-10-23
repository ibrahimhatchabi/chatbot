import 'package:chatbot/messageBox.dart';
import 'package:flutter/material.dart';

class Message extends StatefulWidget {

  String user;
  String sender;
  String txt;
  AnimationController animationController;
  bool isRequest;
  bool isSent;
  String dateAdd;
  String dateDel;
  int id;
  bool status;

  Message({
    this.user,
    this.sender,
    this.txt,
    this.animationController,
    this.isRequest,
    this.isSent,
    this.id,
    this.dateAdd,
    this.dateDel,
    this.status
  });

  Message.map(dynamic obj) {
    this.id = obj['id'];
    this.txt = obj['message'];
    this.sender = obj['sender'];
    this.user = obj['user'];
    this.isRequest = obj['sender'] != "bot";
    this.dateAdd = obj['dateAdd'];
    this.dateDel = obj['dateDel'];
    this.status = obj['status'] == 1;
  }

  @override
  MessageState createState() {
    return new MessageState();
  }
}

class MessageState extends State<Message> {
  
  @override
  Widget build(BuildContext context) {

    final List<String> u = widget.user.split(" ");
    final String prenom = u[0];
    String nom;

    if(u.length > 1){
      if(u[1] != '')
        nom = u[1];
      else
        nom = "Doe";
    } else {
      nom = "Doe";
    }

    String avatarID = prenom[0].toUpperCase()+nom[0].toUpperCase();

    return new SizeTransition(
      sizeFactor: new CurvedAnimation(
        parent: widget.animationController,
        curve: widget.isRequest
          ? Curves.easeOut
          : Curves.elasticOut
      ),
      axisAlignment: 0.0,
      child: new Container(
        margin: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 5.0
        ),
        child: new MessageBox(
          avatarID: avatarID,
          message: this.widget,
        )
      ),
    );
  }
}

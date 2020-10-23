import 'package:chatbot/chatPage.dart';
import 'package:chatbot/login.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'HR Atos',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.lightBlue
      ),
      home: new Chat(user: 'Ibuss'),
      //home: new Login(),
      //home: new Bubble(),
    );
  }
}

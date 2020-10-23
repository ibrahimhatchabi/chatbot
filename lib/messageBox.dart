import 'dart:math';

import 'package:chatbot/message.dart';
import 'package:flutter/material.dart';

class MessageBox extends StatelessWidget{

  final Message message;
  final String avatarID;

  MessageBox({
   this.message,
   this.avatarID,
  });

  @override
  Widget build(BuildContext context) {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: message.isRequest
          ?
      <Widget>[
        new Expanded(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              /*new Text(
                      user,
                      style: Theme.of(context).textTheme.subhead,
                    ),*/
              Container(
                padding: EdgeInsets.only(top: 5.0, right: 5.0),
                child: CustomPaint(
                  foregroundPainter: new queuPainter(message: message),
                  child: new Container(
                    padding: new EdgeInsets.all(8.0),
                    decoration: new BoxDecoration(
                      color: !message.isSent ? Colors.red.withOpacity(0.7) : Colors.grey,
                      /*boxShadow:
                        [
                          BoxShadow(
                            blurRadius: 1.0,
                          )
                        ],*/
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(0.0),
                        topLeft: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      )
                    ),
                    /*decoration: ShapeDecoration(
                      color: !message.isSent ? Colors.red.withOpacity(0.7) : Colors.white70,
                      shape: BeveledRectangleBorder(
                          borderRadius: new BorderRadius.only(
                            topRight: Radius.zero,
                            topLeft: new Radius.elliptical(10.0,10.0),
                            bottomLeft: new Radius.elliptical(10.0,10.0),
                            bottomRight: new Radius.elliptical(10.0,10.0),
                          )
                      ),
                      shadows:
                      [
                        BoxShadow(
                          blurRadius: 1.0,
                        )
                      ],
                    ),*/
                    margin: const EdgeInsets.only(top: 6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        new Text(
                          message.txt,
                          style: new TextStyle(
                            fontFamily: "LiberationSerif",
                            fontSize: 18.0,
                            color: Colors.white,
                            fontStyle: !message.isSent ? FontStyle.italic : FontStyle.normal
                          ),
                        ),
                        Container(
                          padding: new EdgeInsets.only(top: 5.0),
                          child: new Text(
                            message.dateAdd.substring(11,16),
                            style: new TextStyle(
                              fontFamily: 'bebas',
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 10.0,
                              fontStyle: !message.isSent ? FontStyle.italic : FontStyle.normal
                            ),
                          ),
                        ),
                      ]
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        /*new Container(
                padding: EdgeInsets.only(left: 5.0,top: 5.0),
                child: !widget.isSent
                    ? new Container(
                  width: 35.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey
                  ),
                  child: Center(child: Text("!")),
                )
                    : null,
              ),*/
        new Container(
          margin: const EdgeInsets.only(left: 8.0),
          child: new CircleAvatar(
            child: new Text(
              avatarID,
              style: new TextStyle(
                fontFamily: "LiberationSerif",
              ),
            ),
          ),
        ),
      ]

          :
      <Widget>[
        new Container(
          margin: const EdgeInsets.only(right: 5.0),
          child: new CircleAvatar(
            radius: 35.0,
            child: new Image.asset("images/operator3.png"),
            //child: new Text("HR"),
            backgroundColor: Colors.black12,
            foregroundColor: Colors.black,

          ),
        ),
        new Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 25.0),
            child: new ScaleTransition(
              scale: message.animationController,
              alignment: Alignment.topLeft,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /*new Text(
                            user,
                            style: Theme.of(context).textTheme.subhead,
                          ),*/
                  CustomPaint(
                    foregroundPainter: queuPainter(
                      message: message
                    ),
                    child: new Container(
                      padding: new EdgeInsets.all(8.0),
                      decoration: new BoxDecoration(
                        color: Colors.blue,
                        /*boxShadow:
                        [
                          BoxShadow(
                            blurRadius: 1.0,
                          )
                        ],*/
                        borderRadius: new BorderRadius.only(
                          topLeft: new Radius.circular(0.0),
                          topRight: new Radius.elliptical(20.0,20.0),
                          bottomLeft: new Radius.elliptical(20.0,20.0),
                          bottomRight: new Radius.elliptical(20.0,20.0),
                        )
                      ),
                      margin: const EdgeInsets.only(top: 6.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          new Text(
                            message.txt,
                            style: new TextStyle(
                              color: Colors.white,
                              fontFamily: "LiberationSerif",
                              fontSize: 18.0,
                            ),
                          ),
                          Container(
                            padding: new EdgeInsets.only(top: 5.0),
                            child: new Text(
                              message.dateAdd.substring(11,16),
                              style: new TextStyle(
                                fontFamily: 'bebas',
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 10.0,
                              ),
                            ),
                          ),
                        ]
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class queuPainter extends CustomPainter{

  final Message message;

  queuPainter({
    this.message,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawArc(
      new Rect.fromCircle(
        center: message.isRequest ? new Offset(size.width - 1.0, 9.0) : new Offset(2.0, 9.0),
        radius: 5.0,
      ),
      //message.isRequest ? (3 * pi) / 4 : (1 * pi) / 8,
      message.isRequest ? (0.64 * pi)  : (1 * pi) / 8,
      pi / 4,
      true,
      Paint()
        ..color = message.isRequest ? !message.isSent ? Colors.red.withOpacity(0.7) : Colors.grey : Colors.blue
        ..style = PaintingStyle.stroke
        ..strokeWidth = 8.0
        ..strokeCap = StrokeCap.round
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
  
}

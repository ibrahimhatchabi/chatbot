import 'dart:ui';

import 'package:flutter/material.dart';

class Bubble extends StatefulWidget {
  @override
  _BubbleState createState() => new _BubbleState();
}

class _BubbleState extends State<Bubble> with SingleTickerProviderStateMixin{

  AnimationController animationController;
  Animation delayedAnimation1,delayedAnimation2,delayedAnimation3;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    delayedAnimation1 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.0, 0.3, curve: Curves.easeInOut)
      )
    );

    delayedAnimation2 = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: animationController,
            curve: Interval(0.3, 0.6, curve: Curves.fastOutSlowIn)
        )
    );

    delayedAnimation3 = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: animationController,
            curve: Interval(0.6, 1.0, curve: Curves.fastOutSlowIn)
        )
    );

    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child){
        return new Row(
          children: <Widget>[
            Container(
              padding: new EdgeInsets.all(3.0),
              child: Container(
                /*width: lerpDouble(25.0, 15.0, animationController.value),
                height: lerpDouble(25.0, 15.0, animationController.value),*/
                width: (delayedAnimation1.value * 5.0 + 5.0) - (delayedAnimation2.value * 5.0),
                height: (delayedAnimation1.value * 5.0 + 5.0) - (delayedAnimation2.value * 5.0),
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                  boxShadow:
                  [
                    BoxShadow(
                      blurRadius: 0.7,
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: new EdgeInsets.all(3.0),
              child: Container(
                /*width: lerpDouble(15.0, 25.0, animationController.value),
                height: lerpDouble(15.0, 25.0, animationController.value),*/
                width: (delayedAnimation2.value * 5.0 + 5.0) - (delayedAnimation3.value * 5.0),
                height: (delayedAnimation2.value * 5.0 + 5.0) - (delayedAnimation3.value * 5.0),
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                  boxShadow:
                  [
                    BoxShadow(
                      blurRadius: 0.7,
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: new EdgeInsets.all(3.0),
              child: Container(
                /*width: lerpDouble(25.0, 15.0, animationController.value),
                height: lerpDouble(25.0, 15.0, animationController.value),*/
                width: (delayedAnimation3.value * 5.0 + 5.0) ,//- (delayedAnimation1.value * 5.0),
                height: (delayedAnimation3.value * 5.0 + 5.0),// - (delayedAnimation1.value * 5.0),
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                  boxShadow:
                  [
                    BoxShadow(
                      blurRadius: 0.7,
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
    /*return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Container(
            height: 5.0,
            width: 100.0,
            child: new LinearProgressIndicator()
          ),
        ),
      ),
    );*/
  }
}

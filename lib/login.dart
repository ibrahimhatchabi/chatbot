import 'package:chatbot/ChatPage.dart';
import 'package:chatbot/message.dart';
import 'package:chatbot/dataBase/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

var db = new DatabaseHelper();

class Login extends StatefulWidget {

  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  Animation animation, delayedAnimation1, delayedAnimation2, delayedAnimation3;
  AnimationController animationController;
  bool isDasObscure = true;
  bool isPassWordObscure = true;

  final TextEditingController _textController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(duration: Duration(seconds: 2), vsync: this);

    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn
    ));

    delayedAnimation1 = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.4, 1.0, curve: Curves.fastOutSlowIn)
      )
    );

    delayedAnimation2 = Tween(begin: -1.0, end: 0.0).animate(
        CurvedAnimation(
            parent: animationController,
            curve: Interval(0.6, 1.0, curve: Curves.fastOutSlowIn)
        )
    );

    delayedAnimation3 = Tween(begin: -1.0, end: 0.0).animate(
        CurvedAnimation(
            parent: animationController,
            curve: Interval(0.6, 1.0, curve: Curves.elasticInOut)
        )
    );

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return Scaffold(
          body: new Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: [
                  Colors.lightBlue,
                  Colors.blue,
                  const Color(0xFF0266a2)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            ),
            child: new Center(
              child: new ListView(
                children: <Widget>[
                  new Transform(
                    transform: Matrix4.translationValues(0.0, animation.value * height, 0.0 ),
                    child: new Container(
                      margin: new EdgeInsets.only(top: 50.0),
                      width: 120.0,
                      height: 80.0,
                      child: new Image.asset(
                        "images/hratos_t.png",
                        color: Colors.white,
                      ),
                    ),
                  ),
                  new Transform(
                    transform: Matrix4.translationValues(0.0, delayedAnimation1.value * height, 0.0 ),
                    child: new Column(
                      children: <Widget>[
                        new SizedBox(height: 30.0,),
                        new Icon(
                          Icons.person,
                          size: 40.0,
                          color: Colors.white,
                        ),
                        new Center(
                          child: new Text(
                            "DAS",
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontFamily: 'bebas'
                            ),
                          ),
                        ),
                        new Center(
                          child: new Text(
                            "Authentication",
                            style: new TextStyle(
                              letterSpacing: 1.0,
                              color: Colors.white,
                              fontSize: 20.0,
                              fontFamily: 'bebas'
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Transform(
                    transform: Matrix4.translationValues(0.0, delayedAnimation2.value * height, 0.0 ),
                    child: Column(
                      children: <Widget>[
                        new Container(height: 20.0,),
                        new Center(
                          child: new Column(
                            children: <Widget>[
                              new Container(
                                margin: new EdgeInsets.only(top: 20.0, right: 50.0, left: 50.0, ),
                                decoration: new BoxDecoration(
                                  //color: Theme.of(context).cardColor,
                                  color: Colors.white,
                                  borderRadius: new BorderRadius.all(new Radius.circular(2.0))
                                ),
                                child: new IconTheme(
                                  data: new IconThemeData(
                                      color: Theme.of(context).accentColor
                                  ),
                                  child: new Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 9.0,
                                    ),
                                    child: new Row(
                                      children: <Widget>[
                                        new Flexible(
                                          child: new TextField(
                                            controller: _textController,
                                            /*onChanged: (String txt){
                                              setState(() {
                                                _isWriting = txt.length > 0;
                                              });
                                            },*/
                                            //onSubmitted: _submitMsg,
                                            decoration: new InputDecoration.collapsed(
                                                hintText: "Username"
                                            ),
                                            style: new TextStyle(
                                              fontFamily: "LiberationSerif",
                                              color: Colors.black,
                                            ),
                                            obscureText: false,
                                          )
                                        ),
                                        SizedBox(
                                          height: 40.0,
                                        )
                                        /*new Container(
                                          child: new InkWell(
                                            child: new Container(
                                              child: new Icon(
                                                Icons.remove_red_eye,
                                                color: isDasObscure ? Colors.grey : Colors.blue,
                                              ),
                                              height: 40.0,
                                            ),
                                            onTap: (){
                                              setState(() {
                                                if(isDasObscure){
                                                  isDasObscure = false;
                                                } else{
                                                  isDasObscure = true;
                                                }
                                              });
                                            },
                                          ),
                                        ),*/
                                      ],
                                    ),
                                  )
                                ),
                              ),
                              new Container(
                                margin: new EdgeInsets.only(top: 20.0,bottom: 20.0, right: 50.0, left: 50.0),
                                decoration: new BoxDecoration(
                                  //color: Theme.of(context).cardColor,
                                  color: Colors.white,
                                  borderRadius: new BorderRadius.all(new Radius.circular(2.0))
                                ),
                                child: new IconTheme(
                                  data: new IconThemeData(
                                      color: Theme.of(context).accentColor
                                  ),
                                  child: new Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 9.0,
                                    ),
                                    child: new Row(
                                      children: <Widget>[
                                        new Flexible(
                                          child: new TextField(
                                            /*controller: _textController,
                                      onChanged: (String txt){
                                        setState(() {
                                          _isWriting = txt.length > 0;
                                        });
                                      },*/
                                            //onSubmitted: _submitMsg,
                                            decoration: new InputDecoration.collapsed(
                                              hintText: "Password ",
                                            ),
                                            style: new TextStyle(
                                              fontFamily: "LiberationSerif",
                                              color: Colors.black,
                                            ),
                                            obscureText: isPassWordObscure,
                                          ),
                                        ),
                                        new Container(
                                          child: new InkWell(
                                            child: new Container(
                                              child: new Icon(
                                                Icons.remove_red_eye,
                                                color: isPassWordObscure ? Colors.grey : Colors.blue,
                                              ),
                                              height: 40.0,
                                            ),
                                            onTap: (){
                                              setState(() {
                                                if(isPassWordObscure){
                                                  isPassWordObscure = false;
                                                } else{
                                                  isPassWordObscure = true;
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ),
                              )
                            ],
                          ),
                        ),
                        new Container(
                          height: 50.0,
                          width: double.infinity,
                          margin: new EdgeInsets.only(top: 20.0,bottom: 20.0, right: 50.0, left: 50.0),
                          decoration: new BoxDecoration(
                            //color: Theme.of(context).cardColor,
                              color: Colors.tealAccent,
                              borderRadius: new BorderRadius.all(new Radius.circular(4.0))
                          ),
                          child: new Material(
                            color: Colors.transparent,
                            child: new InkWell(
                              splashColor: Colors.teal,
                              child: new Center(
                                child: new Text(
                                  "LOGIN",
                                  style: new TextStyle(
                                    fontFamily: "bebas",
                                    letterSpacing: 1.0,
                                    color: Colors.white,
                                    fontSize: 20.0
                                  ),
                                ),
                              ),
                              onTap: () async {
                                if(_textController.text.length > 0){
                                  /*List<Map> recupMessages = await db.recupMsg();
                                  List<Message> messages = <Message>[];

                                  if(recupMessages != null){
                                    for (final msg in recupMessages) {
                                      messages.add(Message.map(msg));
                                    }
                                  }
                                  print('----------------- ${recupMessages.toString()}');
                                  print('----------------- ${messages.toString()}');*/
                                  //print("!!!!!!!!!!!!!!!!!!!! Im tapped !!!!!!!!!!!!!!!!!!");
                                  String me = _textController.text;
                                  _textController.clear();
                                  Navigator.of(context)
                                    ..push(new MaterialPageRoute(
                                      builder: (BuildContext context) => new Chat(
                                        //messages: recupMessages != null ? messages : null,
                                        user: me,
                                      )
                                    ));
                                } else {
                                  Navigator.push(context, new MaterialPageRoute(
                                    builder: (BuildContext context) => new Scaffold(
                                      backgroundColor: Colors.blue,
                                      appBar: new AppBar(
                                        backgroundColor: Colors.transparent,
                                        elevation: 0.0,
                                        automaticallyImplyLeading: false,
                                        title: new Center(
                                          child: new Image.asset("images/hratos_t.png",color: Colors.white,),
                                        ),
                                      ),
                                      body: new Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          new AlertDialog(
                                            title: new Text("Erreur"),
                                            content: new SingleChildScrollView(
                                              child: new ListBody(
                                                children: <Widget>[
                                                  new Text(
                                                    "Veuillez saisir le nom d'utilisateur dans le champs DAS !!!",
                                                    //style: _myAlertDialogTextStyle,
                                                  )
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              new FlatButton(
                                                child: new Text(
                                                  "OK",
                                                  //style: _myAlertDialogTextStyle,
                                                ),
                                                onPressed: () {
                                                  //exit(0);
                                                  Navigator.of(context)
                                                    ..pop();
                                                },
                                              )
                                            ],
                                          )
                                        ]
                                      )
                                    )
                                  ));
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height - 570.0 ,
                  ),
                  new Transform(
                    transform: Matrix4.translationValues(0.0, delayedAnimation3.value * height, 0.0 ),
                    child: new Container(
                     margin: new EdgeInsets.only(bottom: 10.0),
                      width: 60.0,
                      height: 30.0,
                      child: new Image.asset(
                        "images/byatos.png",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
  }
}

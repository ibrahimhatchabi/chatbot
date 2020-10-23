import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chatbot/message.dart';
import 'package:chatbot/dataBase/database_helper.dart';
import 'package:chatbot/nowLoading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:http/http.dart' as http;

//String user = "Ibrahim Hatchabi";
var db = new DatabaseHelper();

class Chat extends StatefulWidget{
  Chat({Key key, this.title, this.messages, this.user}) : super(key: key);

  final String title;
  final List<Message> messages;
  final String user;

  @override
  _ChatState createState() => new _ChatState();
}

class _ChatState extends State<Chat> with TickerProviderStateMixin {

  var db = new DatabaseHelper();
  List<Message> _messages = <Message>[];
  final TextEditingController _textController = new TextEditingController();
  bool _isWriting = false;
  bool _isWaiting = false;
  bool _isSent = true;
  String txtSaisi;

  var _fileDiscuss;

  Map<String,String> headers = {"content-type":"application/json","accept":"application/json"};

  Future sendMsg() async {
    var response = await http.post(
        "https://chatbotproject-218317.appspot.com/send_message",
        headers: headers,
        //body: '{"sender":"${widget.user}","message":"$txtSaisi"}'
        body: '{"msg":"$txtSaisi"}'
    );
    var responseJson = json.decode(response.body);
    return responseJson;
  }
  @override
  Widget build(BuildContext context) {

    _fileDiscuss = new ListView.builder(
      itemBuilder: (_, int index) => _messages[index],
      itemCount: _messages.length,
      reverse: true,
      padding: new EdgeInsets.all(6.0),
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Center(
          child: new Image.asset("images/hratos_t.png",color: Colors.white,),
        ),//new Center(child: new Text(widget.title)),
        elevation: 6.0,
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.more_vert),
          onPressed: (){

          }
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.exit_to_app),
            onPressed: (){
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
                        title: new Text("Confirmation"),
                        content: new SingleChildScrollView(
                          child: new ListBody(
                            children: <Widget>[
                              new Text(
                                "Vous êtes sur le point de vous déconnecter, continuer?",
                                //style: _myAlertDialogTextStyle,
                              )
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          new FlatButton(
                            child: new Text(
                              "Oui",
                              //style: _myAlertDialogTextStyle,
                            ),
                            onPressed: () {
                              //exit(0);
                              Navigator.of(context)
                                ..pop()
                                ..pop();
                            },
                          ),
                          new FlatButton(
                            child: new Text(
                              "Non",
                              //style: _myAlertDialogTextStyle,
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                ..pop();
                            },
                          ),
                        ],
                      )
                    ]
                  )
                )
              ));
            }
          ),
        ],
      ),
      body: Form(
        onWillPop: (){
          return new Future<bool>.value(false);
        },
        child: new Column(
          children: <Widget>[
            new Flexible(
              child: _fileDiscuss,
            ),
            _isWaiting
              ? new FutureBuilder(
                //future: Future.delayed(const Duration(seconds: 5)),
                future: sendMsg(),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if(snapshot.hasData){
                    // Set the last message as sent
                    /*SchedulerBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        _messages[0].isSent = true;
                      });
                    });*/


                    // Récupérer le texte en supprimant les crochets du début et fin
                    //_respond(snapshot.data.toString().substring(1,snapshot.data.toString().length-1));

                    //_respond(snapshot.data.toString());
                    _respond(snapshot.data['msg']);
                    return Container();
                  } else if(snapshot.hasError){
                    // Handle the Error here

                    // Set last message as not sent


                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      Message msg = _messages[0];
                      setState(() {
                        _isSent = false;
                        _messages.removeAt(0);
                        var now = new DateTime.now();
                        Message message = new Message(
                          isRequest: true,
                          user: widget.user,
                          sender: widget.user,
                          //dateAdd: '${now.hour}:${now.minute}',
                          dateAdd: now.toString(),
                          txt: msg.txt,
                          isSent: _isSent,
                          animationController: new AnimationController(
                              vsync: this,
                              duration: new Duration(milliseconds: 800)
                          ),
                        );
                        txtSaisi = msg.txt;
                        _isWriting = false;
                        _isWaiting = false;
                        _messages.insert(0, message);
                        _isSent = true;
                        message.animationController.forward();
                      });
                      /*if(snapshot.error)*/
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: new Text("Erreur réseau"),
                            content: new SingleChildScrollView(
                              child: new ListBody(
                                children: <Widget>[
                                  new Text(
                                    "Veuillez verifier la connexion internet.",
                                    //style: _myAlertDialogTextStyle,
                                  )
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              new FlatButton(
                                child: new Text(
                                  "Okay",
                                  //style: _myAlertDialogTextStyle,
                                ),
                                onPressed: () {
                                  //exit(0);
                                  Navigator.of(context)
                                    ..pop();
                                },
                              )
                            ],
                          );
                        }
                      );

                      /*return AlertDialog(
                        title: new Text("Erreur réseau"),
                        content: new SingleChildScrollView(
                          child: new ListBody(
                            children: <Widget>[
                              new Text(
                                "Soxna est injoignable pour le moment. Veuillez réessayer plutard.",
                                //style: _myAlertDialogTextStyle,
                              )
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          new FlatButton(
                            child: new Text(
                              "Okay",
                              //style: _myAlertDialogTextStyle,
                            ),
                            onPressed: () {
                              //exit(0);
                              Navigator.of(context)
                                ..pop();
                            },
                          )
                        ],
                      );*/
                    });


                    /*return new Container(
                      margin: EdgeInsets.all(5.0),
                      padding: EdgeInsets.all(5.0),
                      width: double.infinity,
                      height: 25.0,
                      decoration: new BoxDecoration(
                        color: Colors.red.withOpacity(0.8),
                        boxShadow:
                          [
                            BoxShadow(
                              blurRadius: 1.0,
                            )
                          ],
                      ),
                      child: Center(
                        child: new Text(
                          "Veuillez vérifier la connexion internet ...",
                          style: new TextStyle(
                            color: Colors.black54,
                            fontFamily: "bebas",
                          ),
                        ),
                      ),
                    );*/
                  }
                  return new Container(
                    color: Colors.transparent,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //new CircularProgressIndicator(),
                        Container(
                          //padding: new EdgeInsets.all(5.0),
                          margin: new EdgeInsets.all(5.0),
                          height: 20.0,
                          child: new Bubble()
                        ),
                      ],
                    ),
                  );
                })
              : new Container(),
            new Divider(
              height: 2.0,
            ),
            new Container(
              child: _buildComposer(),
              decoration: new BoxDecoration(
                //color: Theme.of(context).cardColor,
                  color: Colors.black12,
                  borderRadius: new BorderRadius.all(new Radius.circular(10.0))
              ),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildComposer(){
    return new IconTheme(
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
                onChanged: (String txt){
                  setState(() {
                    _isWriting = txt.length > 0;
                    _isWaiting = false;
                  });
                },
                onSubmitted: _submitMsg,
                decoration: new InputDecoration.collapsed(
                    hintText: "Posez votre question ..."
                ),
                style: new TextStyle(
                  fontFamily: "LiberationSerif",
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              )
            ),
            new Container(
              //margin: new EdgeInsets.symmetric(horizontal: 1.0),
              //margin: new EdgeInsets.all(2.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: _isWriting ? () => _submitMsg(_textController.text) : null,
              ),
            ),
            new Container(
              //margin: new EdgeInsets.symmetric(horizontal: 1.0),
              //margin: new EdgeInsets.all(2.0),
              child: new IconButton(
                icon: new Icon(Icons.mic),
                onPressed: null,
              ),
            )
          ],
        ),
      )
    );
  }

  void _respond (String txt) async{
    //await new Future.delayed(const Duration(seconds: 5));
    Message msg = new Message(
      isRequest: false,
      sender: "bot",
      user: widget.user,
      isSent: false,
      txt: txt,
      dateAdd: new DateTime.now().toString(),
      animationController: new AnimationController(
          vsync: this,
          duration: new Duration(milliseconds: 800)
      ),
    );

    setState(() {
      _messages.insert(0, msg);
      _isWaiting = false;
    });

    int res = await db.saveMsg(msg);

    //print("**************************************** res = $res");

    msg.animationController.forward();
  }

  void _submitMsg(String txt) async {

    var now = new DateTime.now();

    Message msg = new Message(
      isRequest: true,
      user: widget.user,
      sender: widget.user,
      //dateAdd: '${now.hour}:${now.minute}',
      dateAdd: now.toString(),
      txt: txt,
      isSent: _isSent,
      animationController: new AnimationController(
          vsync: this,
          duration: new Duration(milliseconds: 800)
      ),
    );

    _textController.clear();
    setState(() {
      txtSaisi = txt;
      _isWriting = false;
      _isWaiting = true;
      _messages.insert(0, msg);
    });

    /*setState(() {
      _messages.insert(0, msg);
    });*/

    int res = await db.saveMsg(msg);

    //print("**************************************** res = $res");

    msg.animationController.forward();

    //_respond(response.body);
    //_respond(txt);
  }

  @override
  void dispose() {
    for(Message msg in _messages){
      msg.animationController.dispose();
    }
    super.dispose();
  }

  /*void firstUseCheck() async{
    await db.isFirstUse().then((value){
      if(!value){
        _respond("Bonjour ${widget.user.split(" ")[0]}, moi c'est Soxna. Que puis-je faire pour vous? ");
      }
    });
  }*/

  @override
  void initState() {
    /*if(widget.messages != null){
      for (final msg in widget.messages) {
        //msg.isSent = true;
        msg.animationController = new AnimationController(
          vsync: this,
          duration: new Duration(milliseconds: 200)
        );
        msg.animationController.forward();
      }
      _messages = widget.messages.reversed.toList();
    }*/
    super.initState();

    //firstUseCheck();
    _respond("Bonjour ${widget.user.split(" ")[0]}, je suis votre assistante RH.");
  }
}
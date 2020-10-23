import 'package:chatbot/message.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if(_db != null)
      return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "discussion.db");
    print("@@@@@@@@@@@@@@@@@@@@@@@@@---------------------- PAth $path");
    var theDb = await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          "CREATE TABLE Message (id INTEGER PRIMARY KEY, sender TEXT, user TEXT, message TEXT, dateAdd TEXT, dateDel TEXT, status BOOLEAN)");
      print("Table message created");
    });
    print("***************** Now returning");
    return theDb;
  }


  /*void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE Message (id INTEGER PRIMARY KEY, sender TEXT, message TEXT, dateAdd TEXT, dateDel TEXT, status BOOLEAN)");
    print("Table message created");
  }*/

  Future<List<Map>> recupMsg() async {
    var dbDiscuss = await db;
    List<Map> list = await dbDiscuss.rawQuery('SELECT * FROM Message WHERE status = ?',[1]);

    return list;
  }

  Future<List<Map>> recupMsgFrom(int id) async {
    var dbDiscuss = await db;
    List<Map> list = await dbDiscuss.rawQuery('SELECT * FROM Message WHERE id > ? AND status = ?',[id, true]);

    return list;
  }

  Future<int> saveMsg(Message msg) async {
    var dbDiscuss = await db;
    int maxId = Sqflite
        .firstIntValue(await dbDiscuss.rawQuery("SELECT COUNT(*) FROM Message"));
    var now = DateTime.now();
    int res = await dbDiscuss.rawInsert("INSERT INTO Message(id,sender,user,message,dateAdd,dateDel,status) VALUES(?,?,?,?,?,?,?)",
    [maxId+1,'${msg.sender}','${msg.user}','${msg.txt}','$now','',true]);
    print('******************** Msg saved ************');
    return res;
  }

  Future<int> deleteMsg(int id) async {
    var dbDiscuss = await db;
    //int res = await dbDiscuss.rawDelete("DELETE FROM Message WHERE id = ?",[id]);
    var now = DateTime.now();
    int res = await dbDiscuss.rawUpdate("UPDATE Message SET status = ?, datedel = ? WHERE id = ?",[false,'$now',id]);
    return res;
  }

  Future<bool> isFirstUse() async {
    var dbDiscuss = await db;
    var res = await dbDiscuss.query("Message");
    return res.length > 0? true: false;
  }

}
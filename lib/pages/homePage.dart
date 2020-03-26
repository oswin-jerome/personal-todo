import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:personal_todo/appBarC.dart';
import 'package:personal_todo/components/CardAdd.dart';
import 'package:personal_todo/components/user.dart';
import 'package:personal_todo/pages/addCategory.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import '../Data.dart';
import '../myCard.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  GlobalKey<ScaffoldState> _drawKey = GlobalKey();
  GoogleSignInAccount _currentUser;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
  );
  var date = DateTime.now();
  int tasks = 0;
  createDB() async {
    var dbPath = await getDatabasesPath();
    String path = p.join(dbPath, "data.db");
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int v) async {
      await db.execute(
          "CREATE TABLE categroies (id INTEGER PRIMARY KEY autoincrement, name TEXT)");
      await db.execute(
          "CREATE TABLE tasks (id INTEGER PRIMARY KEY autoincrement, name TEXT,done NUMBER,time TEXT,category NUMBER)");
    });

    // await database.close();r
  }

  @override
  void initState() {
    super.initState();
    createDB();
    // getAllCategories();
    getDetils();

    // print("_currentUser");
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
    // print(_currentUser);
  }

  getDetils() async {
    // print("d");
    var dbPath = await getDatabasesPath();
    String path = p.join(dbPath, "data.db");
    Database database = await openDatabase(path, version: 1);

    database.transaction((action) async {
      var res = await action.rawQuery(
          "SELECT * FROM tasks WHERE time = ? and done = 0", [
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day}'
      ]);
      // print(res.length);
      setState(() {
        tasks = res.length;
      });
      // print('${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawKey,
      drawerEdgeDragWidth: 30,
      drawerScrimColor: Color(0xd0000000),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Image.network(
                'https://avatars1.githubusercontent.com/u/23547645?s=460&v=4'),
            ListTile(
              title: Text(
                "App by",
                style: TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.normal),
              ),
              subtitle: Text(
                "Oswin Jerome",
                style: Data.cardText2,
              ),
            ),
            // RaisedButton(
            //   child: Text("Backup data"),
            //   onPressed: () async {
            //   final directory = await getExternalStorageDirectory();
            //   print(directory);
            //   final myDir = new Directory('/storage/emulated/0');
            //   myDir.exists().then((isThere) {
            //     isThere ? print('exists') : print('non-existent');
            //   });

            //   // myDir.list().listen((onData)=>print(onData));



            //   String database = await getDatabasesPath();
            //   final myDirs = new Directory(database);
            //   myDirs.list().listen((onData)=>print(onData));
                
            //   var myFile = new File(database+'/data.db');
            //   myFile.copy('/storage/emulated/0/data.db');



            // }),
            // RaisedButton(
            //   child: Text("Import data"),
            //   onPressed: () async {

              
            //   String database = await getDatabasesPath();
            //   var myFile = new File('/storage/emulated/0'+'/data.db');
            //   myFile.exists().then((onValue){
            //     if(onValue){
            //       myFile.copy(database+"/data.db").then((onValue){
            //         print(onValue);
            //       });
            //     }else{
            //       print("No file");
            //     }
            //   }).catchError((onError){
            //     print("No file");
            //   });
            //   // myFile.copy('/storage/emulated/0/data.db');



            // }),
          ],
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: Data.gradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      MyAppBar(drawerTrigger: () {
                        print("sdsdsds");
                        _drawKey.currentState.openDrawer();
                      }),
                      SizedBox(
                        height: 60,
                      ),
                      User(tasks: tasks, user: _currentUser)
                    ],
                  ),
                  Bottom(updateCount: getDetils),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Bottom extends StatefulWidget {
  Function updateCount;
  Bottom({this.updateCount});
  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  List categories = [];
  var date = DateTime.now();
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    getAllCategories();
    _scrollController.addListener(() {});
  }

  getAllCategories() async {
    widget.updateCount();

    print("d");
    var dbPath = await getDatabasesPath();
    String path = p.join(dbPath, "data.db");
    Database database = await openDatabase(path, version: 1);

    database.transaction((action) async {
      var res = await action.rawQuery("SELECT * FROM categroies");
      print(res);
      setState(() {
        categories = res;
      });
      print("res");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30, top: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 60),
              child: Text(
                "Today: ${date.day} ${dateIntToString(date.month)} ${date.year}",
                style: Data.date,
              )),
          SizedBox(
            height: 350,
            child: Container(
              child: ListView.builder(
                padding: EdgeInsets.only(left: 60, right: 30),
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: categories.length + 1,
                itemBuilder: (bx, i) {
                  if (i == categories.length) {
                    return GestureDetector(
                      child: CardAdd(),
                      onTap: () async {
                        var s = await Navigator.push(context,
                            MaterialPageRoute(builder: (c) => AddCategory()));
                        getAllCategories();
                        widget.updateCount();
                      },
                    );
                  } else {
                    return MyCard(
                      id: categories[i]['id'],
                      progress: double.parse(categories[i]['id'].toString()),
                      title: categories[i]['name'],
                      update: () {
                        getAllCategories();
                      },
                    );
                  }
                },
              ),
              // child: ListView(
              //   scrollDirection: Axis.horizontal,
              //   children: <Widget>[

              //     MyCard(progress: 20,),
              //     MyCard(progress: 30,),
              //     MyCard(progress: 70,),
              //     GestureDetector(child: CardAdd(),onTap: (){
              //       Navigator.push(context, MaterialPageRoute(builder: (c)=>AddCategory()));
              //     },),
              //   ],
              // ),
            ),
          ),
        ],
      ),
    );
  }

  String dateIntToString(int i) {
    switch (i) {
      case 1:
        return "January";
        break;
      case 2:
        return "February";
        break;
      case 3:
        return "March";
        break;
      case 4:
        return "April";
        break;
      case 5:
        return "May";
        break;
      case 6:
        return "June";
        break;
      case 7:
        return "July";
        break;
      case 8:
        return "August";
        break;
      case 9:
        return "September";
        break;
      case 10:
        return "October";
        break;
      case 11:
        return "November";
        break;
      case 12:
        return "December";
        break;
      default:
    }
  }
}

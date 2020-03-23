import 'package:flutter/material.dart';
import 'package:personal_todo/components/progressbar.dart';
import 'package:personal_todo/pages/addTasks.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import '../Data.dart';

class CategoryHome extends StatefulWidget {
  int id;
  CategoryHome(this.id);
  @override
  _CategoryHomeState createState() => _CategoryHomeState();
}

class _CategoryHomeState extends State<CategoryHome> {

  var basic = {
    "name":"",
    "id":"",
  };

  @override
  void initState() {
    super.initState();
    getBasic();
  }


  getBasic()async{
    var dbPath = await getDatabasesPath();
    String path = p.join(dbPath,"data.db");
    Database database = await openDatabase(path,version: 1);

    var result = await database.rawQuery("SELECT * FROM categroies WHERE id = ?",[widget.id]);
    print(result[0]['name']);
    setState(() {
      basic = {
        "name":result[0]['name'],
        "id":result[0]['id'].toString(),
      };
    });


    var data = await database.rawQuery("SELECT * FROM tasks WHERE category = ?",[widget.id]);

    print(data);


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      floatingActionButton: GestureDetector(
        onTap: ()async{
          var s = await Navigator.push(context, MaterialPageRoute(builder: (c)=>AddTask(id: widget.id,name: basic['name'],)));

        },
        child: Container(
          decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(50),
  gradient: LinearGradient(colors: Data.gradient)
          ),
          height: 50,
          width: 50,
          child: Icon(Icons.add,color: Colors.white,),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, top: 40, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "12 tasks",
              style: Data.cardText1,
            ),
            Text(
              basic['name'],
              style: Data.cardText2,
            ),
            SizedBox(
              height: 30,
            ),
            ProgressBar(25),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  Text("sds"),
                  ListView(
                    children: <Widget>[
                      Text("sdsd"),
                      Text("sdsd"),
                      Text("sdsd"),
                      Text("sdsd"),
                    ],
                  )
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}

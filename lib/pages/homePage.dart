import 'package:flutter/material.dart';
import 'package:personal_todo/appBarC.dart';
import 'package:personal_todo/components/CardAdd.dart';
import 'package:personal_todo/components/user.dart';
import 'package:personal_todo/pages/addCategory.dart';
import 'package:sqflite/sqflite.dart';

import '../Data.dart';
import '../myCard.dart';
import 'package:path/path.dart' as p;
class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {


  createDB() async{
    var dbPath = await getDatabasesPath();
    String path = p.join(dbPath,"data.db");
    Database database = await openDatabase(path,version: 1,onCreate: (Database db,int v)async{

      await db.execute("CREATE TABLE categroies (id INTEGER PRIMARY KEY autoincrement, name TEXT)");
      await db.execute("CREATE TABLE tasks (id INTEGER PRIMARY KEY autoincrement, name TEXT,done NUMBER,time TEXT,category NUMBER)");

    

    });




    // await database.close();r
  }

  @override
  void initState() {
    super.initState();
    createDB();
    // getAllCategories();
  }

  getAllCategories()async{
    print("d");
    var dbPath = await getDatabasesPath();
    String path = p.join(dbPath,"data.db");
    Database database = await openDatabase(path,version: 1);

        database.transaction((action)async{
      var res = await action.rawQuery("SELECT * FROM categroies");
      print(res);
      print("res");
    });     
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      MyAppBar(),
                      SizedBox(height: 60,),
                      User()
                    ],
                  ),Bottom(),
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
  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  List categories = [];

   @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  getAllCategories()async{
    print("d");
    var dbPath = await getDatabasesPath();
    String path = p.join(dbPath,"data.db");
    Database database = await openDatabase(path,version: 1);

        database.transaction((action)async{
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
      margin: EdgeInsets.only(bottom: 30,top: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(margin: EdgeInsets.only(left: 60),child: Text("Today: 22 March 2020",style: Data.date,)),
                      SizedBox(
                        height: 350,
                        child: Container(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length+1,
                            itemBuilder: (bx,i){
                              if(i==categories.length){
                                return GestureDetector(child: CardAdd(),onTap: ()async{
                              var s =await Navigator.push(context, MaterialPageRoute(builder: (c)=>AddCategory()));
                              getAllCategories();
                               },);
                              }else{
                                return MyCard(id: categories[i]['id'],progress: double.parse(categories[i]['id'].toString()),title: categories[i]['name'],);
                              }
                          },),
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
}
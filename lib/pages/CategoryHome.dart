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
    "name": "",
    "id": "",
  };
    int count = 0;


  List tasks = [];
  
  double progress = 0;

  @override
  void initState() {
    super.initState();
    getBasic();
  }

  getBasic() async {
    var dbPath = await getDatabasesPath();
    String path = p.join(dbPath, "data.db");
    Database database = await openDatabase(path, version: 1);
    var result = await database
        .rawQuery("SELECT * FROM categroies WHERE id = ?", [widget.id]);
    print(result[0]['name']);
    setState(() {
      basic = {
        "name": result[0]['name'],
        "id": result[0]['id'].toString(),
      };
    });

    var data = await database
        .rawQuery("SELECT * FROM tasks WHERE category = ? order by done", [widget.id]);

    setState(() {
      tasks = data;
    });
    print("data");
    
    
    getCountOfStatus(tasks);
    // database.close();
  }


  getCountOfStatus(List list) async{
    int done = 0;
    int notdone=0;
    int total;
    await list.forEach((item){
      if(item['done']==1){
        done = done + 1;
      }else{
        notdone = notdone + 1;
      }
    });

    setState(() {
      progress = (done/list.length)*100;
      count = notdone;
    });

    print(count);

    return {"done":done,"notdone":notdone};

  }

  markAsDone(int id) async{
    var dbPath = await getDatabasesPath();
    String path = p.join(dbPath, "data.db");
    
    Database database = await openDatabase(path, version: 1);


    database.rawUpdate("UPDATE tasks SET done = 1 WHERE id = ?",[id]);

    getBasic();
  }

  markAsNotDone(int id) async{
    var dbPath = await getDatabasesPath();
    String path = p.join(dbPath, "data.db");
    
    Database database = await openDatabase(path, version: 1);


    database.rawUpdate("UPDATE tasks SET done = 0 WHERE id = ?",[id]);

    getBasic();
  }
  deleteItem(int id) async{
    var dbPath = await getDatabasesPath();
    String path = p.join(dbPath, "data.db");
    
    Database database = await openDatabase(path, version: 1);


    database.rawDelete("DELETE FROM tasks WHERE id = ?",[id]);

    getBasic();
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
        onTap: () async {
          var s = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (c) => AddTask(
                id: widget.id,
                name: basic['name'],
              ),
            ),
          );

          getBasic();
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              gradient: LinearGradient(colors: Data.gradient)),
          height: 50,
          width: 50,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, top: 40, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              count.toString()+" tasks",
              style: Data.cardText1,
            ),
            Text(
              basic['name'],
              style: Data.cardText2,
            ),
            SizedBox(
              height: 30,
            ),
            ProgressBar(progress.roundToDouble()),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: ListView.separated(
                itemCount: tasks.length,
                itemBuilder: (bc, i) {
                  var s = false;
                  return ListTile(
                    title: Text(tasks[i]['name']),
                    leading: Checkbox(value: tasks[i]['done'] == 1?true:false, onChanged: (v) {
                      print(v);
                      if(v==true){
                        markAsDone(tasks[i]['id']);
                      }else{
                        markAsNotDone(tasks[i]['id']);
                      }
                    }),
                    subtitle: Text(tasks[i]['time']),
                    trailing: IconButton(icon: Icon(Icons.delete_forever), onPressed: (){
                      deleteItem(tasks[i]['id']);
                    }),
                    enabled: tasks[i]['done'] == 1?false:true,
                  );
                },
                separatorBuilder: (BuildContext buildContext, i) {
                  print(i);
                  return Divider(
                    height: 3,
                    color: Colors.grey[600],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

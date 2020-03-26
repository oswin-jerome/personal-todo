import 'package:flutter/material.dart';
import 'package:personal_todo/Data.dart';
import 'package:personal_todo/components/progressbar.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class AllTasks extends StatefulWidget {
  @override
  _AllTasksState createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {

  List tasks =[];
  List tasks_today =[];
  var progress;
  int count;

  @override
  void initState(){
    super.initState();
    getBasic();
  }

  getBasic() async {
    var date = DateTime.now();
    var dbPath = await getDatabasesPath();
    String path = p.join(dbPath, "data.db");
    Database database = await openDatabase(path, version: 1);


    var data = await database.rawQuery(
        "SELECT * FROM tasks order by done");

    setState(() {
      tasks = data;
    });
    getCountOfStatus(tasks);
    // database.close();

    var data2 = await database.rawQuery(
        "SELECT * FROM tasks WHERE time = ? order by done", [
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day}'
    ]);

    setState(() {
      tasks_today = data2;
    });
  }

  getCountOfStatus(List list) async {
    int done = 0;
    int notdone = 0;
    int total;
    await list.forEach((item) {
      if (item['done'] == 1) {
        done = done + 1;
      } else {
        notdone = notdone + 1;
      }
    });

    setState(() {
      progress = (done / list.length) * 100;
      count = notdone;
    });

    // print(count);

    return {"done": done, "notdone": notdone};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black54),
        title: Text("All tasks",style: TextStyle(color: Colors.black54),),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // SizedBox(height: 10,),
              // Text("All Tasks",style: Data.cardText2,textAlign: TextAlign.center,),
              // SizedBox(height: 30,),
              ProgressBar(progress),
              SizedBox(
                child: ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: tasks.length,
                      itemBuilder: (bc, i) {
                        var s = false;
                        return ListTile(
                          title: Text(tasks[i]['name']),
                          leading: Checkbox(
                              value: tasks[i]['done'] == 1 ? true : false,
                              onChanged: (v) {
                                // print(v);
                                if (v == true) {
                                  markAsDone(tasks[i]['id']);
                                } else {
                                  markAsNotDone(tasks[i]['id']);
                                }
                              }),
                          subtitle: Text(tasks[i]['time']),
                          trailing: IconButton(
                              icon: Icon(Icons.delete_forever),
                              onPressed: () {
                                deleteItem(tasks[i]['id']);
                              }),
                          enabled: tasks[i]['done'] == 1 ? false : true,
                        );
                      },
                      separatorBuilder: (BuildContext buildContext, i) {
                        // print(i);
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
      ),
    );
  }











  markAsDone(int id) async {
    var dbPath = await getDatabasesPath();
    String path = p.join(dbPath, "data.db");

    Database database = await openDatabase(path, version: 1);

    database.rawUpdate("UPDATE tasks SET done = 1 WHERE id = ?", [id]);

    getBasic();
  }

  markAsNotDone(int id) async {
    var dbPath = await getDatabasesPath();
    String path = p.join(dbPath, "data.db");

    Database database = await openDatabase(path, version: 1);

    database.rawUpdate("UPDATE tasks SET done = 0 WHERE id = ?", [id]);

    getBasic();
  }

  deleteItem(int id) async {
    var dbPath = await getDatabasesPath();
    String path = p.join(dbPath, "data.db");

    Database database = await openDatabase(path, version: 1);

    database.rawDelete("DELETE FROM tasks WHERE id = ?", [id]);

    getBasic();
  }
}
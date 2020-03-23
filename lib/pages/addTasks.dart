import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import '../Data.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
class AddTask extends StatefulWidget {
  int id;
  String name;
  AddTask({this.id,this.name});
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final format = DateFormat("yyyy-MM-dd");

  TextEditingController _nameController = TextEditingController();
  TextEditingController _dateController = TextEditingController();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  insertTask(name,time,category) async{

    var dbPath = await getDatabasesPath();
    String path = p.join(dbPath,"data.db");
    Database database = await openDatabase(path,version: 1);

    var res = database.insert("tasks", {
      "name":name,
      "time":time,
      "category":category,
      "done":0
    });

    print("object........");
    print(res);

    if(res != 0){
      Navigator.pop(context);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black54),
        elevation: 0,
        centerTitle: true,
        title: Text("New Task",style: TextStyle(color: Colors.black54),),
      ),


      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[


          Container(
            margin: EdgeInsets.all(30),
            child: Column(
              children: <Widget>[
                TextFormField(controller: _nameController,decoration: InputDecoration(labelText: "What task you are planning to do?",),),
                Container(margin: EdgeInsets.only(top: 15),child: TextFormField(initialValue: widget.name,enabled: false,)),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: DateTimeField(controller: _dateController,format: format,decoration: InputDecoration(labelText: "Date"), onShowPicker: (ctx,curval){
                    return showDatePicker(context: ctx, initialDate: curval?? DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2100));
                  }),
                )

              ],
            ),
          ),


          GestureDetector(
          onTap: (){
            print("sd");
            insertTask(_nameController.value.text, _dateController.value.text, widget.id);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            decoration:
                BoxDecoration(gradient: LinearGradient(colors: Data.gradient)),
            child: Center(
              child: Text("Save",style: TextStyle(color: Colors.white,fontSize: 18),),
            ),
          ),
        )
        ],
      ),
    );
  }
}
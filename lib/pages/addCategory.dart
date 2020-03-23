import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../Data.dart';
import 'package:path/path.dart' as p;
class AddCategory extends StatefulWidget {
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {


  @override
  void initState(){
    super.initState();
  }


  

  insertCategory(name) async{ 
    var dbPath = await getDatabasesPath();
    String path = p.join(dbPath,"data.db");

    Database db = await openDatabase(path,version: 1);
   int res = await db.insert("categroies", {"name":name});

  if(res!=0){
    Navigator.pop(context);
  }else{
   print("Error");

  }
  }

  TextEditingController _categoryController = TextEditingController();
  GlobalKey<FormState> _key = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Category",
                  ),
                  controller: _categoryController,
                  key: _key,
                  validator: (data){
                    if(data==""){
                      return "Empty value not allowed";
                    }

                    return null;
                  },
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              print("sd");
              insertCategory(_categoryController.value.text);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration:
                  BoxDecoration(gradient: LinearGradient(colors: Data.gradient)),
              child: Center(
                child: Text("Save",style: TextStyle(color: Colors.white,fontSize: 18),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

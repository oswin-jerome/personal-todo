import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../Data.dart';
import 'package:path/path.dart' as p;
class EditCategory extends StatefulWidget {
  int id;
  String value;
  EditCategory({this.id,this.value});
  @override
  _EditCategoryState createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {


  @override
  void initState(){
    super.initState();
  }


  

  updateCategory(name) async{ 
    var dbPath = await getDatabasesPath();
    String path = p.join(dbPath,"data.db");

    Database db = await openDatabase(path,version: 1);
   int res = await db.update("categroies", {"name":name},where: "id = ?",whereArgs: [widget.id]);

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
    _categoryController.text = widget.value;
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
                  // initialValue: widget.value,
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
              updateCategory(_categoryController.value.text);
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

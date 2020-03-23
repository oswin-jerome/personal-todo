import 'package:flutter/material.dart';
import 'package:personal_todo/components/progressbar.dart';

import '../Data.dart';

class CategoryHome extends StatefulWidget {
  @override
  _CategoryHomeState createState() => _CategoryHomeState();
}

class _CategoryHomeState extends State<CategoryHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(50),
  gradient: LinearGradient(colors: Data.gradient)
        ),
        height: 50,
        width: 50,
        child: Icon(Icons.add,color: Colors.white,),
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
              "Work",
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

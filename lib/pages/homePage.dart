import 'package:flutter/material.dart';
import 'package:personal_todo/appBarC.dart';
import 'package:personal_todo/components/user.dart';

import '../Data.dart';
import '../myCard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
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
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              MyCard(progress: 20,),
                              MyCard(progress: 30,),
                              MyCard(progress: 70,),
                            ],
                          ),
                        ),
                      ),
        ],
      ),
    );
  }
}
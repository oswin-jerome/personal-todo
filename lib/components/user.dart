import 'package:flutter/material.dart';

import '../Data.dart';

class User extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 70,
            width: 70,
            child: GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://avatars1.githubusercontent.com/u/23547645?s=460&v=4"),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text("Hello, Oswin Jerome", style: Data.nameStyle),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text("Make each day your masterpeice",
                style: Data.secondaryText),
          ),
          Container(
            margin: EdgeInsets.only(top: 1),
            child: Text("You have 5 tasks to finish today",
                style: Data.secondaryText),
          )
        ],
      ),
    );
  }
}

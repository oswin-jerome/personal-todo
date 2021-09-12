import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Data.dart';

class User extends StatelessWidget {
  int tasks;
  User({this.tasks});

  @override
  Widget build(BuildContext context) {
    // print(user);
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
                    "https://cdn.icon-icons.com/icons2/1736/PNG/512/4043260-avatar-male-man-portrait_113269.png"),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text("Hello, User", style: Data.nameStyle),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text("Make each day your masterpeice",
                style: Data.secondaryText),
          ),
          Container(
            margin: EdgeInsets.only(top: 1),
            child: Text("You have ${tasks} tasks to finish today",
                style: Data.secondaryText),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Data.dart';

class User extends StatelessWidget {

  int tasks;
  GoogleSignInAccount user;
  User({this.tasks,this.user});

  @override
  Widget build(BuildContext context) {
    print(user);
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
                    user.photoUrl),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text("Hello, ${user.displayName}", style: Data.nameStyle),
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

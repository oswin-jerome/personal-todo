import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  Function drawerTrigger;
  MyAppBar({this.drawerTrigger});
  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;
    return Container(
      padding: EdgeInsets.only(left: 20, top: 25, right: 25),
      child: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: GestureDetector(
              onTap: drawerTrigger,
              child: Image.asset("assets/menu.png"),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text("TODO",
                style: TextStyle(
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xffffffff).withOpacity(0.78),
                )),
          ),
        ],
      ),
    );
  }
}

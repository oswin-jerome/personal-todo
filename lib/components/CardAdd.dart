import 'package:flutter/material.dart';

class CardAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
      width: 230,
      height: 330,

      child: Center(
        child: Icon(Icons.add,size: 100,color: Colors.grey[300],),
      ),
    );
  }
}

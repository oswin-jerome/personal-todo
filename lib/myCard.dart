import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:personal_todo/Data.dart';

class MyCard extends StatefulWidget {
  double progress;
  MyCard({this.progress});
  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  GlobalKey<State> _progKey = GlobalKey<State>();
  double prog = 0.0;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => setProgress());
  }

  @override
  void didUpdateWidget(Widget o) {
    // super.didUpdateWidget();
    super.didUpdateWidget(o);
    SchedulerBinding.instance.addPostFrameCallback((_) => setProgress());
  }

  setProgress() {
    print(_progKey.currentContext.size.width);
    setState(() {
      prog = (_progKey.currentContext.size.width * widget.progress) / 100;
    });
    print("object");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
      width: 230,
      height: 330,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 15, top: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[Image.asset("assets/dots.png")],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: Stack(
                        // fit: StackFit.expand,
                        fit: StackFit.passthrough,
                        key: _progKey,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                  gradient:
                                      LinearGradient(colors: Data.gradient)),
                            height: 4,
                          ),

                          Positioned(
                            left: 40,
                            child: Text("sdsd"),
                          ),

                          AnimatedPositioned(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.decelerate,
                            right: 0,
                            top: 0,
                            bottom: 0,
                            left: prog,
                            child: Container(
                              // width: 50,
                              color: Colors.grey[200],
                              
                            ),
                          ),
                          // Positioned.fill(
                          //   right: 150,
                          //   child: Container(
                          //     color: Colors.blue,
                          //     height: 2,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Text(widget.progress.toString() + "%"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

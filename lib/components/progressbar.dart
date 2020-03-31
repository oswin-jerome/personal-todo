import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../Data.dart';

class ProgressBar extends StatefulWidget {
  double progress;
  ProgressBar(this.progress);
  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
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
    // print("object");
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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
                                  borderRadius: BorderRadius.circular(5),
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
                          child: Text(widget.progress.roundToDouble().toString() + "%",style: TextStyle(color: Colors.grey,fontSize: 14),),
                        ),
                      ],
                    );
  }
}

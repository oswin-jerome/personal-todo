import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:personal_todo/Data.dart';
import 'package:personal_todo/components/progressbar.dart';
import 'package:personal_todo/pages/CategoryHome.dart';
import 'package:personal_todo/pages/editCategory.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:popup_menu/popup_menu.dart';

class MyCard extends StatefulWidget {
  double progress;
  String title;
  int id;
  Function update;
  MyCard({this.id, this.progress, this.title, this.update});
  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  GlobalKey<State> _progKey = GlobalKey<State>();

  // Popup
  PopupMenu menu;
  GlobalKey btnKey = GlobalKey();

  double prog = 0.0;
  List tasks = [];
  double progress = 0.0;
  int pending = 0;
  @override
  void initState() {
    super.initState();

    menu = PopupMenu(
        items: [
          MenuItem(
              title: "Delete",
              textStyle: TextStyle(color: Colors.red),
              image: Icon(
                Icons.delete,
                color: Colors.red,
              )),
          MenuItem(
              title: "Edit",
              textStyle: TextStyle(color: Colors.grey),
              image: Icon(Icons.edit)),
        ],
        backgroundColor: Colors.white,
        lineColor: Colors.black45,
        highlightColor: Colors.grey[350],
        maxColumn: 1,
        onClickMenu: (MenuItemProvider item) async {
          print(item.menuTitle);

          if (item.menuTitle == "Delete") {
            deleteCategory(widget.id);
          }
          if (item.menuTitle == "Edit") {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (c) => EditCategory(
                          id: widget.id,
                          value: widget.title,
                        )));
            getBasic();
            widget.update();
          }
        });

    SchedulerBinding.instance.addPostFrameCallback((_) => setProgress());
  }

  void deleteCategory(id) async {
    var dbPath = await getDatabasesPath();
    String path = p.join(dbPath, "data.db");
    Database database = await openDatabase(path, version: 1);

    await database
        .rawDelete("DELETE FROM tasks WHERE category = ?", [widget.id]);
    await database
        .rawDelete("DELETE FROM categroies WHERE id = ?", [widget.id]);
    getBasic();
    widget.update();
  }

  @override
  void didUpdateWidget(Widget o) {
    // super.didUpdateWidget();
    super.didUpdateWidget(o);
    SchedulerBinding.instance.addPostFrameCallback((_) => setProgress());
  }

  setProgress() {
    // print(_progKey.currentContext.size.width);
    setState(() {
      prog = (_progKey.currentContext.size.width * progress) / 100;
    });
    // print("object");
    getBasic();
  }

  getBasic() async {
    var dbPath = await getDatabasesPath();
    String path = p.join(dbPath, "data.db");
    Database database = await openDatabase(path, version: 1);

    var data = await database.rawQuery(
        "SELECT * FROM tasks WHERE category = ? order by done", [widget.id]);

    setState(() {
      tasks = data;
    });
    // print(data);

    getCountOfStatus(tasks);

    // database.close();
  }

  getCountOfStatus(List list) async {
    int done = 0;
    int notdone = 0;
    int total;
    await list.forEach((item) {
      if (item['done'] == 1) {
        done = done + 1;
      } else {
        notdone = notdone + 1;
      }
    });

    setState(() {
      progress = (done / list.length) * 100;
      pending = notdone;
    });

    return {"done": done, "notdone": notdone};
  }

  @override
  Widget build(BuildContext context) {
    PopupMenu.context = context;

    return GestureDetector(
      onTap: () async {
        await Navigator.push(context,
            MaterialPageRoute(builder: (c) => CategoryHome(widget.id)));
        getBasic();
        widget.update();
      },
      child: Container(
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
                children: <Widget>[
                  GestureDetector(
                      key: btnKey,
                      onTap: () {
                        print("Popup");
                        menu.show(widgetKey: btnKey);
                      },
                      child: Image.asset("assets/dots.png"))
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    pending.toString() + " tasks",
                    style: Data.cardText1,
                  ),
                  Text(
                    widget.title,
                    style: Data.cardText2,
                  ),
                  ProgressBar(progress.roundToDouble()),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: <Widget>[
                  //     Expanded(
                  //       child: Stack(
                  //         // fit: StackFit.expand,
                  //         fit: StackFit.passthrough,
                  //         key: _progKey,
                  //         children: <Widget>[
                  //           Container(
                  //             decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(5),
                  //                 gradient:
                  //                     LinearGradient(colors: Data.gradient)),
                  //             height: 4,
                  //           ),
                  //           Positioned(
                  //             left: 40,
                  //             child: Text("sdsd"),
                  //           ),
                  //           AnimatedPositioned(
                  //             duration: Duration(milliseconds: 500),
                  //             curve: Curves.decelerate,
                  //             right: 0,
                  //             top: 0,
                  //             bottom: 0,
                  //             left: progress,
                  //             child: Container(
                  //               // width: 50,
                  //               color: Colors.grey[200],
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     Container(
                  //       margin: EdgeInsets.only(left: 5),
                  //       child: Text(progress.roundToDouble().toString() + "%"),
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

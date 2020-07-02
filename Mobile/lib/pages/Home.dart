import 'package:eaw/resource/CommonComponent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  BuildContext context;

  HomePage(this.context);

  @override
  HomePageState createState() => HomePageState(context);
}

class HomePageState extends State<HomePage> {
  BuildContext context;
  DateTime dateTime = DateTime.now();
  DateFormat dateFormat = new DateFormat("dd-MM-yyyy");
  List<String> listTitle = [];

  HomePageState(this.context);

  @override
  Widget build(BuildContext context) {
    getListTitle();
    return Scaffold(
        appBar: common.getAppbar("Home", context),
        body: getBody(),
        bottomNavigationBar: common.getNavigationBar(context, null));
  }

  getBody() {
    return Container(
      width: common.getWidthContext(context),
      height: common.getHeightContext(context),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue, Colors.purple])),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: common.getWidthContext(context),
            height: common.getHeightContext(context) / 3.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                common.getAvatar(context),
              ],
            ),
          ),
          Container(
            width: common.getWidthContext(context),
            height: common.getHeightContext(context) / 13,
            color: Colors.black12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: common.getWidthContext(context) / 3.5,
                  child: Center(
                      child: Text("Today",
                          style: TextStyle(fontSize: 28, color: Colors.white))),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left:20),
                    child: Text("${dateFormat.format(dateTime)}",
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
          Container(
//              color: Colors.yellow,
              width: common.getWidthContext(context),
              height: common.getHeightContext(context) / 2.4,
              child: getContent())
        ],
      ),
    );
  }

  Widget getContent() {
    return ListView.builder(
      itemCount: listTitle.length,
      itemBuilder: (context, index) =>
          Container(
            width: common.getWidthContext(context),
            height: common.getHeightContext(context) / 7.5,
            child: Card(
              color: Colors.white70,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        flex: 2,
                        child: Container(
                          height: common.getHeightContext(context) / 11,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                              child: Text(
                                "${listTitle[index]}",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              )),
                        )),
                    Expanded(flex: 6, child:
                        Padding(
                          padding: const EdgeInsets.only(left:20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("asdadas",style:TextStyle(color:Colors.grey)),
                              Text("asdadas",style:TextStyle(color:Colors.black)),
                              Text("asdadas",style:TextStyle(color:Colors.black)),
                            ],
                          ),
                        )
                    )
                  ],
                ),
              ),
            ),
            margin: EdgeInsets.only(bottom: 8),
          ),
    );
  }

  getListTitle() {
    listTitle = ["Next\nShift", "Total\nHours", "Last Attendance"];
  }
}

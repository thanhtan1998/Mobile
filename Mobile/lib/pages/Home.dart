import 'package:eaw/blocs/HomeBloc.dart';
import 'package:eaw/dto/HomeResponse.dart';
import 'package:eaw/resource/CommonComponent.dart';
import 'package:eaw/resource/SharedPreferences.dart';
import 'package:eaw/resource/urlEnum.dart';
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
  Map<String, String> listContent;

  List<String> listTitle = [];

  HomePageState(this.context){
    Map data = ModalRoute
        .of(context)
        .settings
        .arguments;
    if (data != null) {
      homeResponse = data['data'];
    } else {
      getHomeResponse();
    }
    listContent = Map();
    getListTitle();
    getMapValue();
  }

  HomeResponse homeResponse;


  getHomeResponse() async {
    homeResponse =  homeBloc.getHomeResponse;
  }


  @override
  Widget build(BuildContext context) {
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
            height: common.getHeightContext(context) / 3.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                common.getAvatar(context),
              ],
            ),
          ),
          Container(
            width: common.getWidthContext(context),
            height: common.getHeightContext(context) / 14,
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
                    padding: const EdgeInsets.only(left: 20),
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
    Iterable<MapEntry<String, String>> entry = listContent.entries;
    return ListView.builder(
      itemCount: entry.length,
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
                                "${entry
                                    .elementAt(index)
                                    .key}",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              )),
                        )),
                    Expanded(
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("${entry
                                  .elementAt(index)
                                  .value}",
                                  style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
            margin: EdgeInsets.only(bottom: 8),
          ),
    );
  }

  getMapValue() {
    double totalHours = homeResponse.totalHours;
    String lastAttendance = homeResponse.lastAttendance ?? "Nothing to show";
    String nextShift = homeResponse.lastAttendance ?? "Nothing to show";
    listContent.putIfAbsent(listTitle[0], () => nextShift);
    listContent.putIfAbsent(listTitle[1], () => "$totalHours");
    listContent.putIfAbsent(listTitle[2], () => lastAttendance);
  }

  getListTitle() {
    listTitle = ["Next Shift", "Total Hours", "Last Attendance"];
  }
}
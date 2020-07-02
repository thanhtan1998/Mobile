import 'package:eaw/resource/CommonComponent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  BuildContext context;

  HistoryPage(this.context);

  @override
  _HistoryPageState createState() => _HistoryPageState(context);
}

class _HistoryPageState extends State<HistoryPage> {
  DateTime dateTime = DateTime.now();
  DateFormat dateFormat = new DateFormat("dd-MM-yyyy");
  String startDate, endDate;
  int dayNr;
  DateTime thisMonday, thisSunday;
  BuildContext context;

  _HistoryPageState(this.context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: common.getAppbar("History", context),
        body: getBody(),
        bottomNavigationBar: common.getNavigationBar(context, null));
  }

  @override
  void initState() {
    super.initState();
    getStartDate();
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
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(child: getRowPickDate()),
            ),
          ),
          Expanded(flex: 10, child: getListView()),
        ],
      ),
    );
  }

  getDataByDay() {
    int count = 0;
    common.mapDay.clear();
    common.listDay.forEach((value) {
      DateTime temp = thisMonday.subtract(new Duration(days: count));
      String stringDate = "${temp.day} - ${temp.month}";
      common.mapDay.putIfAbsent(value, () => stringDate);
      count -= 1;
    });
  }

  getStartDate() {
    int today = dateTime.weekday;
    dayNr = (today + 6) % 7;
    thisMonday = dateTime.subtract(new Duration(days: (dayNr)));
    startDate = dateFormat.format(thisMonday);
    thisSunday = thisMonday.add(new Duration(days: 6));
    endDate = dateFormat.format(thisSunday);
    getDataByDay();
  }

  getNextOrPreviousWeek(int duration) {
    getStartDate();
    thisMonday = dateTime.subtract(new Duration(days: (dayNr + duration)));
    dateTime = thisMonday;
    startDate = dateFormat.format(thisMonday);
    thisSunday = thisMonday.add(new Duration(days: 6));
    endDate = dateFormat.format(thisSunday);
    getDataByDay();
  }

  showDate() {
    showDatePicker(
            context: context,
            initialDate: dateTime,
            firstDate: DateTime(DateTime.now().year),
            lastDate: DateTime(DateTime.now().year + 2))
        .then((value) {
      print(value);
      setState(() {
        if (value != null) dateTime = value;
        getStartDate();
      });
    });
  }

  getRowPickDate() {
    return Container(
      width: common.getWidthContext(context),
      height: common.getHeightContext(context) / 6,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Center(
              child: IconButton(
                padding: EdgeInsets.only(right: 2),
                icon: Icon(Icons.arrow_back_ios),
                tooltip: 'Previous Week',
                onPressed: () {
                  setState(() {
                    getNextOrPreviousWeek(7);
                  });
                },
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: Container(
//                color: Colors.white12,
//                margin: EdgeInsets.only(right: 6),
                width: common.getWidthContext(context) / 7.5,
                height: common.getHeightContext(context) / 32,
                decoration: BoxDecoration(
                  //color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "${startDate}",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              )),
          Expanded(
            flex: 5,
            child: Container(
//              color: Colors.yellowAccent,
//              width: common.getWidthContext(context) /5,
              margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: OutlineButton(
                  color: Colors.black,
                  splashColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
//                    highlightElevation: 1,
                  borderSide: BorderSide(color: Colors.white),
                  child: Text("Pick Date",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      )),
                  onPressed: showDate),
            ),
          ),
          Expanded(
              flex: 3,
              child: Container(
                width: common.getWidthContext(context) / 4.2,
                height: common.getHeightContext(context) / 32,
                decoration: BoxDecoration(
                  //    color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "${endDate}",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              )),
          Expanded(
            flex: 1,
            child: IconButton(
              padding: EdgeInsets.only(right: 1),
              icon: Icon(Icons.arrow_forward_ios),
              tooltip: 'Next Week',
              onPressed: () {
                setState(() {
                  getNextOrPreviousWeek(-7);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  getListView() {
    Iterable<MapEntry<String, String>> listMapDay= common.mapDay.entries;
    return new ListView.builder(
      itemCount: listMapDay.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, i) {
        return Container(
          height: common.getHeightContext(context) / 6,
          child: Card(
            color: Colors.white70,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Container(
                        width: common.getWidthContext(context) / 4.5,
                        height: common.getHeightContext(context) / 7,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                listMapDay.elementAt(i).value,
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Text(
                                listMapDay.elementAt(i).key,
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
                Expanded(
                    flex: 9,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 3.0, bottom: 4),
                                              child: Text(
                                                "Branch",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Text("Ho Chi Minh",
                                                style: TextStyle(fontSize: 15)),
                                          ],
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 3.0, bottom: 4),
                                                child: Text(
                                                  "Store",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                            Text("7-11 FPT Uni",
                                                style: TextStyle(fontSize: 15)),
                                          ],
                                        )),
                                  ],
                                ),
                              )),
                          Expanded(
                              flex: 3,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: <Widget>[
                                          Text("Check In",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Center(
                                            child: Text("06:25 AM",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.blueGrey)),
                                          )
                                        ],
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: <Widget>[
                                          Text("Check Out",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Center(
                                            child: Text("06:25 PM",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.blueGrey)),
                                          ),
                                        ],
                                      )),
                                ],
                              )),
//                          Expanded(
//                            flex: 1,
//                            child: Padding(
//                              padding:
//                                  const EdgeInsets.only(bottom: 7.0, right: 17),
//                              child: Row(
//                                mainAxisAlignment: MainAxisAlignment.end,
//                                children: <Widget>[
//                                  GestureDetector(
//                                      onTap: () {},
//                                      child: Container(
//                                          width:
//                                              common.getWidthContext(context) /
//                                                  7,
//                                          height:  common.getHeightContext(context) /
//                                              15,
//                                          decoration: BoxDecoration(
//                                              gradient: LinearGradient(
//                                                  begin: Alignment.topRight,
//                                                  end: Alignment.bottomLeft,
//                                                  colors: [
//                                                    Colors.blue,
//                                                    Colors.green
//                                                  ]),
//                                              borderRadius: BorderRadius.all(
//                                                  Radius.circular(30))),
//                                          child: Center(
//                                              child: Text(
//                                            "View",
//
//                                          )))),
//                                ],
//                              ),
//                            ),
//                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }

  getElementInMap(String key) {
    for (var i in common.mapContent.entries) {
      if (i.key.compareTo(key) == 0)
        return Text(
          i.value,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        );
    }
  }
}

import 'dart:ui';
import 'package:eaw/pages/RequestPage.dart';
import 'package:eaw/resource/CommonComponent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:google_fonts/google_fonts.dart';

class SchedulePage extends StatefulWidget {
  BuildContext context;

  SchedulePage(this.context);

  @override
  _SchedulePageState createState() => _SchedulePageState(context);
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime dateTime = DateTime.now();
  DateFormat dateFormat = new DateFormat("dd-MM-yyyy");
  String startDate, endDate;
  int dayNr;
  DateTime thisMonday, thisSunday;
  BuildContext context;

  _SchedulePageState(this.context);

  @override
  void initState() {
    super.initState();
    getStartDate();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: common.getAppbar("Schedule", context),
        body: getBody(),
        floatingActionButton: FloatingActionButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => RequestPage("7-11 FPT", "HCM-Ho Chi Minh"),
            ),

          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
        bottomNavigationBar: common.getNavigationBar(context, null));
  }

  getBody() {
    return Container(
      width:common.getWidthContext(context),
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
            width:common.getWidthContext(context),
            height: common.getHeightContext(context) / 3.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                common.getAvatar(context),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
                width:common.getWidthContext(context),
                height: common.getHeightContext(context) /2,

                child: getContent()),
          )
        ],
      ),
    );
  }

  getContent() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: Container(
                width:common.getWidthContext(context),
                height: common.getHeightContext(context) / 18,
                child: getRowPickDate(),
              ),
            )
          ],
        ),
        SizedBox(
          height: common.getHeightContext(context) / 100,
        ),
        getRowDateEvent(),
        SizedBox(
          height: common.getHeightContext(context) / 64,
        ),
        Container(
            height: common.getHeightContext(context) /2.92,
            child: getSchedule(common.mapDay, common.mapContent)),
      ],
    );
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

  getSchedule(Map<String, String> days, Map<String, String> contentOfDay,
      ) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left:8.0,right: 8),
        child: Column(
            children: days.entries
                .map((e) => Container(
              height:  common.getHeightContext(context) / 13,
                      child: Row(
                        children: <Widget>[
                          Opacity(
                            opacity: 0.5,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              width:  common.getWidthContext(context) / 5.1,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top:10.0),
                                  child: Column(
                                    children: <Widget>[
                                       Text(
                                          e.key,
                                          style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  fontSize:18,
                                                  fontWeight: FontWeight.bold)),
                                        ),

                                      Text(
                                          e.value,
                                          style: GoogleFonts.coda(
                                              textStyle: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold)),
                                        ),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              child: Opacity(
                                opacity: 0.5,
                                child: Container(
                                    height:  common.getHeightContext(context) /13,
                                    margin: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white,
                                    ),
//                              color: Color(int.parse(colors[e])),
                                    child: SingleChildScrollView(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0, top: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[getElementInMap(e.key)],
                                        ),
                                      ),
                                    )),
                              )),
                        ],
                      ),
                      margin: EdgeInsets.only(bottom: 5),
                    ))
                .toList()),
      ),
    );
  }

  getElementInMap(String key) {
    for (var i in common.mapContent.entries) {
      if (i.key.compareTo(key) == 0)
        return Text(
          i.value,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
        );
    }
  }

  getRowDateEvent() {
    return Padding(
      padding: const EdgeInsets.only(left:8.0,right:8),
      child: Container(
        width:common.getWidthContext(context),
        height:  common.getHeightContext(context) / 19,
        decoration: BoxDecoration(
            color: Color.fromRGBO(102, 140, 255, 1),
            borderRadius: BorderRadius.circular(8)),
        child: Container(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child:Center(
                  child: Text(
                  "Date",
                  style: GoogleFonts.coda(textStyle: TextStyle(fontSize: 18))),
                ),
              ),
              Expanded(
                flex: 11,
                child: Center(
                  child: Text(
                    "Events",
                    style: GoogleFonts.coda(textStyle: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getRowPickDate() {
    return Container(
      width:common.getWidthContext(context),
      height: common.getHeightContext(context) / 6.4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: common.getWidthContext(context) / 9,
            child: Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: IconButton(
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
          SizedBox(
              width:  common.getWidthContext(context) / 4.3,
              child: Container(
                margin: EdgeInsets.only(right: 6),
                width: common.getWidthContext(context) /7.5,
                height: common.getHeightContext(context)/32,
                child: Center(
                  child: Text(
                    "${startDate}",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              )),
          Container(
            width: common.getWidthContext(context) /3.5,
            child: OutlineButton(
                color: Colors.black,
                splashColor: Colors.grey,
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
          SizedBox(
              width: common.getWidthContext(context) / 4.3,
              child: Container(
                margin: EdgeInsets.only(left: 6),
                width: common.getWidthContext(context) / 4.2,
                height: common.getHeightContext(context)/32,

                child: Center(
                  child: Text(
                    "${endDate}",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              )),
          Expanded(
//            width: common.getWidthContext(context) / 9,
//            margin: EdgeInsets.only(left: 10),
            child: IconButton(
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
}

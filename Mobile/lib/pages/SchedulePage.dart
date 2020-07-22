import 'dart:ui';

import 'package:eaw/blocs/ScheduleBloc.dart';
import 'package:eaw/dto/Schedule.dart';
import 'package:eaw/dto/ScheduleResponse.dart';
import 'package:eaw/resource/CommonComponent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class SchedulePage extends StatefulWidget {
  BuildContext context;

  SchedulePage(this.context);

  @override
  _SchedulePageState createState() => _SchedulePageState(context);
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime dateTime = DateTime.now();
  DateFormat dateFormat = new DateFormat("dd-MM-yyyy");
  DateFormat dateFormat2 = new DateFormat("yyyy-MM-dd");
  String startDate, endDate;
  int dayNr;
  DateTime thisMonday, thisSunday;
  BuildContext context;
  ScheduleResponse scheduleResponse;
  _SchedulePageState(this.context) {
    getStartDate();
  }

  @override
  void initState() {
    super.initState();
  }

  getStartDate() {
    int today = dateTime.weekday;
    dayNr = (today + 6) % 7;
    thisMonday = dateTime.subtract(new Duration(days: (dayNr)));
    startDate = dateFormat.format(thisMonday);
    thisSunday = thisMonday.add(new Duration(days: 6));
    endDate = dateFormat.format(thisSunday);
  }

  getNextOrPreviousWeek(int duration) {
    getStartDate();
    thisMonday = dateTime.subtract(new Duration(days: (dayNr + duration)));
    dateTime = thisMonday;
    startDate = dateFormat.format(thisMonday);
    thisSunday = thisMonday.add(new Duration(days: 6));
    endDate = dateFormat.format(thisSunday);
    print(DateTime.parse(dateFormat2.format(thisMonday)));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: scheduleBloc.getSchedule(
            common.userToken,
            common.userId,
            DateTime.parse(dateFormat2.format(thisMonday)),
            DateTime.parse(dateFormat2.format(thisSunday))),
        builder: (context, AsyncSnapshot snapshot) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: common.getAppbar("Lịch làm việc", context),
              body: getBody(),
              bottomNavigationBar: common.getNavigationBar(context, null));
        });
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  common.getAvatar(context),
                ],
              ),
            ),
          ),
          Expanded(child: getContent())
        ],
      ),
    );
  }

  getContent() {
    return StreamBuilder<Object>(
        stream: scheduleBloc.getHomeResponse,
        builder: (context, snapshot) {
          scheduleResponse = snapshot.data;
          Iterable<MapEntry<String, Schedule>> listSchedule = [];
          if (scheduleResponse != null) {
            listSchedule = scheduleResponse.listOfSchedule.entries;
          }
          return Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: Container(
                      width: common.getWidthContext(context),
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
              Expanded(
                  child: listSchedule.isNotEmpty
                      ? getSchedule(listSchedule)
                      : Center(child: getTextBold("", "Đang cập nhật", 20)))
            ],
          );
        });
  }

  loadingData() {
    return Container(
      child: SpinKitFadingCircle(
        color: Colors.white,
        size: 20,
      ),
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

  getSchedule(Iterable<MapEntry<String, Schedule>> listSchedule) {
    return ListView.builder(
        itemCount: listSchedule.length,
        itemBuilder: (context, index) => Container(
              width: common.getWidthContext(context),
              height: common.getHeightContext(context) / 9,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Opacity(
                        opacity: 0.5,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          width: common.getWidthContext(context) / 5.1,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                                maxHeight:
                                    common.getHeightContext(context) / 9),
                            child: Center(
                              child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      getTextBold2(
                                          " ${listSchedule.elementAt(index).key.substring(0, 3)}\n",
                                          "${getSubString(listSchedule.elementAt(index).key)}",
                                          20,
                                          24)
                                    ],
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Opacity(
                        opacity: 0.5,
                        child: Container(
                            margin: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: SingleChildScrollView(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxHeight:
                                      common.getHeightContext(context) / 9,
                                ),
                                child: scheduleResponse != null
                                    ? getElementInMap(
                                        listSchedule.elementAt(index).value)
                                    : loadingData(),
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              ),
              margin: EdgeInsets.only(bottom: 5),
            ));
    //
  }

  getElementInMap(Schedule schedule) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, top: 2, bottom: 2, right: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                        child:
                            getTextBold("Cửa hàng: ", schedule.brandName, 14)),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    flex: 2,
                    child: Container(
                        child: getTextBold("Từ: ", schedule.startDate, 14))),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                        child: getTextBold("Đến: ", schedule.endDate, 14)),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                      child: getTextBold("Địa chỉ: ", schedule.address, 14)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  getSubString(String string) {
    return string.substring(string.length - 4).contains("\n")
        ? string.substring(string.length - 3)
        : string.substring(string.length - 4);
  }

  getTextBold(String title, String value, double size) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: title,
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontSize: size,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  getTextBold2(String title, String value, double size1, double size2) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: title,
            style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: size1,
                fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontSize: size2,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  getRowDateEvent() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: Container(
        width: common.getWidthContext(context),
        height: common.getHeightContext(context) / 19,
        decoration: BoxDecoration(
            color: Color.fromRGBO(102, 140, 255, 1),
            borderRadius: BorderRadius.circular(8)),
        child: Container(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Center(
                  child: Text("Date",
                      style:
                          GoogleFonts.coda(textStyle: TextStyle(fontSize: 18))),
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
      width: common.getWidthContext(context),
      height: common.getHeightContext(context) / 6.4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
              child: RawMaterialButton(
            onPressed: () {
              setState(() {
                getNextOrPreviousWeek(7);
              });
            },
            elevation: 1.0,
            fillColor: Color.fromRGBO(102, 140, 255, 1),
            child: Icon(
              Icons.arrow_back_ios,
              size: 30.0,
            ),
            shape: CircleBorder(),
          )),
          SizedBox(
              width: common.getWidthContext(context) / 4.3,
              child: Container(
                margin: EdgeInsets.only(right: 6),
                width: common.getWidthContext(context) / 7.5,
                height: common.getHeightContext(context) / 32,
                child: Center(
                  child: Text(
                    "$startDate",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              )),
          Container(
            width: common.getWidthContext(context) / 3.5,
            child: OutlineButton(
                color: Colors.black,
                splashColor: Colors.grey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
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
                height: common.getHeightContext(context) / 32,
                child: Center(
                  child: Text(
                    "$endDate",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              )),
          Expanded(
              child: RawMaterialButton(
            onPressed: () {
              setState(() {
                getNextOrPreviousWeek(-7);
              });
            },
            elevation: 1.0,
            fillColor: Color.fromRGBO(102, 140, 255, 1),
            child: Icon(
              Icons.arrow_forward_ios,
              size: 30.0,
            ),
            shape: CircleBorder(),
          ))
        ],
      ),
    );
  }
}

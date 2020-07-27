import 'package:eaw/blocs/HistoryBloc.dart';
import 'package:eaw/dto/History.dart';
import 'package:eaw/dto/HistoryResponse.dart';
import 'package:eaw/resource/CommonComponent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class HistoryPage extends StatefulWidget {
  BuildContext context;

  HistoryPage(this.context);

  @override
  _HistoryPageState createState() => _HistoryPageState(context);
}

class _HistoryPageState extends State<HistoryPage> {
  HistoryResponse historyResponse;
  DateTime dateTime = DateTime.now();
  DateFormat dateFormat2 = new DateFormat("yyyy-MM-dd");
  DateFormat dateFormat = new DateFormat("dd-MM-yyyy");
  String startDate, endDate;
  int dayNr;
  DateTime thisMonday, thisSunday;
  BuildContext context;

  @override
  void initState() {
    common.checkNetWork(context);
    super.initState();
  }

  _HistoryPageState(this.context) {
    getStartDate();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadHistory(),
        builder: (context, AsyncSnapshot snapshot) {
          return Scaffold(
              appBar: common.getAppbar("Điểm danh", context),
              body: getBody(),
              bottomNavigationBar: common.getNavigationBar(context, null));
        });
  }

  showImage(String image) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: common.getHeightContext(context) / 3,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: common.getWidthContext(context) / 2,
                      height: common.getHeightContext(context) / 4,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: converImage.convertStringToImage(image)),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: OutlineButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Close"),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  loadHistory() async {
    historyBloc.getHistory(
        common.userToken,
        common.userId,
        DateTime.parse(dateFormat2.format(thisMonday)),
        DateTime.parse(dateFormat2.format(thisSunday)));
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
            width: common.getWidthContext(context) / 3,
            child: OutlineButton(
                color: Colors.black,
                splashColor: Colors.grey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                borderSide: BorderSide(color: Colors.white),
                child: Text("Chọn ngày",
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
            fillColor: Colors.blue,
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

  getListView() {
    return StreamBuilder<Object>(
        stream: historyBloc.getHistoryResponse,
        builder: (context, snapshot) {
          historyResponse = snapshot != null ? snapshot.data : null;
          List<History> listHistory = [];
          if (historyResponse != null) {
            listHistory = historyResponse.listOfHistory;
          }
          return listHistory.isNotEmpty
              ? ListView.builder(
                  itemCount: listHistory.length,
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    return Container(
                      height: common.getHeightContext(context) / 7,
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
                                    width:
                                        common.getWidthContext(context) / 4.5,
                                    height:
                                        common.getHeightContext(context) / 8,
                                    decoration: BoxDecoration(
                                      color: listHistory
                                              .elementAt(index)
                                              .mode
                                              .contains("camera")
                                          ? Colors.green
                                          : Colors.red,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0)),
                                    ),
                                    child: RawMaterialButton(
                                      onPressed: () {
                                        if (listHistory
                                                .elementAt(index)
                                                .imageCheckFace !=
                                            null) {
                                          showImage(listHistory
                                              .elementAt(index)
                                              .imageCheckFace);
                                        }
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          getTextBold2(
                                              " ${listHistory.elementAt(index).date.split("\n")[1]}\n",
                                              "${listHistory.elementAt(index).time}",
                                              20,
                                              24)
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                            Expanded(
                                flex: 9,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxHeight:
                                            common.getHeightContext(context) /
                                                8),
                                    child: Column(
                                      children: <Widget>[
                                        Expanded(
                                            child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                                child: getTextBold(
                                                    "Cửa hàng: ",
                                                    listHistory
                                                        .elementAt(index)
                                                        .storeName,
                                                    16)),
                                          ],
                                        )),
                                        Expanded(
                                            child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                                child: getTextBold(
                                                    "Loại: ",
                                                    listHistory
                                                        .elementAt(index)
                                                        .mode,
                                                    16)),
                                          ],
                                        )),
                                        Expanded(
                                            child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                                child: getTextBold(
                                                    "Trạng thái: ",
                                                    listHistory
                                                        .elementAt(index)
                                                        .status,
                                                    16)),
                                          ],
                                        ))
                                      ],
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Center(child: getTextBold("", "Đang cập nhật", 20));
        });
  }

  getSubString(String string) {
    return string.substring(string.length - 4).contains("\n")
        ? string.substring(string.length - 3)
        : string.substring(string.length - 4);
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

  RichText getTextBold(String title, String value, double size) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: title,
            style: TextStyle(color: Colors.black, fontSize: 16),
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
}

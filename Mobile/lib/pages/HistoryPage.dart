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
  final _formKey = GlobalKey<FormState>();
  TextEditingController _editingController = TextEditingController();
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
              appBar: common.getAppbar("Lịch sử", context),
              body: getBody(),
              bottomNavigationBar: common.getNavigationBar(context, null));
        });
  }

  getDiaglog(String image) {
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
          Iterable<MapEntry<String, History>> listHistory = [];
          if (historyResponse != null) {
            listHistory = historyResponse.listOfHistory.entries;
          }
          return listHistory.isNotEmpty
              ? ListView.builder(
                  itemCount: listHistory.length,
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    return Container(
                      height: common.getHeightContext(context) / 5.5,
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
                                        common.getHeightContext(context) / 7,
                                    decoration: BoxDecoration(
                                      color: listHistory
                                              .elementAt(index)
                                              .value
                                              .status
                                          ? Colors.green
                                          : Colors.red,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0)),
                                    ),
                                    child: RawMaterialButton(
                                      onPressed: () {
                                        listHistory
                                                    .elementAt(index)
                                                    .value
                                                    .imageCheckFace !=
                                                null
                                            ? getDiaglog(listHistory
                                                .elementAt(index)
                                                .value
                                                .imageCheckFace)
                                            : getDialog(listHistory
                                                .elementAt(index)
                                                .value);
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          getTextBold2(
                                              " ${listHistory.elementAt(index).key.substring(0, 3)}\n",
                                              "${getSubString(listHistory.elementAt(index).key)}",
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
                                                6),
                                    child: Column(
                                      children: <Widget>[
                                        Expanded(
                                            flex: 3,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Expanded(
                                                    flex: 1,
                                                    child: getTextBold(
                                                        "Chi nhánh:\n",
                                                        listHistory
                                                            .elementAt(index)
                                                            .value
                                                            .brandName,
                                                        16)),
                                                Expanded(
                                                    flex: 1,
                                                    child: getTextBold(
                                                        "Cửa hàng:\n",
                                                        listHistory
                                                            .elementAt(index)
                                                            .value
                                                            .storeName,
                                                        16)),
                                              ],
                                            )),
                                        Expanded(
                                            flex: 2,
                                            child: Center(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Expanded(
                                                      flex: 1,
                                                      child: getTextBold(
                                                          "Giờ vào: ",
                                                          listHistory
                                                              .elementAt(index)
                                                              .value
                                                              .checkin,
                                                          16)),
                                                ],
                                              ),
                                            )),
                                        Expanded(
                                            flex: 5,
                                            child: getTextBold(
                                                "Địa chỉ: ",
                                                listHistory
                                                    .elementAt(index)
                                                    .value
                                                    .address,
                                                14))
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

  getDialog(History history) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)), //this right here
        child: Container(
          height: 400,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
            child: Container(
              height: 350,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: 330,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8),
                              child: Container(
                                  width: 120,
                                  decoration: BoxDecoration(
                                      border: Border(
                                    bottom: BorderSide(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                  )),
                                  child: Center(
                                    child: Text(
                                      "Yêu cầu",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: buildContainer("Chi nhánh",
                                            "${history.brandName}"),
                                        flex: 1,
                                      ),
                                      Expanded(
                                        child: buildContainer(
                                            "Cửa hàng", "${history.storeName}"),
                                        flex: 1,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: buildContainer(
                                            "Giờ vào", "${history.checkin}"),
                                        flex: 1,
                                      ),
                                      Expanded(
                                        child: buildContainer("Ngày",
                                            "${getSubString(history.date)}"),
                                        flex: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                buildContent(),
                              ],
                            ),
                          )
                        ],
                      )),
                  Container(child: getButtonRequest(history.workshiftId))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  getButtonRequest(int workShiftId) {
    return Container(
      width: common.getWidthContext(context),
      height: common.getHeightContext(context) / 20,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    sendRequest(workShiftId);
                    Navigator.of(context).pop();
                    showSuccessMessage();
                  }
                },
                child: Text(
                  "Gửi yêu cầu",
                  style: TextStyle(color: Colors.white),
                ),
                color: const Color(0xFF1BC0C5),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Hủy bỏ",
                  style: TextStyle(color: Colors.white),
                ),
                color: const Color(0xFF1BC0C5),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future showSuccessMessage() {
    return showDialog(
        context: context,
        builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)), //this right here
              child: Container(
                height: common.getHeightContext(context) / 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Gửi yêu cầu thành công",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
            ));
  }

  sendRequest(int workShiftId) async {
    return await historyBloc.sendRequest(
        common.userToken, common.userId, workShiftId, _editingController.text);
  }

  buildContent() {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "Nội dung",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Form(
          key: _formKey,
          child: Container(
              height: common.getHeightContext(context) / 10,
              width: common.getWidthContext(context) / 1.6,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(width: 1, color: Colors.black)),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 7, 0, 0),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Nội dung?"),
                      validator: (value) {
                        if (value.isEmpty || value == null) {
                          return "Nội dung không thể để trống";
                        }
                        if (value.length > 200) return "Nội dung quá dài";
                        return null;
                      },
                    )),
              )),
        ),
      ],
    ));
  }

  buildContainer(String title, String value) {
    return Container(
        child: Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "$title",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: common.getWidthContext(context) / 3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.all(width: 1, color: Colors.black)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 2, 0, 0),
                child: Text("$value",
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ],
    ));
  }
}

import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:eaw/blocs/HomeBloc.dart';
import 'package:eaw/dto/HomeResponse.dart';
import 'package:eaw/dto/LastAttendance.dart';
import 'package:eaw/dto/NextWorkShift.dart';
import 'package:eaw/dto/RequestQR.dart';
import 'package:eaw/resource/CommonComponent.dart';
import 'package:eaw/resource/SharedPreferences.dart';
import 'package:eaw/resource/urlEnum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:barcode_scan/barcode_scan.dart';

class HomePage extends StatefulWidget {
  final BuildContext context;

  HomePage(this.context);

  @override
  HomePageState createState() => HomePageState(context);
}

class HomePageState extends State<HomePage> {
  BuildContext context;
  DateTime dateTime = DateTime.now();
  DateFormat dateFormat = new DateFormat("dd-MM-yyyy");
  String startDate, endDate;
  int dayNr;
  DateTime thisMonday, thisSunday;
  String stringScanner;
  Map<String, Object> listContent = {
    "Ca kế tiếp": null,
    "Tổng giờ trong tuần": null,
    "Điểm danh gần nhất": null,
  };
  HomePageState(this.context) {
    getStartDate();
    // setMapValue();
  }

  HomeResponse homeResponse;

  @override
  void initState() {
    common.checkNetWork(context);
    super.initState();
  }

  getHome() async {
    await homeBloc.getHome(await sharedRef.getStringValuesSF(ShareRef.tokenKey),
        await sharedRef.getIntValuesSF(ShareRef.userId));
  }

  getStartDate() {
    int today = dateTime.weekday;
    dayNr = (today + 6) % 7;
    thisMonday = dateTime.subtract(new Duration(days: (dayNr)));
    startDate = dateFormat.format(thisMonday);
    thisSunday = thisMonday.add(new Duration(days: 6));
    endDate = dateFormat.format(thisSunday);
  }

  getAppbar(String title) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      backgroundColor: Colors.blue,
      leading: GestureDetector(
        onTap: () {
          /* Write listener code here */
        },
        child: Icon(
          Icons.menu, // add custom icons also
        ),
      ),
      actions: <Widget>[
        IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: null),
        PopupMenuButton(onSelected: (selection) {
          switch (selection) {
            case "Đăng xuất":
              common.getNavigator(context, Pages.getLoadingSignOutPage, null);
              break;
          }
        }, itemBuilder: (BuildContext context) {
          return ItemPopup.choices
              .map((e) => PopupMenuItem(value: e, child: Text(e)))
              .toList();
        })
      ],
    );
  }

  getAvatar() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              width: common.getWidthContext(context) / 2.5,
              height: common.getHeightContext(context) / 4.6,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image:
                            // AssetImage("assets/unknow.png")
                            common.getImage() != null
                                ? common.getImage()
                                : AssetImage("assets/unknow.png"))),
              ),
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Container(child: getUserName(common.getName()))
        ]);
  }

  Text getUserName(String text) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getHome(),
        builder: (context, AsyncSnapshot snapshot) {
          return StreamBuilder(
              stream: homeBloc.getHomeResponse,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  homeResponse = snapshot.data;
                  if (homeResponse != null) {
                    setMapValue();
                  }
                }

                return Scaffold(
                    appBar: getAppbar("Trang chủ"),
                    body: getBody(),
                    bottomNavigationBar:
                        common.getNavigationBar(context, null));
              });
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
            height: common.getHeightContext(context) / 3.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                getAvatar(),
              ],
            ),
          ),
          buildTitleBar(),
          Container(
              width: common.getWidthContext(context),
              height: common.getHeightContext(context) / 2.5,
              child: getContent())
        ],
      ),
    );
  }

  Container buildTitleBar() {
    return Container(
      width: common.getWidthContext(context),
      height: common.getHeightContext(context) / 14,
      color: Colors.black12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: common.getWidthContext(context) / 3.5,
            child: Center(
                child: Text("Hôm nay",
                    style: TextStyle(fontSize: 20, color: Colors.white))),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("${dateFormat.format(dateTime)}",
                  style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
          ),
          Expanded(
            flex: 1,
            child: buildScanCameraButton(),
          )
        ],
      ),
    );
  }

  buildScanCameraButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[400], borderRadius: BorderRadius.circular(8)),
        child: OutlineButton(
          onPressed: () async {
            String codeSanner = await BarcodeScanner.scan();
            var wifiName = await (Connectivity().getWifiName());
            Map<String, dynamic> map = jsonDecode(codeSanner);
            RequestQr requestQr = RequestQr(
                faceMachineCode: map['faceMachineCode'],
                createTime: map['createTime'],
                empCode: homeResponse.empCode,
                wifiName: wifiName);
            bool result = await homeBloc.sendRequestAttendanceByQr(
                requestQr, common.userToken);
            showDialog(
              context: context,
              builder: (context) => Dialog(child: buildSuccessDialog(result)),
            );
          },
          child: Text("Scan QR"),
        ),
      ),
    );
  }

  buildSuccessDialog(bool result) {
    return result
        ? buildContentDialog("assets/AGreat_Job_clip_art.gif")
        : buildContentDialog("assets/failed.jpg");
  }

  buildContentDialog(String path) {
    return Container(
      color: Colors.blue,
      width: common.getWidthContext(context) / 1.5,
      height: common.getHeightContext(context) / 2.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: common.getWidthContext(context) / 1.5,
            height: common.getHeightContext(context) / 4,
            decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.rectangle,
                image:
                    DecorationImage(fit: BoxFit.fill, image: AssetImage(path))),
          ),
          SizedBox(
            height: 30,
          ),
          RaisedButton(
              child: Text("Đóng"),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ],
      ),
    );
  }

  Widget getContent() {
    Iterable<MapEntry<String, Object>> entry = listContent.entries;
    return ListView.builder(
      itemCount: entry.length,
      itemBuilder: (context, index) => Container(
        width: common.getWidthContext(context),
        height: common.getHeightContext(context) / 7,
        child: Card(
          color: Colors.white70,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
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
                        "${entry.elementAt(index).key}",
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
                        child: getColunm(entry.elementAt(index).key,
                            entry.elementAt(index).value)))
              ],
            ),
          ),
        ),
        margin: EdgeInsets.only(bottom: 2),
      ),
    );
  }

  loadingData() {
    return Container(
      child: SpinKitFadingCircle(
        color: Colors.white,
        size: 10,
      ),
    );
  }

  getColunm(String key, Object object) {
    switch (key.trim()) {
      case "Tổng giờ trong tuần":
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text("Tổng giờ làm trong tuần",
                  style: TextStyle(fontSize: 15, color: Colors.black)),
              Text(
                  "( ${dateFormat.format(thisMonday)} - ${dateFormat.format(thisSunday)} )",
                  style: TextStyle(color: Colors.black)),
              Text(object != null ? "$object giờ" : "Đang cập nhật",
                  style: TextStyle(fontSize: 20, color: Colors.black)),
            ],
          ),
        );
        break;
      default:
        return object != null
            ? SingleChildScrollView(
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: common.getHeightContext(context) / 7),
                    child: getContentByTitle(key.trim(), object)),
              )
            : Container(
                child: Center(
                    child: Text("Đang cập nhật",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
              );
        break;
    }
  }

  Column getContentByTitle(String key, Object object) {
    NextWorkShift nextWorkShift;
    LastAttendance lastAttendance;
    switch (key) {
      case "Ca kế tiếp":
        nextWorkShift = object as NextWorkShift;
        break;
      case "Điểm danh gần nhất":
        lastAttendance = object as LastAttendance;
        break;
    }
    return homeResponse != null
        ? Column(
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
                            child: getTextBold(
                                "Ngày: ",
                                nextWorkShift != null
                                    ? nextWorkShift.workDate
                                    : lastAttendance.workDate,
                                14)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                            child: getTextBold(
                                "Cửa hàng: ",
                                nextWorkShift != null
                                    ? nextWorkShift.storeName
                                    : lastAttendance.storeName,
                                14)),
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
                        child: getTextBold(
                            "Từ: ",
                            nextWorkShift != null
                                ? nextWorkShift.startDate
                                : lastAttendance.startDate,
                            14),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          child: getTextBold(
                              "Đến: ",
                              nextWorkShift != null
                                  ? nextWorkShift.endDate
                                  : lastAttendance.endDate,
                              14),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: getTextBold(
                            "Địa chỉ: ",
                            nextWorkShift != null
                                ? nextWorkShift.address
                                : lastAttendance.address,
                            14),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        : loadingData();
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

  setMapValue() {
    listContent = Map();
    double totalHours = homeResponse.totalHours;
    LastAttendance lastAttendance = homeResponse.lastAttendance;
    NextWorkShift nextShift = homeResponse.nextWorkShift;
    listContent.putIfAbsent("Ca kế tiếp", () => nextShift);
    listContent.putIfAbsent("Tổng giờ trong tuần", () => "$totalHours");
    listContent.putIfAbsent("Điểm danh gần nhất", () => lastAttendance);
  }
}

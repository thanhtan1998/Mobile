import 'dart:convert';
import 'dart:io';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:connectivity/connectivity.dart';
import 'package:eaw/blocs/HistoryBloc.dart';
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
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  final BuildContext context;

  HomePage(this.context);

  @override
  HomePageState createState() => HomePageState(context);
}

class HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _editingController = TextEditingController();
  BuildContext context;
  DateTime dateTime = DateTime.now();
  DateFormat dateFormat = new DateFormat("dd-MM-yyyy");
  String startDate, endDate;
  int dayNr;
  DateTime thisMonday, thisSunday;
  String stringScanner, wifiName;
  final Connectivity _connectivity = Connectivity();
  Map<String, Object> listContent = {
    "Ca kế tiếp": null,
    "Tổng giờ trong tuần": null,
    "Điểm danh gần nhất": null,
  };
  HomePageState(this.context) {
    getStartDate();
  }

  HomeResponse homeResponse;

  @override
  void initState() {
    common.checkNetWork(context);
    super.initState();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    if (!mounted) {
      return Future.value(null);
    }
    if (Platform.isAndroid) {
      var status = await Permission.location.status;
      if (status.isUndetermined || status.isDenied || status.isRestricted) {
        if (await Permission.location.request().isGranted) {
          print('Location permission granted');
        } else {
          print('Location permission not granted');
        }
      } else {
        print('Permission already granted (previous execution?)');
      }
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        wifiName = await _connectivity.getWifiName();
        break;
      case ConnectivityResult.mobile:
        wifiName = "Mobile Network";
        break;
      case ConnectivityResult.none:
        wifiName = "Network Error";
        break;
    }
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
          Expanded(child: getContent())
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
                    style: TextStyle(fontSize: 24, color: Colors.white))),
          ),
          Expanded(
            child: buildRequestButton(),
          ),
          Expanded(
            child: buildScanQRButton(),
          )
        ],
      ),
    );
  }

  buildScanQRButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[400], borderRadius: BorderRadius.circular(8)),
        child: OutlineButton(
            onPressed: () async {
              try {
                common.checkNetWork(context);
                initConnectivity();
                if (this.wifiName.contains("Error")) {
                  return;
                }
                String codeSanner = await BarcodeScanner.scan();
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
                  builder: (context) =>
                      Dialog(child: buildSuccessDialog(result)),
                );
              } catch (e) {
                print(e);
              }
            },
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.camera_enhance,
                  color: Colors.pink,
                  size: 24.0,
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text("Quét QR"),
                )
              ],
            )),
      ),
    );
  }

  buildRequestButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[400], borderRadius: BorderRadius.circular(8)),
        child: OutlineButton(
          onPressed: () async {
            await common.checkNetWork(context);
            await initConnectivity();
            if (this.wifiName.contains("Error")) {
              return;
            }
            DateTime now = DateTime.now();
            getDialog(now, this.wifiName);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  child: Icon(
                    Icons.add_box,
                    color: Colors.pink,
                    size: 24.0,
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                flex: 3,
                child: Text("Điểm danh"),
              )
            ],
          ),
        ),
      ),
    );
  }

  getDialog(DateTime createTime, String wifiName) {
    showDialog(
      context: this.context,
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
                                        child:
                                            buildContainer("Cửa hàng", "EL111"),
                                        flex: 1,
                                      ),
                                      Expanded(
                                        child: buildContainer("Ngày",
                                            "${dateFormat.format(createTime)}"),
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
                                        child: buildContainer("Giờ vào",
                                            "${createTime.hour}:${createTime.minute}"),
                                        flex: 1,
                                      ),
                                      Expanded(
                                        child: buildContainer(
                                            "Tên Wifi", wifiName),
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
                  Container(
                      child: getButtonRequest(
                          wifiName, createTime.toIso8601String()))
                ],
              ),
            ),
          ),
        ),
      ),
    );
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

  getButtonRequest(String wifiname, String createTime) {
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
                onPressed: () async {
                  await common.checkNetWork(context);
                  await initConnectivity();
                  if (this.wifiName.contains("Error")) {
                    return;
                  }
                  if (_formKey.currentState.validate()) {
                    sendRequest(wifiname, createTime);
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

  sendRequest(String wifiName, String createTime) async {
    return await historyBloc.sendRequest(common.userToken, common.userId,
        createTime, _editingController.text, wifiName);
  }

  Future showSuccessMessage() {
    return showDialog(
        context: context,
        builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)), //this right here
              child: Container(
                height: common.getHeightContext(context) / 5,
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
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: common.getWidthContext(context) / 3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(width: 1, color: Colors.black)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 2, 0, 0),
                    child: Text("$value",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ));
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
    if (nextWorkShift != null)
      return Column(
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
                            nextWorkShift.workDate != null
                                ? nextWorkShift.workDate
                                : "Cập nhật",
                            14)),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        child: getTextBold(
                            "Cửa hàng: ",
                            nextWorkShift.storeName != null
                                ? nextWorkShift.storeName
                                : "Cập nhật",
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
                Container(
                  child: getTextBold(
                      "Từ: ",
                      nextWorkShift.startDate != null
                          ? nextWorkShift.startDate
                          : "Cập nhật",
                      14),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      child: getTextBold(
                          "Đến: ",
                          nextWorkShift.endDate != null
                              ? nextWorkShift.endDate
                              : "Cập nhật",
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
                        nextWorkShift.address != null
                            ? nextWorkShift.address
                            : "Cập nhật",
                        14),
                  ),
                ),
              ],
            ),
          )
        ],
      );
    else
      return Column(
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
                            lastAttendance.date != null
                                ? lastAttendance.date.split("\n")[1]
                                : "Cập nhật",
                            14)),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        child: getTextBold(
                            "Cửa hàng: ",
                            lastAttendance.storeName != null
                                ? lastAttendance.storeName
                                : "Cập nhật",
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
                Container(
                  child: getTextBold(
                      "Thời gian: ",
                      lastAttendance.time != null
                          ? lastAttendance.time
                          : "Cập nhật",
                      14),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      child: getTextBold(
                          "Loại: ",
                          lastAttendance.mode != null
                              ? lastAttendance.mode
                              : "Cập nhật",
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
                        "Trạng thái: ",
                        lastAttendance.status != null
                            ? lastAttendance.status
                            : "Cập nhật",
                        14),
                  ),
                ),
              ],
            ),
          )
        ],
      );
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

import 'package:eaw/blocs/InformationBloc.dart';
import 'package:eaw/dto/InformationResponse.dart';
import 'package:eaw/pages/EditPage.dart';
import 'package:eaw/resource/CommonComponent.dart';
import 'package:eaw/resource/SharedPreferences.dart';
import 'package:eaw/resource/urlEnum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class InformationPage extends StatefulWidget {
  BuildContext context;

  InformationPage(this.context);

  @override
  _InformationPageState createState() => _InformationPageState(context);
}

class _InformationPageState extends State<InformationPage> {
  static final icon = Icon(Icons.edit);
  static final icon2 = Icon(Icons.block);
  DateTime dateTime;
  DateFormat dateFormat = new DateFormat("dd-MM-yyyy");
  DateFormat dateFormat2 = new DateFormat("yyyy-MM-dd");
  Map<String, Icon> listOfTitle = {
    "Chi nhánh": icon2,
    "Cừa hàng": icon2,
    "Chức vụ": icon2,
    "Địa chỉ": icon,
    "Sinh nhật": icon,
    "Gmail": icon,
    "Số điện thoại": icon,
  };
  Map<String, String> listOfContent;
  BuildContext context;
  InformationResponse informationResponse;
  @override
  void initState() {
    common.checkNetWork(context);
    super.initState();
  }

  _InformationPageState(this.context);

  loadInformation() async {
    await informationBloc.getInformation(
        await sharedRef.getStringValuesSF(ShareRef.tokenKey),
        await sharedRef.getIntValuesSF(ShareRef.userId));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadInformation(),
        builder: (context, AsyncSnapshot snapshot) {
          return StreamBuilder(
              stream: informationBloc.getInformationResponse,
              builder: (context, asyncSnapshot) {
                informationResponse = asyncSnapshot.data;
                if (informationResponse != null) setMapData();
                return Scaffold(
                    resizeToAvoidBottomInset: false,
                    appBar: common.getAppbar("Thông tin", context),
                    body: getBody(),
                    bottomNavigationBar:
                        common.getNavigationBar(context, null));
              });
        });
  }

  Future<void> showDate() async {
    await showDatePicker(
            context: context,
            initialDate: dateTime,
            firstDate: DateTime(dateTime.year - 5),
            lastDate: DateTime(dateTime.year + 5))
        .then((value) {
      if (value != null)
        informationResponse.dayOfBirth = dateFormat2.format(value);
      informationBloc.updateInformation(common.userToken, common.userId,
          "Sinh nhật", informationResponse.dayOfBirth);
      dateTime = DateTime.parse(informationResponse.dayOfBirth);
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
                common.getAvatar(context),
              ],
            ),
          ),
          Expanded(child: getContent()),
        ],
      ),
    );
  }

  getContent() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Container(
        width: common.getWidthContext(context),
        height: common.getHeightContext(context) / 2.2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: getRow(),
        ),
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

  getRow() {
    return listOfTitle.entries
        .map((e) => Container(
              margin: EdgeInsets.only(top: 2),
              width: common.getWidthContext(context),
              height: common.getHeightContext(context) / 16,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Text(e.key,
                          style: GoogleFonts.aBeeZee(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: informationResponse != null
                            ? Text(
                                getDataInMap(e.key), // map data
                                style: GoogleFonts.lato(
                                    color: Colors.white, fontSize: 18),
                              )
                            : loadingData(),
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          color: Colors.white,
                          width: 0.3,
                        ),
                      )),
                    ),
                  ),
                  informationResponse != null
                      ? getIcon(e.key, getDataInMap(e.key), e.value)
                      : loadingData()
//          )
                ],
              ),
            ))
        .toList();
  }

  setMapData() {
    dateTime = DateTime.parse(informationResponse.dayOfBirth);
    listOfContent = Map<String, String>();
    listOfContent.putIfAbsent("Chi nhánh", () => informationResponse.brand);
    listOfContent.putIfAbsent("Cừa hàng", () => "7-11 Fpt");
    listOfContent.putIfAbsent("Chức vụ", () => informationResponse.role);
    listOfContent.putIfAbsent("Sinh nhật", () => dateFormat.format(dateTime));
    listOfContent.putIfAbsent("Địa chỉ", () => informationResponse.address);
    listOfContent.putIfAbsent("Gmail", () => informationResponse.email);
    listOfContent.putIfAbsent("Số điện thoại", () => informationResponse.phone);
  }

  getDataInMap(String key) {
    String data = "error";
    if (listOfContent.containsKey(key.trim())) {
      data = listOfContent[key.trim()];
    }
    return data;
  }

  getIcon(String title, String oldValue, Icon e) {
    if (title.trim() != "Cừa hàng" &&
        title.trim() != "Chi nhánh" &&
        title.trim() != "Gmail" &&
        title.trim() != "Chức vụ") {
      return Expanded(
          flex: 1,
          child: IconButton(
            icon: e,
            onPressed: () => title.trim().compareTo("Sinh nhật") != 0
                ? showDialog(
                    context: context,
                    builder: (context) => EditPage(title, oldValue),
                  )
                : showDate(),
          ));
    }

    return Expanded(
      flex: 1,
      child: Text(""),
    );
  }
}

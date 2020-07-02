import 'package:eaw/pages/EditPage.dart';
import 'package:eaw/resource/CommonComponent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InformationPage extends StatefulWidget {
  BuildContext context;

  InformationPage(this.context);

  @override
  _InformationPageState createState() => _InformationPageState(context);
}

class _InformationPageState extends State<InformationPage> {
  static final icon = Icon(Icons.edit);
  static final icon2 = Icon(Icons.block);
  Map<String, Icon> listOfTitle = {
    "Branch: ": icon2,
    "Store: ": icon2,
    "Position: ": icon2,
    "BirthDay: ": icon,
    "Gmail: ": icon,
    "Phone: ": icon,
  };
  BuildContext context;

  _InformationPageState(this.context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: common.getAppbar("Information", context),
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
//            color: Colors.blue,
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
            child: getContent(),
          ),
        ],
      ),
    );
  }

  getContent() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: common.getWidthContext(context),
        height: common.getHeightContext(context) / 2.1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: getRow(),
        ),
      ),
    );
  }

  getRow() {
    return listOfTitle.entries
        .map((e) => Container(
              margin: EdgeInsets.only(top: 8),
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
//                              backgroundColor: Colors.white12
                            color: Colors.white,
                          )),
                    ),
                  ),
                  Expanded(
                    // khi nào có data API thì viết function riêng r add data theo map
                    flex: 5,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Thanh Tân",
                          style: GoogleFonts.lato(
                              color: Colors.white,
//                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
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
                  getIcon(e.key, "Thanh Tân", e.value)
//          )
                ],
              ),
            ))
        .toList();
  }

  getIcon(String title, String oldValue, Icon e) {
    if (title.trim() != "Store:" &&
        title.trim() != "Branch:" &&
        title.trim() != "Position:") {
      return Expanded(
          flex: 1,
          child: IconButton(
            icon: e,
            onPressed: () => showDialog(
              context: context,
              builder: (context) => EditPage(title, oldValue),
            ),
          ));
    }

    return Expanded(
      flex: 1,
      child: Text(""),
    );
  }
}

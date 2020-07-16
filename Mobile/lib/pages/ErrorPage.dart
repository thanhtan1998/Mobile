import 'package:eaw/resource/CommonComponent.dart';
import 'package:eaw/resource/urlEnum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatefulWidget {
  final String errorMess;
  final BuildContext context;
  ErrorPage(this.errorMess, this.context);
  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false, body: getBodyLogin());
  }

  getBodyLogin() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: common.getHeightContext(context) / 3,
              width: common.getWidthContext(context) / 1.2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/noInternet.jpg'),
                  fit: BoxFit.fill,
                ),
                shape: BoxShape.rectangle,
              ),
            ),
            Container(
              width: common.getWidthContext(context) / 3,
              decoration: BoxDecoration(color: Colors.blueGrey),
              child: OutlineButton(
                  onPressed: () {
                    common.getNavigator(context, Pages.getFirstTimePage, null);
                  },
                  child: Text("Thử lại")),
            )
          ],
        ));
  }
}

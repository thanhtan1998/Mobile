import 'package:eaw/resource/CommonComponent.dart';
import 'package:eaw/resource/urlEnum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatefulWidget {
  final BuildContext context;

  ErrorPage(this.context);
  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Not Found")),
      ),
      body: Container(
        width: common.getWidthContext(context),
        height: common.getHeightContext(context),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Container(
              height: common.getHeightContext(context) / 2,
              width: common.getWidthContext(context) / 1.2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/notfound.png"))),
            ),
            Text(
              "Tài khoản không tồn tại trong hệ thống",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              color: Colors.grey,
              height: common.getHeightContext(context) / 18,
              width: common.getWidthContext(context) / 2,
              child: OutlineButton(
                onPressed: () {
                  common.getNavigator(context, Pages.getLoginPage, null);
                },
                child: Text("Quay về trang đăng nhập"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

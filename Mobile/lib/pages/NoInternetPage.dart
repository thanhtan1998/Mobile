import 'package:eaw/resource/CommonComponent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoInternetPage extends StatefulWidget {
  final String pages;
  final BuildContext context;
  NoInternetPage({this.pages, this.context});
  @override
  _NoInternetPageState createState() => _NoInternetPageState();
}

class _NoInternetPageState extends State<NoInternetPage> {
  @override
  Widget build(BuildContext context) {
    return getBodyLogin();
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
                    common.getNavigator(context, widget.pages, null);
                  },
                  child: Text("Thử lại")),
            )
          ],
        ));
  }
}

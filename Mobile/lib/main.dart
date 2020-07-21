import 'package:eaw/pages/ErrorPage.dart';
import 'package:eaw/pages/FirstTimePage.dart';
import 'package:eaw/pages/HistoryPage.dart';
import 'package:eaw/pages/HomePage.dart';
import 'package:eaw/pages/InfomationPage.dart';
import 'package:eaw/pages/LoadingLogOut.dart';
import 'package:eaw/pages/LoadingToHomePage.dart';
import 'package:eaw/pages/LoginPage.dart';
import 'package:eaw/pages/RequestPage.dart';
import 'package:eaw/pages/SchedulePage.dart';
import 'package:eaw/resource/urlEnum.dart';
import 'package:flutter/material.dart';

void main() {
//  runApp(MaterialApp(home: FcmHandler(),));
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    // initialRoute: Pages.getLoginPage,
    initialRoute: Pages.getFirstTimePage,
    // initialRoute: Pages.getNotFoundPage,
    routes: <String, WidgetBuilder>{
      Pages.getLoginPage: (BuildContext context) => LoginPage(context),
      Pages.getHomePage: (BuildContext context) => HomePage(context),
      Pages.getRequestPage: (BuildContext context) => RequestPage(),
      Pages.getSchedulePage: (BuildContext context) => SchedulePage(context),
      Pages.getHistoryPage: (BuildContext context) => HistoryPage(context),
      Pages.getInformationPage: (BuildContext context) =>
          InformationPage(context),
      Pages.getLoadingToHomePage: (BuildContext context) =>
          LoadingToHomePage(context),
      Pages.getLoadingSignOutPage: (BuildContext context) =>
          LoadingSignOutPage(context),
      Pages.getFirstTimePage: (BuildContext context) => FirstTimePage(context),
      Pages.getNotFoundPage: (BuildContext context) => ErrorPage(context),
    },
  ));
}

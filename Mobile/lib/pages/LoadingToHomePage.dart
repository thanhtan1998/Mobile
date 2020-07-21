import 'package:eaw/blocs/LoginBloc.dart';
import 'package:eaw/dto/LoginRequest.dart';
import 'package:eaw/dto/LoginResponse.dart';
import 'package:eaw/resource/CommonComponent.dart';
import 'package:eaw/resource/SharedPreferences.dart';
import 'package:eaw/resource/urlEnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore: must_be_immutable
class LoadingToHomePage extends StatefulWidget {
  BuildContext context;

  LoadingToHomePage(this.context);

  @override
  _LoadingPageState createState() => _LoadingPageState(context);
}

class _LoadingPageState extends State<LoadingToHomePage> {
  LoginResponse response;

  @override
  void initState() {
    super.initState();
  }

  void checkLogin() async {
    Map data = ModalRoute.of(context).settings.arguments;
    if (data != null) {
      LoginRequest loginRequest = data['data'];
      await loginBloc.checkLogin(loginRequest);
      response = loginBloc.getLoginResponse;
      if (response != null) {
        setShareRefData(response);
        common.setDataLogin();
        common.getNavigator(context, Pages.getHomePage, null);
      } else {
        common.getNavigator(context, Pages.getNotFoundPage, null);
      }
    } else {
      common.setDataLogin();
      common.getNavigator(context, Pages.getHomePage, null);
    }
  }

  setShareRefData(LoginResponse response) {
    sharedRef.addStringToSF(ShareRef.tokenKey, response.userToken);
    sharedRef.addIntToSF(ShareRef.userId, response.userId);
    sharedRef.addStringToSF(ShareRef.userName, response.userName);
    sharedRef.addStringToSF(ShareRef.image, response.image);
  }

  BuildContext context;

  _LoadingPageState(this.context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.blue[900],
        child: Center(
          child: SpinKitWave(
            color: Colors.white,
            size: 50.0,
          ),
        ));
  }
}

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
    LoginRequest loginRequest = data['data'];
    if (loginRequest != null) {
      await loginBloc.checkLogin(loginRequest);
      response = loginBloc.getLoginResponse;
      if (response != null) {
        sharedRef.addStringToSF(ShareRef.tokenKey, response.userToken);
        sharedRef.addIntToSF(ShareRef.userId, response.userId);
        //  await homeBloc.getHome(response.userToken, response.userId);
        //  HomeResponse homeResponse = homeBloc.getHomeResponse;
        //  if(homeResponse != null){
        //    sharedRef.addStringToSF(ShareRef.userName, homeResponse.userName);
        //    common.getUsername();
        //    common.getNavigator(context, Pages.getHomePage, homeResponse);
        //  }
        common.getNavigator(context, Pages.getHomePage, null);
      } else {
        common.getNavigator(context, Pages.getLoginPage, null);
      }
    }
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

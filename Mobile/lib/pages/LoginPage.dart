import 'package:eaw/blocs/GoogleBloc.dart';
import 'package:eaw/resource/CommonComponent.dart';
import 'package:eaw/resource/urlEnum.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  BuildContext context;

  LoginPage(this.context);

  @override
  _LoginPageState createState() => _LoginPageState(context);
}

class _LoginPageState extends State<LoginPage> {
  BuildContext context;
  String page;

  _LoginPageState(this.context);
  @override
  void initState() {
    common.checkNetWork(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false, body: getBodyLogin());
  }

  Widget getBodyLogin() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[getLogo(), _signInButton()],
      ),
    );
  }

  Widget getLogo() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
      child: Container(
          width: MediaQuery.of(context).size.width / 2.2,
          height: MediaQuery.of(context).size.height / 4,
          decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              image: new DecorationImage(
                  fit: BoxFit.fill, image: new AssetImage("assets/lgo.png")))),
    );
  }

  Widget _signInButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 120.0),
      child: OutlineButton(
        color: Colors.white,
        splashColor: Colors.grey,
        onPressed: () {
          googleBloc.getLoginRequest.listen((event) {
            if (event != null)
              common.getNavigator(context, Pages.getLoadingToHomePage, event);
          });
          googleBloc.signInGoogle();
        },
        //    bool isLogin = googleBloc.signInGoogle();
        //     if (isLogin)
        //       common.getNavigator(context, Pages.getLoadingToHomePage, googleBloc.getLoginRequest);
        // },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        highlightElevation: 0,
        borderSide: BorderSide(color: Colors.grey),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Container(
                    width: 70,
                    height: 60,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new AssetImage("assets/google_logo.png")))),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Sign in with Google',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

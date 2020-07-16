import 'package:eaw/blocs/GoogleBloc.dart';
import 'package:eaw/resource/CommonComponent.dart';
import 'package:eaw/resource/urlEnum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore: must_be_immutable
class LoadingSignOutPage extends StatefulWidget {
  BuildContext context;

  LoadingSignOutPage(this.context);

  @override
  _LoadingSignOutPageState createState() => _LoadingSignOutPageState(context);
}

class _LoadingSignOutPageState extends State<LoadingSignOutPage> {
  BuildContext context;

  _LoadingSignOutPageState(this.context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      signOut();
    });
  }

  signOut() {
    googleBloc.signOutGoogle();
    common.getNavigator(context, Pages.getLoginPage, null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.blue[900],
        child: Center(
          child: SpinKitFadingCircle(
            color: Colors.white,
            size: 50.0,
          ),
        ));
  }
}

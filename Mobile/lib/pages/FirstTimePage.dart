import 'package:eaw/resource/CommonComponent.dart';
import 'package:eaw/resource/urlEnum.dart';
import 'package:flutter/cupertino.dart';

class FirstTimePage extends StatefulWidget {
  @override
  _FirstTimePageState createState() => _FirstTimePageState();
}

class _FirstTimePageState extends State<FirstTimePage> {



  _FirstTimePageState(){checkFirstTime();}
  void checkFirstTime() async {
    await common
        .firstTimeBuild()
        .then((value) => WidgetsBinding.instance.addPostFrameCallback((_) {
              if (value != null) {
                common.getNavigator(context, Pages.getHomePage, null);
              } else {
                common.getNavigator(context, Pages.getLoginPage, null);
              }
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

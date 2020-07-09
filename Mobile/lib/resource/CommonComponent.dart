import 'package:eaw/resource/SharedPreferences.dart';
import 'package:eaw/resource/urlEnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonComponent {
  int currentIndex = 0;
  String userName;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 12, fontWeight: FontWeight.bold);
  static const TextStyle bootomText =
  TextStyle(fontWeight: FontWeight.bold, fontSize: 14);
  getHeightContext(BuildContext context){
    return  MediaQuery.of(context).size.height;
  }
  getWidthContext(BuildContext context){
    return  MediaQuery.of(context).size.width;
  }

  getAppbar(String title, BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      backgroundColor: Colors.blue,
      leading: GestureDetector(
        onTap: () {
          /* Write listener code here */
        },
        child: Icon(
          Icons.menu, // add custom icons also
        ),
      ),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.notifications,color: Colors.white,), onPressed: null),
        PopupMenuButton(
            onSelected: (selection) {
              switch (selection) {
                case "Đăng xuất":
                  common.getNavigator(
                      context, Pages.getLoadingSignOutPage, null);
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return ItemPopup.choices.map((e) =>
                  PopupMenuItem(value: e, child: Text(e))).toList();
            })
      ],
    );
  }
  getUsername()async{
    userName = await sharedRef.getStringValuesSF(ShareRef.userName);
    return userName;
  }
  getAvatar(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              width: getWidthContext(context) / 2.5,
              height:getHeightContext(context) / 4.6,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new AssetImage("assets/image.jpg"))),
//                        image: new NetworkImage("@{common.firebaseUser.photoUrl}"))),
              ),
            ),
          ),
          SizedBox(
            height:6,
          ),
          Container(
            child:  userName != null ? Text(
             userName  ,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ) : loadingData(),
          )
        ]);
  }
  loadingData() {
    return Container(
      child: SpinKitFadingCircle(
        color: Colors.white,
        size: 10,
      ),
    );
  }
  showIndexBody(int index) {
    currentIndex = index;
  }

  Future<bool> firstTimeBuild() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentIndex = 0;
    if (prefs.containsKey(ShareRef.tokenKey)) {
      return true;
    } else {
      return false;
    }
  }

  getNavigationBar(BuildContext context, Map mapAgrument) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home', style: bootomText),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          title: Text('Schema', style: bootomText),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          title: Text('History', style: bootomText),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          title: Text('Setting', style: bootomText),
        ),
      ],
      currentIndex: common.currentIndex,
      selectedItemColor: Colors.amber[800],
      onTap: (index) {
        showIndexBody(index);
        getNavigator(context, listPage[currentIndex], mapAgrument);
      },
    );
  }

  getNavigator(BuildContext context, String page, Object mapAgrument) {
      Future<void>.microtask(() async {
        mapAgrument != null
            ? Navigator.pushReplacementNamed(context, page,
            arguments: {'data': mapAgrument})
            : Navigator.pushReplacementNamed(context, page);
      });
  }

  List listPage = [
    Pages.getHomePage,
    Pages.getSchedulePage,
    Pages.getHistoryPage,
    Pages.getInformationPage
  ];
  List<String> listDay = [
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun",
  ];
  Map<String, String> mapDay={};
  Map<String, String> mapContent = {
    'Mon': 'Hai Ba Trung Street',
    'Tue': 'You\'re free',
    'Wed': 'Fpt University',
    'Thu': 'Tay Hoa Street',
    'Fri': 'Dai Lo 2 Street',
    'Sat': 'You\'re free',
    'Sun': 'You\'re free',
  };
  Map<String, String> mapColor = {
    'Mon': '0xFFc7ff9f',
    'Tue': '0xFFB71C1C',
    'Wed': '0xFFBF360C',
    'Thu': '0xFFE65100',
    'Fri': '0xFFF57F17',
    'Sat': '0xFF827717',
    'Sun': '0xFF33691E',
  };
}

class ItemPopup {
  static const String SignOut = "Đăng xuất";
  static const List<String> choices = [SignOut];
}

final common = CommonComponent();
final item = ItemPopup();

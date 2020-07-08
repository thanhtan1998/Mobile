import 'package:eaw/blocs/InformationBloc.dart';
import 'package:eaw/dto/InformationResponse.dart';
import 'package:eaw/pages/EditPage.dart';
import 'package:eaw/resource/CommonComponent.dart';
import 'package:eaw/resource/SharedPreferences.dart';
import 'package:eaw/resource/urlEnum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class InformationPage extends StatefulWidget {
  BuildContext context;

  InformationPage(this.context);

  @override
  _InformationPageState createState() => _InformationPageState(context);
}

class _InformationPageState extends State<InformationPage> {
  static final icon = Icon(Icons.edit);
  static final icon2 = Icon(Icons.block);
  Map<String, Icon> listOfTitle = {
    "Branch: ": icon2,
    "Store: ": icon2,
    "Position: ": icon2,
    "Address: ": icon2,
    "BirthDay: ": icon,
    "Gmail: ": icon,
    "Phone: ": icon,
  };
  Map<String, String> listOfContent;
  BuildContext context;
  InformationResponse informationResponse;

  _InformationPageState(this.context);

  loadInformation() async {
    await informationBloc.getInformation(
        await sharedRef.getStringValuesSF(ShareRef.tokenKey),
        await sharedRef.getIntValuesSF(ShareRef.userId));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadInformation(),
        builder: (context, AsyncSnapshot snapshot) {
          return StreamBuilder(
              stream: informationBloc.getInformationResponse,
              builder: (context, asyncSnapshot) {
                informationResponse = asyncSnapshot.data;


                  return Scaffold(
                      resizeToAvoidBottomInset: false,
                      appBar: common.getAppbar("Information", context),
                      body:getBody(),
                      bottomNavigationBar:
                          common.getNavigationBar(context, null));

              });
        });
  }

loadDataBody(){
  setMapData();
 return getContent();
}
  getBody() {
    return Container(
      width: common.getWidthContext(context),
      height: common.getHeightContext(context),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue, Colors.purple])),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
//            color: Colors.blue,
            width: common.getWidthContext(context),
            height: common.getHeightContext(context) / 3.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                common.getAvatar(context),
              ],
            ),
          ),
          Container(
            child:   informationResponse != null ? loadDataBody() : loadingData()
          ),
        ],
      ),
    );
  }

  getContent() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: common.getWidthContext(context),
        height: common.getHeightContext(context) / 2.1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: getRow(),
        ),
      ),
    );
  }
  loadingData(){
   return Column(
     mainAxisAlignment: MainAxisAlignment.center,
     crossAxisAlignment: CrossAxisAlignment.center,
     children: <Widget>[
       SizedBox(height: common.getHeightContext(context)/11,),
       Container(
         child: SpinKitWanderingCubes(
           itemBuilder: (BuildContext context, int index) {
             return DecoratedBox(
               decoration: BoxDecoration(
                 color: index.isEven ? Colors.white : Colors.green,
               ),
             );
           },
         ),
       ),
     ],
   );
  }
  getRow() {
    return listOfTitle.entries
        .map((e) => Container(
              margin: EdgeInsets.only(top: 4),
              width: common.getWidthContext(context),
              height: common.getHeightContext(context) / 17,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Text(e.key,
                          style: GoogleFonts.aBeeZee(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
//                              backgroundColor: Colors.white12
                            color: Colors.white,
                          )),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          getDataInMap(e.key), // map data
                          style: GoogleFonts.lato(
                              color: Colors.white,
//                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          color: Colors.white,
                          width: 0.3,
                        ),
                      )),
                    ),
                  ),
                  getIcon(e.key,  getDataInMap(e.key), e.value)
//          )
                ],
              ),
            ))
        .toList();
  }

  setMapData() {
    listOfContent = Map<String, String>();
    listOfContent.putIfAbsent("Branch:", () => informationResponse.brand);
    listOfContent.putIfAbsent("Store:", () => "7-11 Fpt");
    listOfContent.putIfAbsent("Position:", () => informationResponse.role);
    listOfContent.putIfAbsent(
        "BirthDay:", () => informationResponse.dayOfBirth);
    listOfContent.putIfAbsent("Address:", () => informationResponse.address);
    listOfContent.putIfAbsent("Gmail:", () => informationResponse.email);
    listOfContent.putIfAbsent("Phone:", () => informationResponse.phone);
  }

  getDataInMap(String key) {
    String data = "error";
    if (listOfContent.containsKey(key.trim())) {
      data = listOfContent[key.trim()];
    }
    return data;
  }

  getIcon(String title, String oldValue, Icon e) {
    if (title.trim() != "Store:" &&
        title.trim() != "Branch:" &&
        title.trim() != "Gmail:" &&
        title.trim() != "Address:" &&
        title.trim() != "Position:") {
      return Expanded(
          flex: 1,
          child: IconButton(
            icon: e,
            onPressed: () => showDialog(
              context: context,
              builder: (context) => EditPage(title, oldValue),
            ),
          ));
    }

    return Expanded(
      flex: 1,
      child: Text(""),
    );
  }
}

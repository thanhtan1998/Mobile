import 'package:eaw/resource/CommonComponent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  _RequestPageState();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)), //this right here
      child: Container(
        height: 400,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
          child: Container(
            height: 350,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 330,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                            child: Container(
                                width: 120,
                                decoration: BoxDecoration(
                                    border: Border(
                                  bottom: BorderSide(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                )),
                                child: Center(
                                  child: Text(
                                    "Request",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 4.0, bottom: 4),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: buildContainer("Chi nhánh", "111"),
                                      flex: 1,
                                    ),
                                    Expanded(
                                      child: buildContainer("Cửa hàng", "111"),
                                      flex: 1,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4.0, bottom: 4),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: buildContainer("Giờ vào", "111"),
                                        flex: 1,
                                      ),
                                      Expanded(
                                        child: buildContainer("Giờ ra", "111"),
                                        flex: 1,
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: buildContent(),
                          ),
                        )
                      ],
                    )),
                getButtonRequest()
              ],
            ),
          ),
        ),
      ),
    );
  }

  getButtonRequest() {
    return Container(
      width: 320.0,
      height: 40,
      child: RaisedButton(
        onPressed: () {},
        child: Text(
          "Request",
          style: TextStyle(color: Colors.white),
        ),
        color: const Color(0xFF1BC0C5),
      ),
    );
  }

  buildContent() {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "Content",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
            height: 80,
            width: 320,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.all(width: 1, color: Colors.black)),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 7, 0, 0),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Your content?"),
                  )),
            )),
      ],
    ));
  }

  buildContainer(String title, String value) {
    return Container(
        child: Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "$title",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: common.getWidthContext(context) / 3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.all(width: 1, color: Colors.black)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 7, 0, 0),
                child: Text("$value",
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ],
    ));
  }
}

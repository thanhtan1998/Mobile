import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RequestPage extends StatefulWidget {
  String store;
  String branch;

  RequestPage(this.store, this.branch);

  @override
  _RequestPageState createState() => _RequestPageState(store,branch);
}

class _RequestPageState extends State<RequestPage> {
  String store;
  String branch;

  _RequestPageState(this.store, this.branch);

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
            height: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    child: Column(
                      children: <Widget>[
                        Center(
                            child: Container(
                                width: 170,
                                height: 40,
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
                                        fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ))),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            width: 320,
                            height: 80,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "Branch",
                                    style: TextStyle(
                                        fontSize: 17, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    height: 40,
                                    width: 250,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                          border: Border.all(
                                              width: 1, color: Colors.black)),
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(8.0, 7, 0, 0),
                                        child: Text("${branch}",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    )),
                              ],
                            )),
                        Container(
                            width: 320,
                            height: 80,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "Store",
                                    style: TextStyle(
                                        fontSize: 17, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    height: 40,
                                    width: 250,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                          border: Border.all(
                                              width: 1, color: Colors.black)),
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(8.0, 7, 0, 0),
                                        child: Text("${store}",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    )),
                              ],
                            )),
                        Container(
                            width: 320,
                            height: 130,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "Content",
                                    style: TextStyle(
                                        fontSize: 17, fontWeight: FontWeight.bold),
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
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                          border: Border.all(
                                              width: 1, color: Colors.black)),
                                      child: Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(8.0, 7, 0, 0),
                                          child: TextField(
                                            keyboardType: TextInputType.multiline,
                                            maxLines: null,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Your content ?"),
                                          )
                                      ),
                                    )),

                              ],
                            )),
                      ],
                    )
                ),
                Container(
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

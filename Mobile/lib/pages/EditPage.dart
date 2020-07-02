import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  String title;
  String oldValue;

  EditPage(this.title,this.oldValue);
  @override
  _EditPageState createState() => _EditPageState(title,oldValue);
}

class _EditPageState extends State<EditPage> {
  String title ;
  String oldValue ;

  _EditPageState(this.title,this.oldValue);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)), //this right here
      child: Container(
        height: 300,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
          child: Container(
            height: 350,
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
                                "Editing Information",
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
                                "Old ${title}",
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
                                    child: Text("${oldValue}",
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
                                "New ${title}",
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
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "New ?"),
                                    )
                                  ),
                                )),

                          ],
                        )),
                  ],
                )
                    ),
                SizedBox(height: 10,),
                Container(
                  width: 320.0,
                  height: 40,
                  child: RaisedButton(
                    onPressed: () {},
                    child: Text(
                      "Save",
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

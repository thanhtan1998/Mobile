import 'package:eaw/blocs/InformationBloc.dart';
import 'package:eaw/resource/CommonComponent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditPage extends StatefulWidget {
  String title;
  String oldValue;

  EditPage(this.title, this.oldValue);
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  String title;
  String oldValue;
  TextEditingController _controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  _EditPageState();

  @override
  Widget build(BuildContext context) {
    title = widget.title;
    oldValue = widget.oldValue;
    return Form(
        key: formKey,
        child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
              child: Container(
                height: common.getHeightContext(context) / 2.3,
                width: common.getWidthContext(context) / 1.5,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0, top: 4),
                          child: Container(
                              width: common.getWidthContext(context) / 2.2,
                              height: common.getHeightContext(context) / 15,
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              )),
                              child: Center(
                                child: Text(
                                  "Cập nhật thông tin",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                        )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                            height: common.getHeightContext(context) / 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    "$title",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        border: Border.all(
                                            width: 1, color: Colors.black)),
                                    child: TextFormField(
                                      enabled: false,
                                      initialValue: "$oldValue",
                                      maxLines: 4,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "$title mới",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        width: common.getWidthContext(context),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            border: Border.all(
                                                width: 1, color: Colors.black)),
                                        child: buildTextField(
                                          title.contains("Số điện"),
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                            Expanded(
                                flex: 2,
                                child: Row(
                                  children: <Widget>[
                                    buildExpandedButton("Lưu lại", 1, () {
                                      updateInfor(
                                          common.userToken,
                                          common.userId,
                                          title,
                                          _controller.text);
                                    }),
                                    buildExpandedButton("Hủy bỏ", 1, () {
                                      Navigator.of(context).pop();
                                    }),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ]),
              ),
            )));
  }

  updateInfor(
      String userToken, int userId, String titleUpdate, Object value) async {
    await informationBloc.updateInformation(
        userToken, userId, titleUpdate, value);
    Navigator.of(context).pop();
  }

  Expanded buildExpandedButton(String title, int flex, Function function) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10),
        child: RaisedButton(
          onPressed: () {
            if (!title.contains("Hủy bỏ")) {
              if (formKey.currentState.validate()) {
                function();
              }
            } else {
              Navigator.of(context).pop();
            }
          },
          child: Text(
            "$title",
            style: TextStyle(color: Colors.white),
          ),
          color: const Color(0xFF1BC0C5),
        ),
      ),
    );
  }

  TextFormField buildTextField(bool isPhone) {
    return TextFormField(
      controller: _controller,
      textCapitalization: TextCapitalization.words,
      keyboardType: isPhone ? TextInputType.phone : TextInputType.multiline,
      maxLines: 5,
      decoration: InputDecoration(
        hintText: "$title mới",
      ),
      textInputAction: TextInputAction.next,
      validator: (value) {
        String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
        RegExp regExp = RegExp(pattern);
        if (value.isEmpty || value.length == 0) {
          return "$title không thể trống";
        }
        if (title.contains("Số điện thoại")) {
          if (value.length > 10 || value.length < 10) {
            return "Số điện thoại chỉ 10 số";
          }
          if (!regExp.hasMatch(value)) {
            return 'Chỉ nhập số';
          }
        }

        return null;
      },
    );
  }
}

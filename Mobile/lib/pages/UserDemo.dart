
import 'package:eaw/blocs/UserBlocs.dart';
import 'package:eaw/dto/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class aa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    userBloc.fetchUser();
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: StreamBuilder(
        stream: userBloc.listUser,
        builder: (context, AsyncSnapshot<List<User>> snapshot) {
          if (snapshot.hasData) {
            List<User> listUser = snapshot.data;
            return ListView(
              children: <Widget>[
                getTextWidgets(listUser)
              ],
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget getTextWidgets(List<User> users) {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < users.length; i++) {
      User u = users[i];
      list.add(Text(("${u.id}" +"\n"+u.email),style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20
      ), ),
     );
    }
    return Column(children: <Widget>[
      list.elementAt(0),
      SizedBox(height: 20,),
      list.elementAt(1),
      SizedBox(height: 20,),
      list.elementAt(2)
    ],);
  }
}
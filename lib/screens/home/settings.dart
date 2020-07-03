import 'package:flutter/material.dart';
import 'package:gofixit_demo_one/services/database.dart';
import 'package:gofixit_demo_one/model/UserModel.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return StreamBuilder<UserDataModel>(
      stream: DatabaseService(uid: user.userId).currentUserData,
      builder: (context, snapshot) {
        UserDataModel currentUser = snapshot.data;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.keyboard_backspace,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text("Profile",
                style: TextStyle(
                  fontSize: 25.0,
                )),
            elevation: 0.0,
            backgroundColor: Color(0xFF263238),
            actions: [
              IconButton(
                icon: FaIcon(FontAwesomeIcons.gamepad), 
                onPressed:null,
              )
            ],
          ),
          body: SafeArea(
            child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40.0,
                    ),
                    Center(
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    TextSec(label:"username",value:currentUser.username),
                    TextSec(label:"phone",value:currentUser.phone),
                    TextSec(label:"email",value:currentUser.email),
                  ],
                )),
          ),
        );
      },
    );
  }
}

class TextSec extends StatelessWidget {
  final String label;
  final String value;
  TextSec({this.label, this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          Text(value,
              style: TextStyle(
                fontSize: 20.0,
              )),
          Br(),
        ],
      ),
    );
  }
}

class Br extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          color: Colors.grey,
          height: 1.0,
        ))
      ],
    );
  }
}

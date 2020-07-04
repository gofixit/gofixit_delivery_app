import 'package:flutter/material.dart';
import 'package:gofixit_demo_one/model/FixerModel.dart';
import 'package:gofixit_demo_one/model/UserModel.dart';
import 'package:gofixit_demo_one/resusable_components/historyTiles.dart';
import 'package:gofixit_demo_one/screens/home/addCard.dart';
import 'package:gofixit_demo_one/screens/home/history.dart';
import 'package:gofixit_demo_one/screens/home/settings.dart';
import 'package:gofixit_demo_one/screens/home/testPage.dart';
import 'package:gofixit_demo_one/screens/wrapper.dart';
import 'package:gofixit_demo_one/services/auth.dart';
import 'package:gofixit_demo_one/services/database.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gofixit_demo_one/resusable_components/menuCards.dart';
// import 'dart:async';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final userAuth = Provider.of<UserModel>(context);
    return userAuth == null
        ? Container(
            color: Colors.brown[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SpinKitChasingDots(
                    color: Colors.brown[400],
                    size: 50.0,
                  ),
                ),
                FlatButton(
                  color: Colors.black,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  child: Text("Goto login page"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Wrapper()));
                  },
                )
              ],
            ),
          )
        : StreamProvider<List<FixerModel>>.value(
            value: DatabaseService().userDetails,
            child: Scaffold(
              appBar: AppBar(
                // leading:IconButton(
                //   icon: Icon(Icons.more_vert,color:Colors.orange,),
                //   onPressed: (){
                //     Scaffold.of(context).openDrawer();
                //   },
                // ),
                actions: [
                  IconButton(
                      icon: Icon(
                        Icons.credit_card,
                        color: Colors.white,
                      ),
                      onPressed: null)
                ],
                backgroundColor: Color(0xFF263238),
                title: Text("gofixit"),
                elevation: 0.0,
              ),
              drawer: CustomDrawer(),
              body: _loading
                  ? Loading()
                  : Container(
                      padding: EdgeInsets.all(16.0),
                      child: ListView(
                        children: [
                          // FixItList(),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  // color:Colors.redAccent,
                                  height: 80.0,
                                  child: Stack(
                                    children: [
                                      Text("Hi,",
                                          style: TextStyle(
                                              fontSize: 30.0, wordSpacing: 10)),
                                      Positioned(
                                      top: 30.0,
                                      child: Text(
                                        "Welcome",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30.0),
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          RequestDeliveryCards(
                            icon: Icons.access_alarm,
                            cardTitle: "Request Delivery",
                          ),
                          SizedBox(height: 10.0),
                          ServiceRequestCard(),
                          SizedBox(height: 50.0),
                        ],
                      ),
                    ),
            ),
          );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SpinKitChasingDots(
              color: Colors.brown[400],
              size: 50.0,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String _currentUserame;
  String _currentPhone;
  int _currentStrength;
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final user = Provider.of<UserModel>(context);
    return StreamBuilder<UserDataModel>(
        stream: DatabaseService(uid: user.userId).currentUserData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserDataModel currentUser = snapshot.data;
            return Drawer(
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: IconButton(
                                icon: Icon(Icons.person), onPressed: null),
                          ),
                          SizedBox(width: 10.0),
                          Text(currentUser.username,
                              style: TextStyle(
                                fontSize: 20.0,
                              )),
                        ]),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.credit_card),
                    title: Text('Add cards'),
                    onTap: () {
                      // Update the state of the app.
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>AddCard() ));
                      // ...
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.history),
                    title: Text('Histroy'),
                    onTap: () {
                      // Update the state of the app.
                      // Navigator.push(context,MaterialPageRoute(builder: (context)=>HistoryList() ));
                      // Navigator.push(context,MaterialPageRoute(builder: (context)=>TestPage() ));

                      // ...
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Setttings'),
                    onTap: () {
                      // Update the state of the app.
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>SettingsScreen() ));
                      // ...
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.power_settings_new),
                    title: Text('Log out'),
                    onTap: () async {
                      return await _auth.signOut();
                      // ...
                    },
                  ),
                ],
              ),
            );
          }
        });
  }
}

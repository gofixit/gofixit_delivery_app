import 'package:flutter/material.dart';
import 'package:gofixit_demo_one/model/UserModel.dart';
import 'package:gofixit_demo_one/services/auth.dart';
import 'package:gofixit_demo_one/splashScreen.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel>.value(
      value:AuthService().user,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFFf3f4f4),
          fontFamily: 'Baloo Paaji 2',
        ),
        home:SplashScreen(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gofixit_demo_one/model/UserModel.dart';
import 'package:gofixit_demo_one/screens/authenticate/authenticate.dart';
import 'package:gofixit_demo_one/screens/home/home.dart';
import 'package:gofixit_demo_one/screens/home/mapLine.dart';
import 'package:gofixit_demo_one/screens/home/routeLoader.dart';
import 'package:gofixit_demo_one/screens/home/seeAllServices.dart';
import 'package:gofixit_demo_one/screens/home/testPage.dart';
import 'package:gofixit_demo_one/screens/home/uploadPhoto.dart';
import 'package:gofixit_demo_one/screens/home/map.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    // print(user.userId);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
      // return MapSearch();
      // return MapScreen();
      // return RouteLoader();
      // return TestPage();
      // return AllServices();
      // return ImageUploader();
    }
  }
}

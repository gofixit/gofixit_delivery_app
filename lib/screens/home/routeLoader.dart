import 'package:flutter/material.dart';
import 'package:gofixit_demo_one/model/FixerModel.dart';
import 'package:gofixit_demo_one/model/UserModel.dart';
import 'package:gofixit_demo_one/resusable_components/listing.dart';
import 'package:gofixit_demo_one/screens/wrapper.dart';
import 'package:gofixit_demo_one/services/auth.dart';
import 'package:gofixit_demo_one/services/database.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RouteLoader extends StatefulWidget {
  @override
  _RouteLoaderState createState() => _RouteLoaderState();
}

class _RouteLoaderState extends State<RouteLoader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        child:RouteLoad(),
      )
    );
  }
}

class RouteLoad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return StreamBuilder<UserDataModel>(
        stream: DatabaseService(uid: user.userId).currentUserData,
        builder: (context, snapshot) {
            UserDataModel currentUser = snapshot.data;
            return Container(
              child:Column(
                children: [
                  Text(currentUser.username),
                  Text(currentUser.phone),
                  Text(currentUser.gender),
                  Center(
                    child: SpinKitChasingDots(
                      color: Colors.brown[400],
                      size: 50.0,
                    ),
                  ),
                ],
              )
            );
        });
  }
}

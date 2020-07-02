import 'package:flutter/material.dart';
import 'package:gofixit_demo_one/model/FixerModel.dart';
import 'package:gofixit_demo_one/resusable_components/fixer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FixItList extends StatefulWidget {
  @override
  _FixItListState createState() => _FixItListState();
}

class _FixItListState extends State<FixItList> {
  @override
  Widget build(BuildContext context) {
    final usersDetail = Provider.of<List<FixerModel>>(context);
    // usersDetail.forEach((detail) {
    // print(detail.username);
    // print(detail.phone);
    // print(detail.gender);
    // print(detail.strength);
    // print('New user');

    // });
    // print(usersDetail.length);
    return ListView.builder(
        itemCount: usersDetail.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.orange[usersDetail[index].strength],
              ),
              title: Text(usersDetail[index].username),
              subtitle: Text('Phone:${usersDetail[index].phone}'),
            ),
          );
        });
  }
}

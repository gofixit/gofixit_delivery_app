import 'package:flutter/material.dart';
import 'package:gofixit_demo_one/model/FixerModel.dart';

class FixerTile extends StatelessWidget {
  final FixerModel fixer;
  FixerTile({this.fixer});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 6.0),
        color: Colors.red, 
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[fixer.strength],
          ),
          title: Text(fixer.username),
          // subtitle: Text('Phone:${fixer.phone}'),
        )
      ),
    );
  }
}

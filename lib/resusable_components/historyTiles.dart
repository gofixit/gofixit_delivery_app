import 'package:flutter/material.dart';
import 'package:gofixit_demo_one/model/ServiceOrderModel.dart';
import 'package:provider/provider.dart';

class HistoryList extends StatefulWidget {
  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  @override
  Widget build(BuildContext context) {
    final historyDetails = Provider.of<List<ServiceOrderModel>>(context);

    return ListView.builder(
      itemCount: historyDetails.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.brown[100],
            ),
            title: Text(historyDetails[index].serviceOrdered)
            // subtitle: Text('Phone:${usersDetail[index].phone}'),
          ),
        );
      },
    );
  }
}

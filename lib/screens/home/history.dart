import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gofixit_demo_one/model/ServiceOrderModel.dart';
import 'package:gofixit_demo_one/resusable_components/historyTiles.dart';
import 'package:gofixit_demo_one/resusable_components/listing.dart';
import 'package:provider/provider.dart';
import 'package:gofixit_demo_one/model/UserModel.dart';
import 'package:gofixit_demo_one/services/database.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.keyboard_backspace, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text("history", style: TextStyle(fontSize:25.0,color: Colors.black)),
          elevation: 0.0,
          // backgroundColor:Color(0xFF263238),
          backgroundColor: Color(0xFFf3f4f4),
        ),
        body:SafeArea(
          child:Container(
            child:HistoryList(),
          ),
      )
    );
  }
}
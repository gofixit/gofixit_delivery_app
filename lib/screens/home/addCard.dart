import 'package:flutter/material.dart';

class AddCard extends StatefulWidget {
  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Cards", style: TextStyle(fontSize:25.0,color: Colors.black)),
        elevation: 0.0,
        // backgroundColor:Color(0xFF263238),
        backgroundColor: Color(0xFFf3f4f4),
      ),
      body:SafeArea(
        child:Container(
          child:ListView(
            children: [
             
            ],
          )
        ),
      ),
    );
  }
}
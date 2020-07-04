import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
        title: Text("Cards",
            style: TextStyle(fontSize: 25.0, color: Colors.black)),
        elevation: 0.0,
        // backgroundColor:Color(0xFF263238),
        backgroundColor: Color(0xFFf3f4f4),
      ),
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Container(
                  // color:Colors.red,
                  height: 200.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      PaymentCard(),
                      SizedBox(
                        width: 20.0,
                      ),
                      PaymentCard(),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  // color:Colors.red,
                  height: 100.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      AddCardBtn(),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class PaymentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: GestureDetector(
            onTap: null,
            child: Container(
              // padding:EdgeInsets.symmetric(horizontal:16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("**** **** **** 1234",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 29.0,
                            color: Colors.black)),
                  ),
                ],
              ),
              height: 100.0,
              decoration: BoxDecoration(
                color: Color(0xFFCCCCCC),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AddCardBtn extends StatelessWidget {

  _launchURL() async {
    const url = "https://api.paystack.co/transaction/initialize";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: GestureDetector(
            onTap: () {
              // _launchURL();
            },
            child: Container(
              // padding:EdgeInsets.symmetric(horizontal:16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Add Card",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 29.0,
                            color: Colors.white)),
                  ),
                ],
              ),
              height: 70.0,
              decoration: BoxDecoration(
                color: Color(0xFF263238),
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

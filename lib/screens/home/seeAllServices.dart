import 'package:flutter/material.dart';
import 'package:gofixit_demo_one/screens/home/requestService.dart';

class AllServices extends StatelessWidget {
  List<String> titles = [
    'Home Cleaning and Laundry',
    'Washing Machine Repairs',
    'Carpentry',
    'AC Repairs',
    'Electricals',
    'Washing Machine Repairs'
  ];
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("All Services", style: TextStyle(fontSize:25.0,color: Colors.black)),
        elevation: 0.0,
        // backgroundColor:Color(0xFF263238),
        backgroundColor: Color(0xFFf3f4f4),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: [
              // Align(
              //     alignment: Alignment.topLeft,
              //     child: Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Text(
              //         "All Services",
              //         style: TextStyle(fontSize: 50.0),
              //       ),
              //     )),
              Service(title: titles[0],),
              Service(title: titles[1],),
              Service(title: titles[2],),
              Service(title: titles[3],),
              Service(title: titles[4],),
              Service(title: titles[5],),
            ],
          ),
        ),
      ),
    );
  }
}

class Service extends StatelessWidget {
  final String title;
 
  Service({this.title});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Card(
          child: ListTile(
            leading: Icon(Icons.build, color: Colors.orange, size: 72.0),
            title: Text(title),
            subtitle:
                Text('A sufficiently long subtitle warrants three lines.'),
            trailing: Icon(Icons.verified_user, color: Colors.green),
            isThreeLine: true,
          ),
        ),
        onTap: () {
          print(title);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RequestService(
                        service: title,
                      )));
        });
  }
}

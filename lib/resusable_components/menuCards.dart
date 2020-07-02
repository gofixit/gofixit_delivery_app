import 'package:flutter/material.dart';
import 'package:gofixit_demo_one/screens/home/map.dart';
import 'package:gofixit_demo_one/screens/home/seeAllServices.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RequestDeliveryCards extends StatelessWidget {
  RequestDeliveryCards({this.icon,this.cardTitle});
  
  final IconData icon;
  final String cardTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap:(){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>MapScreen()));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal:10.0),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                    icon: Icon(Icons.directions_bike,size:40.0,color:Colors.white),
                    onPressed: () {  }
                  ),
                  SizedBox(height:40.0),
                  Text("Request Delivery",style:TextStyle(fontWeight:FontWeight.bold,fontSize:35.0,color:Colors.white54)),
                  SizedBox(height:40.0),
                  
                ],
              ),
              height:200.0,
             decoration:BoxDecoration(
                // color:Colors.redAccent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)
                ),
                boxShadow:[
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                gradient:LinearGradient(
                  colors: [
                    // const Color(0xFF3366FF),
                    Color(0xFF263238),
                    Colors.redAccent,
                    // const Color(0xFF00CCFF),
                    // Colors.blueAccent
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ServiceRequestCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap:()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>AllServices())),
            child: Container(
              padding:EdgeInsets.symmetric(horizontal:10.0),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   IconButton(
                    // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                    icon: Icon(Icons.build,size:40.0,color:Colors.white),
                    onPressed: () {  Navigator.pushNamed(context, '/requestDelivery'); }
                  ),
                  SizedBox(height:40.0),
                  Text("Request a Service",style:TextStyle(fontWeight:FontWeight.bold,fontSize:35.0,color:Colors.white54)),
                  SizedBox(height:40.0),
                  
                ],
              ),
              height:200.0,
              decoration:BoxDecoration(
                color:Colors.redAccent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)
                ),
                boxShadow:[
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                gradient:LinearGradient(
                  colors: [
                    // const Color(0xFF3366FF),
                    Color(0xFF263238),
                    const Color(0xFF00CCFF),
                    // Colors.orangeAccent,
                    // Colors.grey,
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
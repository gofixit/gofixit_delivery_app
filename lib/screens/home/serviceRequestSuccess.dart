import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gofixit_demo_one/screens/home/home.dart';

class ServiceReqSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String succ = "Service request has been submitted,";
    String succ2 = "We will estimate pricing";
    String succ3 = "get across to you with an estimate";
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Icon(Icons.check_circle_outline,
                      color: Colors.green, size: 80.0)),

              TextWrap(succ),
              TextWrap(succ2),
              TextWrap("and"),
              TextWrap(succ3),
              SizedBox(height:20.0,),
              GestureDetector(
                onTap: () async {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
                },
                child: Container(
                  width:200.0,
                  child: Center(
                      child: Text(
                    'Go back home',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  )),
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(5.0),
                   
                    gradient: LinearGradient(
                        colors: [
                          // const Color(0xFF3366FF),
                          Colors.black,
                          Colors.grey
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                ),
              )
              // SpinKitChasingDots(),
            ],
          ),
        ),
      ),
    );
  }

  Widget TextWrap(String txt) {
    return Container(
      // color: Colors.red,
      width: 300.0,
      child: Center(
        child: Text(
          txt,
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}

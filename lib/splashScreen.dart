import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gofixit_demo_one/howItWorks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState()  {
    super.initState();
    Timer(Duration(seconds:6),()=>{
      // print("Ajaa Ajaa")
      Navigator.push(context,MaterialPageRoute(builder: (context)=>HowItWorks() ))
    });
  }

  final spinkit = SpinKitFadingCircle(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: index.isEven ? Colors.grey : Colors.orange,
        ),
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child:Row(
          children:[
            Expanded(
            child: Container(
              color: Colors.black,
              child:Column(
                children:[
                  Expanded(
                    child: Container(
                      child:SvgPicture.asset(
                        'assets/svg_logos/logo-white.svg',
                        semanticsLabel: 'Acme Logo',
                        width:200.0,
                        height: 200.0,
                      ),
                    ),
                  ),
                  Center(
                    child:spinkit
                  ),
                  SizedBox(
                    height:100.0,
                  ),
                ]
              ),
            ),
            ),
          ]
        )
      ),
    );
  }
}
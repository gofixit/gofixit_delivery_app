import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gofixit_demo_one/screens/wrapper.dart';

final List<String> imgList = [
  'assets/work_svg/undraw_on_the_way_ldaq.svg',
  'assets/work_svg/undraw_order_delivered_p6ba.svg',
  'assets/work_svg/undraw_takeout_boxes_ap54.svg'
];

class HowItWorks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
        onWillPop: ()=>Future.value(false),
        child: Scaffold(
        backgroundColor:Color(0xFF3F4F4),
        body:SafeArea(
          child: Row(
            children: [
              Expanded(
                child:Container(
                  color: Color(0xFFf3f4f4),
                  // color:Colors.red,
                  
                    child: Column(
                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child:SvgPicture.asset(
                            'assets/svg_logos/logo-black.svg',
                            width:10.0,
                            height: 120.0,
                          ),
                        ),
                        Expanded(
                          child:Container(
                            // color:Color(0xFF8CC63E),
                            child:ListView(
                              scrollDirection: Axis.horizontal,
                              children:[
                                SizedBox(width:30.0),
                                Container(
                                  width:350.0,
                                  // height:200.0,
                                  // color:Colors.red,
                                  child:SvgPicture.asset(
                                    imgList[0],
                                    width:10.0,
                                    height: 120.0,
                                  ),
                                ),
                                SizedBox(width:80.0),
                                Container(
                                  width:300.0,
                                  // height:200.0,
                                  // color:Colors.red,
                                  child:SvgPicture.asset(
                                    imgList[1],
                                    width:10.0,
                                    height: 120.0,
                                  ),
                                ),
                                SizedBox(width:80.0),
                                Container(
                                  width:300.0,
                                  // height:200.0,
                                  // color:Colors.red,
                                  child:SvgPicture.asset(
                                    imgList[2],
                                    width:10.0,
                                    height: 120.0,
                                  ),
                                ),
                                SizedBox(width:40.0),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width:10.0,
                              height:10.0,
                              decoration:BoxDecoration(
                                color:Color(0xFFF6903D),
                                borderRadius:BorderRadius.circular(50.0),
                              ),
                            ),
                            SizedBox(width:10.0),
                            Container(
                              width:10.0,
                              height:10.0,
                              decoration:BoxDecoration(
                                color:Color(0xFFF6903D),
                                borderRadius:BorderRadius.circular(50.0),
                              ),
                            ),
                            SizedBox(width:10.0),
                            Container(
                              width:10.0,
                              height:10.0,
                              decoration:BoxDecoration(
                                color:Color(0xFFF6903D),
                                borderRadius:BorderRadius.circular(50.0),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height:30.0),
                        Container(
                          height:50.0,
                          width: 300.0,
                          decoration:BoxDecoration(
                            color: Color(0xFFF6903D),
                            borderRadius:BorderRadius.circular(10.0),
                          ),
                          child:FlatButton(
                            colorBrightness:Brightness.light,
                            focusColor: Color(0xFFF6903D),
                            child:Text("Continue to app",style:TextStyle(color:Color(0xFFF3F4F4),fontSize:18.0),),
                            onPressed:(){
                               Navigator.push(context,MaterialPageRoute(builder:(context)=>Wrapper()));
                            }
                          ),
                        ),
                        SizedBox(height:30.0),
                      ],
                    ),
                
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
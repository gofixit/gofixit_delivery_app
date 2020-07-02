import 'package:flutter/material.dart';
import 'package:gofixit_demo_one/screens/authenticate/register.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gofixit_demo_one/screens/home/home.dart';
// import 'package:gofixit/resusable_components/inputField.dart';
import 'package:gofixit_demo_one/services/auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:gofixit_demo_one/model/UserModel.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String email='';
  String password='';
  String error='';

  final AuthService _auth= AuthService();
  final _formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final userAuth=Provider.of<UserModel>(context);

    return userAuth!=null?Container(
      color: Colors.brown[100],
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child:SpinKitChasingDots(
              color: Colors.brown[400],
              size:50.0,
            ),
          ),
          
        ],
      ),
      ):Scaffold(
      body:SafeArea(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding:EdgeInsets.symmetric(horizontal:30.0),
                  child: ListView(
                    children:[
                      SizedBox(height:80.0),
                    Container(
                      child:SvgPicture.asset(
                        'assets/svg_logos/logo-black.svg',
                        width:10.0,
                        height: 120.0,
                      ),
                    ),
                    SizedBox(height:20.0,),
                    Center(
                      child:Text(error,style:TextStyle(color:Colors.red)),
                    ),
                    TextFormField(
                      keyboardType:TextInputType.emailAddress,
                      decoration:  InputDecoration(
                        hintText: "Email address",
                      ),
                      validator: (val)=>val.isEmpty ? 'Enter a email ':null,
                      onChanged:(val){
                        setState(()=>email=val);
                      },
                    ),
                      SizedBox(height:25.0,),
                      TextFormField(
                        obscureText: true,
                        decoration:  InputDecoration(
                          hintText: "Password",
                        ),
                        validator: (val)=>val.length<6 ? 'Enter a password 6+ char long':null,
                        onChanged:(val){
                          setState(()=>password=val);
                        },
                      ),
                      SizedBox(height:30.0,),
                      Container(
                        height:50.0,
                        width: 330.0,
                        decoration:BoxDecoration(
                          color: Color(0xFFF6903D),
                          borderRadius:BorderRadius.circular(10.0),
                        ),
                        child:FlatButton(
                          colorBrightness:Brightness.light,
                          focusColor: Color(0xFFF6903D),
                          child:Text("Sign in",style:TextStyle(color:Color(0xFFF3F4F4),fontSize:18.0),),
                          onPressed:() async{
                            if(_formkey.currentState.validate()){
                              print(email);
                              print(password);
                              dynamic result= await _auth.signInwithEmailAndPassword(email, password);
                              if(result==null){
                                setState(()=>error='invalid email or password');
                              }
                              // if result is not null our provide stream with auto change our view to the home page
                            }
                           
                          }
                        ),
                      ),
                      SizedBox(height:10.0),
                      // Container(
                      //   height:50.0,
                      //   width: 330.0,
                      //   decoration:BoxDecoration(
                      //     color: Color(0xFF000000),
                      //     borderRadius:BorderRadius.circular(10.0),
                      //   ),
                      //   child:FlatButton(
                      //     colorBrightness:Brightness.light,
                      //     focusColor: Color(0xFF000000),
                      //     child:Text("Login as anon",style:TextStyle(color:Color(0xFFF3F4F4),fontSize:18.0),),
                      //     onPressed:() async{
                      //       try {
                      //         dynamic result=AuthService().signInAnon();
                      //         if(result==null){
                      //           print('error logging in');
                      //         }else{
                      //           print('user logged in');
                      //           // print(result.uid);
                      //           Navigator.push(context,MaterialPageRoute(builder: (context)=>Home()));
                      //         }
                      //       } catch (e) {
                      //         print(e.toString());
                      //       }
                      //     }
                      //   ),
                      // ),
                    ]
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap:(){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>Register()));
                    },
                    child: Text("I dont have an account",style:TextStyle(color:Color(0xFF8CC63E),fontSize:20.0)),
                  ),
                ],
              ),
              SizedBox(height:50.0),
            ],
          ),
        ),
                   
      ),
    );
  }
}
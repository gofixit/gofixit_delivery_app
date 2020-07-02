import 'package:flutter/material.dart';


class InputField extends StatelessWidget {

    InputField({this.placeholderText,this.inputTyp,this.hashWords,this.onchanged});

    final String placeholderText;
    final inputTyp;
    final bool hashWords;
    Function onchanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onChanged:onchanged,
        obscureText: hashWords,
        keyboardType: inputTyp,
        validator:(value){
          if(hashWords){
            value.length<6 ? 'Enter a password 6+ char long':null;
          }else{
            value.isEmpty ? 'Enter email address':null;
          }
          
        }, 
        decoration:  InputDecoration(
          // errorText: hashWords?"Enter email address":"Enter a password at least 6+ char long",
          filled: true,
          fillColor: Color(0xFFf3f4f4),
          focusColor: Colors.red,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              style: BorderStyle.solid
            ),
          ),
          hintText: placeholderText,
          hintStyle: TextStyle(color:Colors.black),
        ),

    );
  }
}
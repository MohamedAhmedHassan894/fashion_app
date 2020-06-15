import 'package:flutter/material.dart';
Color deepOrange = Colors.deepOrange;
Color black = Colors.black;
Color grey =Colors.grey;
Color white = Colors.white;
Color red = Colors.red;

void changeScreen(BuildContext context , Widget widget){
  Navigator.push(context, MaterialPageRoute(builder: (context){return widget ;}));
}


void changeScreenReplacement(BuildContext context , Widget widget){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){return widget ;}));
}


import 'package:flutter/material.dart';

import 'firstscreen.dart';
import 'quizscreen.dart';

void main(){
  runApp(MyApp());

}
class MyApp extends StatelessWidget{
  @override
  Widget build (BuildContext context){
    return MaterialApp(
      title: 'Darkrai',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home:FirstScreen(),
    );
  }
}
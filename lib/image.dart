import 'dart:io';

import 'package:flutter/material.dart';
class Imagepage extends StatelessWidget {
  int im;
  List<String>img;
  Imagepage(this.im,this.img);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Hero(
          tag:im,
          child: ListWheelScrollView(
            itemExtent: 500.0,
            children: img.map((ima)=>Stack(
                  children: <Widget>[
                     Container(
height: MediaQuery.of(context).size.height,
width: MediaQuery.of(context).size.width,
        child: Image.file(File(ima),fit:BoxFit.fill,),
              ),
                  ],
            )).toList()
          ),
        ),
        )
      
    );
  }
}
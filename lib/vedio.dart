import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:storage_path/storage_path.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'vediopager.dart';
import 'package:video_player/video_player.dart';
class Vedio extends StatefulWidget {
  @override
  _VedioState createState() => _VedioState();
}

class _VedioState extends State<Vedio> {
  VideoPlayerController videoPlayerController;
  List<String> vediopath=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
getvediopath();

 
  }
  getvediopath()async
  {
    var v=StoragePath.videoPath;
    print(v);
    return v;

  }
  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder(

      future: getvediopath(),
      builder: (context,shapshot){
        List mydata=json.decode(shapshot.data);
        print(mydata);
         for (int i = 0; i < mydata.length; i++) {
                 for (int j = 0; j < mydata[i]['files'].length; j++) {
                   vediopath.add(mydata[i]['files'][j]['path']);
                 }
               }
               print(mydata);
        return Container();
      },
    );
  }
}
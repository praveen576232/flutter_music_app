import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:storage_path/storage_path.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:vediomusic/image.dart';
class VedioPage extends StatefulWidget {
  @override
  _VedioPlayerState createState() => _VedioPlayerState();
}

class _VedioPlayerState extends State<VedioPage> {
List<String> images=[];
File a;
 var data;
  @override
  void initState() {
   
    // TODO: implement initState
    super.initState();
    getvedio();
  }
  Future getvedio()async
  {
  data =await StoragePath.imagesPath;
   
    
    return data;
  }
 Future showimg(BuildContext context,int i)
  {
   return  showDialog(
                       context: context,
                       builder:(context)
                       {
                         return  AlertDialog(
                         content: Container(child: Image.file(File(images[i])),),
                       );
                       }
                     );
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
             future: getvedio(),
             builder: (context,shapshot)
             {
               List mydata=json.decode(shapshot.data);
               
               a=File(mydata[0]['files'][1000]);
               for (int i = 0; i < mydata.length; i++) {
                 for (int j = 0; j < mydata[i]['files'].length; j++) {
                   images.add(mydata[i]['files'][j]);
                 }
               }
           print("leth is ${images.length}");
               return StaggeredGridView.countBuilder(
               crossAxisCount: 4,
               itemCount: images.length,
               itemBuilder: (context,i)
               {
                 return Material(
                   borderRadius: BorderRadius.all(Radius.circular(5.0)),
                   child: GestureDetector(
                     child: Hero(
                       tag: images[i],
                       child: Image.file(File(images[i]),fit: BoxFit.fill,),
                       
                     ),
                     onTap: ()
                     {
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>Imagepage(i,images)));
                     },
                  
                   
                 
                    onLongPressStart: (LongPressStartDetails d)
                    {
                      print(d.localPosition.dx);
                      showimg(context,i);
                       
                    },
                   onLongPressEnd: (LongPressEndDetails e)
                   {
                     print("details ${e.localPosition.dx}");
                    
                     
                   },
                   ),
                   
                 );
               },
               staggeredTileBuilder: (i)=>StaggeredTile.count(2, i.isEven?2:3),
               mainAxisSpacing: 8.0,
               crossAxisSpacing: 8.0,
               );
                 
             },
           );
      
  }
}
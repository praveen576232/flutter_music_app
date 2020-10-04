import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:sensors/sensors.dart';
import 'package:storage_path/storage_path.dart';

class Getmusic
{
 
  String name;
  String url;
 String album;
 String artist;
 int duration;

Getmusic({@required this.name,@required this.album,@required this.url,@required this.artist,@required this.duration});
 
static Future<String> display() async
{
  
  String c= "praveee";
  return Future.value("$c");
}
}




class songs
{
    static    List<String> name=[];
static  List<String> url=[];
 static List<String>album=[];
static List<String> artist=[];
static List<int>duration=[];

 
static Future<String> getaudio()async
  {
   
    var  s=await StoragePath.audioPath;
    print(s);
    return s;
   
    
  }

  
  static Future  getsongs() async
{

 
    var mymusic=await getaudio();
   
      List mydata=json.decode(mymusic.toString());
              
               
             for (int i = 0; i < mydata.length; i++) {
               
               for (int j = 0; j < mydata[i]['files'].length; j++) {
                 if(mydata[i]['files'][j]["displayName"].toString()!=null &&mydata[i]['files'][j]["displayName"].toString().endsWith('.mp3'))
                 {
                    name.add(mydata[i]['files'][j]["displayName"].toString())  ; 
                    url.add(mydata[i]['files'][j]["path"].toString());
                    album.add(mydata[i]['files'][j]["album"].toString());
                    artist.add(mydata[i]['files'][j]["artist"].toString());
                    duration.add(int.parse(mydata[i]['files'][j]["duration"]));

                  
                       
                 }
                  
                  
               }
              
             }
           
            print(name.length);
    
}
static songname()
{
  Set n=name.toSet();
  print(n.length);
  return Future.value(n);
}
static songduration()
{
  
  Set n= duration.toSet();
  print(n.length);
  return Future.value(duration);
}
static songurl()
{
  Set n=url.toSet();
   print(n.length);
  return Future.value(n);
}
static songartist()
{
  Set n=artist.toSet();
   print(n.length);
  return Future.value(artist);
}
static songalbum()
{
  Set n=album.toSet();
   print(n.length);
  return Future.value(n);
}


}
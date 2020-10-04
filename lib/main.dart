import 'package:flutter/material.dart';

import 'package:vediomusic/addsong.dart';
import 'package:vediomusic/lastadd.dart';
import 'package:vediomusic/musicfile.dart';
import 'package:vediomusic/player.dart';
import 'package:vediomusic/search.dart';
import 'package:vediomusic/vedio.dart';

import 'package:vediomusic/vediopager.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:vediomusic/getmusic.dart';



void main() {
  runApp(HomePage());
}
class HomePage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(home: FirstApp(),);
  }
  
}
class FirstApp extends StatefulWidget
{
  @override
  _FirstAppState createState() => _FirstAppState();
}

class _FirstAppState extends State<FirstApp> with SingleTickerProviderStateMixin{
TabController _tabController;
bool senser=false;
bool darkmode=false;
 List<String> name=[];
  List<String> url=[];
 List<String>album=[];
 List<String> artist=[];
 List<int>duration=[];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController=TabController(length: 3,vsync: this);
    musicloader();
  }
  Future musicloader() async
{
  await songs.getsongs();
  var s=await songs.songname();
  var ab=await songs.songalbum();
  var art=await songs.songartist();
  var dur=await songs.songduration();
  var ur=await songs.songurl();
  
  setState(() {
    name=List.from(s);
    artist=List.from(art);
    album=List.from(ab);
    url=List.from(ur);
    duration=List.from(dur);
  });

   


}
  @override
  void dispose() {
    _tabController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: Drawer(
               
               child: ListView(
                 children: <Widget>[
                  
                   ListTile(
                     title: Text("last added"),
                     trailing: Icon(Icons.music_note),
                     onTap: (){
                     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LastAdd()));
                     },
                   ),
                   ListTile(
                     title: Text("shake to change song"),
                     trailing:  Switch(
                       activeColor: Colors.green,
                        value: senser,
                        onChanged: (bool v){
                          setState(() {
                           senser=!senser;
                           songadd().sensermode(senser);
                          });
                        },
                     ),
                   )
                 ],
               ),
             ),
        appBar: AppBar(
           title:Text("music player",style:
              TextStyle(color: darkmode?Colors.white70: Colors.black87,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),),
             
             actions: <Widget>[
               IconButton(
                 icon: Icon(Icons.lightbulb_outline,color:darkmode?Colors.white70: Colors.black87,),
                 color: darkmode?Colors.white70: Colors.black87,
                 onPressed: (){
                   setState(() {
                    darkmode=!darkmode;
                    songadd().darkthem(darkmode); 
                   });
                 },
               ),
                 IconButton(
                   icon: Icon(Icons.search,color:darkmode?Colors.white70: Colors.black87),
                   color:darkmode?Colors.white70: Colors.black87 ,
                   onPressed: (){
                     print("object");
                       showSearch(context: context, delegate: search(name,darkmode,senser));
                   },
                 )
             ],
             backgroundColor: darkmode?Colors.white70: Colors.orange,
          bottom: TabBar(
            controller: _tabController,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.queue_music),
              ),
              Tab(
                icon: Icon(Icons.image),
              ),
               Tab(
                icon: Icon(Icons.video_library),
              )
            ],
          ),
        ),
        body: TabBarView(
          controller:_tabController,
          children: <Widget>[
            Mymusic(darkmode: darkmode,senser: senser,name: name,album: album,artist: artist,duration: duration,url: url,),
            VedioPage(),
            Vedio()
            ],
        ),
      ),
    );
  }
}



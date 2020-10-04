import 'package:draggable_scrollbar/draggable_scrollbar.dart';

import 'package:flutter/material.dart';
import 'package:vediomusic/addsong.dart';
import 'package:vediomusic/lastadd.dart';
import 'package:vediomusic/player.dart';
import 'package:vediomusic/search.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
class Mymusic extends StatefulWidget {
 List<String> name=[];
  List<String> url=[];
 List<String>album=[];
 List<String> artist=[];
 List<int>duration=[];

 bool darkmode=false;
bool senser=false;
Mymusic({Key key,@required this.darkmode,@required this.senser,@required this.name,@required this.url,@required this.album,@required this.duration,@required this.artist});
  @override
  _MymusicState createState() => _MymusicState();
}

class _MymusicState extends State<Mymusic>
    with SingleTickerProviderStateMixin {
  
var s;

String playstate=null;
bool _isactive;
bool _islistening;
String speech;

int currentplayindex=1;
bool playsong=false;
int songindex;
bool pusesong=false;
bool songstatus=false;
double scrolbar=0.0;
Size sizeofappbar;
double listscrol;
List<String>choice=<String>["next song","save","recent"];
GlobalKey appbarsize=GlobalKey();
ScrollController _scrollcontrol=ScrollController();
  @override
  void initState() {
    super.initState();

   checksongstatus();
 }
 
 Future checksongstatus()async
 {
  
 }

Widget bulidseconpage(BuildContext context)
{
  
  
//  return Player(playoonot: true,index: currentplayindex,nextsong: true,album: widget.album,artist: widget.artist,duration: widget.duration,name: widget.name,url: widget.url,);
   
     
   
}

  @override
  Widget build(BuildContext context) {
    print("ame is ${widget.name}");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       theme:widget.darkmode? ThemeData.dark():ThemeData.light(),
           home: SlidingUpPanel(
            minHeight: 65.0,
            maxHeight: MediaQuery.of(context).size.height,
             panel:bulidseconpage(context),
             
             backdropEnabled: true,
             collapsed: Material(child: Container(
               child:ListTile(
                 title:widget.name.isNotEmpty? Text(playsong?
                 widget.name[currentplayindex].length>20?
                 widget.name[currentplayindex].substring(0,20):widget.name[currentplayindex]:
                  widget.name[0].substring(0,widget.name[0].length>20?20:widget.name[0].length)
                 ): Text("no song "),
                 leading: Container(
                   height: 50.0,
                   width: 50.0,
                   color: Colors.green,
                 ),
                trailing:  IconButton(
                      iconSize: 55.0,
                   icon:songstatus? Icon(Icons.pause):Icon(Icons.play_arrow),
                   onPressed: (){
                    
                        setState(() {
                         pusesong=!pusesong; 
                        });
                        
                        
                   },
                   
                   ),

               )
             ),
             ),
             body: Scaffold(
            
             body: widget.name.isNotEmpty?  DraggableScrollbar.semicircle(
               backgroundColor:  widget.darkmode?Colors.white70: Colors.orange,
               controller: _scrollcontrol,
              
                            child:
                 
                    ListView.builder(
                     controller: _scrollcontrol,
                   itemCount:widget.name.length,
                   addRepaintBoundaries: true,
                   itemBuilder: (context,idex){
                      return Container(
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(style: BorderStyle.solid,color: Colors.black12.withOpacity(0.3)))
                        ),
                                          child: ListTile(
                          
                          leading: Container(

                            height: 50.0,
                            width: 50.0,
     
                          ),
                          title:widget.name[idex].length>20?Text("${widget.name[idex].substring(0,20)}.."):
                          Text(widget.name[idex]),
                          subtitle: widget.artist[idex].length>15?Text("${widget.artist[idex].substring(0,15)}..${((widget.duration[idex]/1000)/60).toInt()}:${((widget.duration[idex]/1000)%60).toInt()}"):
                          Text("${widget.artist[idex]} ${((widget.duration[idex]/1000)/60).toInt()}:${((widget.duration[idex]/1000)%60).toInt()}"),
                          trailing:  PopupMenuButton<String>(
                          color: Colors.orange,
                          onSelected: (String s){
                             if(s=="save")
                             {
                                songadd().sogadd(widget.name[idex],widget.album[idex],widget.url[idex],widget.artist[idex],widget.duration[idex]);
                               
                             }
                          },
                         
                                                   itemBuilder: (context){
                             return choice.map((String c){
                               return PopupMenuItem<String>(
                                 value: c,
                                 child: Container(
                                   
                                   child: Text(c),)
                               );
                             }).toList();
                           },
                            ),
                          onTap: (){
                         
                          
                           setState(() {
                            currentplayindex=idex; 
                            playsong=true;
                            
                           });
                          },
                          
                        
                        ),
                      );
                   },
                 )
             ):Container(child: Center(child:CircularProgressIndicator()))
            
              
             
           ),
             
          
              
           )
    );
  }
}
























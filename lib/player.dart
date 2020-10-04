import 'package:flutter/material.dart';
import 'package:vediomusic/addsong.dart';
import 'package:seekbar/seekbar.dart';
import 'package:indexed_list_view/indexed_list_view.dart';
import 'package:sensors/sensors.dart';
import 'package:vediomusic/getmusic.dart';
import 'package:audioplayer/audioplayer.dart';
void main()=>runApp(Player());


class Player extends StatefulWidget
     {
int index;
bool playoonot=false;
bool nextsong=false;
bool puse=false;
 List<String> name=[];
  List<String> url=[];
 List<String>album=[];
 List<String> artist=[];
 List<int>duration=[];
Player({Key key,@required this.index,@required this.playoonot,@required this.nextsong,@required this.name,@required this.url,@required this.album,@required this.duration,@required this.artist}):super(key:key);

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
 
AudioPlayerState  playerstate;
  bool darkmode=false;
bool issenserstate=false;

String playing=null;
double ssss;
double start=0;


double songtime;
double endtime;
bool _isactive;
bool _islistening;
String speech;
 double dd=0.0;
 bool first=false;
 bool firstsog=false;
 int priveindex=0;
 int currentindex;
 
List t1=[];
List t2=[];
int temp;
double seektime=null;
var _controlller;
 double x=0.0;
 double y;
 double z;
 AudioPlayer audioplayer=AudioPlayer();
bool onlyone=false;
Future play(String song) async
 {

   if(playerstate==AudioPlayerState.PLAYING )
   {
    
 await audioplayer.stop();
 
 setState(() {
  playing=null;  
 });
   }
   
  
        setState(() {
          songtime=0.0;
          first=false;
          dd=0.0;
          temp=0;
          
        priveindex=widget.index;
        });
        await audioplayer.play(song,isLocal: false);
        
 
   setState(() {
    
      playerstate=AudioPlayerState.PLAYING;
   });
   
 
        
  
   }
 Future seek(double val) async{
   print("in seek");
   print(val*(widget.duration[widget.index]/1000));
   await audioplayer.seek(val*(widget.duration[widget.index]/1000));
   setState(() {
    seektime=val; 
   });
 }
 
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkdarkmode();
    checksenser();
    
     if(start==0)
    {
      check();
       play(widget.url[widget.index]);
       start=1;
  
    }print(widget.index);
     print("play song in player sate");
     print("${widget.url[widget.index].toString()}");

    _controlller=IndexedScrollController(
      initialIndex: widget.index, 
    );
 
 
  if(issenserstate)
  {
          accelerometerEvents.listen((AccelerometerEvent event){
    
      if(event.x<-5.0  && event.y<0 && event.z>5.0)
                 {
                  
                    if(widget.index+1!=0){
                        play(widget.url[widget.index+1]);
                         setState(() {
                            widget.index++; 
                        onlyone=true;
                         });
                         
                      }
                 }
                 if(event.x>5.0 && event.y<0 &&event.z>5.0)
                 {
                               if(widget.index-1!=0){
                        play(widget.url[widget.index-1]);
                         setState(() {
                            widget.index--; 
                        onlyone=true;
                         });
                         
                      }
                 }
  });
  }
  
  print("song is ${widget.name[widget.index]}");
  
    
  
    if(playerstate==AudioPlayerState.COMPLETED){
      if(widget.index+1!=widget.name.length)
       
        setState(() {
          songtime=0.0;
          first=false;
          dd=0.0;
          temp=0;
           play(widget.url[widget.index+1]);
         widget.index++;
        
        });
    };
   
   
  }
  check()async
  {
    await audioplayer.stop();
  }
  Future puse() async
{
 try{
  await audioplayer.pause();
  
 }catch(e){print(e);}

}
 Future checkdarkmode() async
  {
    bool temp=await songadd().darkmode();
    print("in darkmode$temp");print(widget.index);
     print("play song in player sate");
     print("${widget.url.toString()}");
    setState(() {
      if(temp==null)
      {
        darkmode=false;
      }
      else
        darkmode=temp;
    });
  }
Future checksenser() async
  {
    bool temp=await songadd().sennsercheck();
    setState(() {
      if(temp==null)
      {
        issenserstate=false;
      }
      else
       
       {
         setState(() {
          issenserstate=temp; 
         });
       }
       
    });
    print(issenserstate);
  }
  @override
  Widget build(BuildContext context) {
  
     print(widget.index);
     print("play song in player sate");
     print("${widget.url[widget.index].toString()}");
   if(widget.nextsong)
   {
     
     play(widget.url[widget.index]);
     setState(() {
      widget.nextsong=false; 
     });

   }
   print("puse is${widget.puse}");
   if(widget.puse)
   {
     playing==null?  play(widget.url[widget.index]):puse();
     setState(() {
      widget.puse=false; 
     });

   }
  
    return MaterialApp(
      theme:darkmode? ThemeData.dark():ThemeData.light(),
      home: Scaffold(
        body: IndexedListView.builder(
          scrollDirection: Axis.horizontal,
   controller: _controlller,
        maxItemCount:widget. name.length,
        minItemCount: 0,
         addRepaintBoundaries: false,
       addAutomaticKeepAlives: false,
       emptyItemBuilder: (context,index)
       {
         return Container(
           color: Colors.orange,
         );

       },
          itemBuilder: (context,index){
           
         
             
            return GestureDetector(
            
              onHorizontalDragEnd: (DragEndDetails d){
               
                 print(d.velocity.pixelsPerSecond.dx);
                 if(d.velocity.pixelsPerSecond.dx>0)
                 {
                   
                     if(widget.index-1!=0){
                        play(widget.url[widget.index-1]);
                         setState(() {
                          widget.index--; 
                         });
                      }

                 }
                 else if(d.velocity.pixelsPerSecond.dx<=0)
                 {
                      if(widget.index+1!=widget.name.length){
                             play(widget.url[widget.index+1]);
                             setState(() {
                          widget.index++; 
                       
                          
                         });
                 }
                 }
                
                 
              },
            
           
                          child: Container(
               
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                            child: Column(
          children: <Widget>[
                SizedBox(height: 35.0,),
                Container(
                  height:  MediaQuery.of(context).size.height*0.65,
                  width: MediaQuery.of(context).size.width,
                   decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assert/logo.jpg"),
                )
              ),
              
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                                SizedBox(
                  height: 30.0,
                ),
                    IconButton(icon: Icon(Icons.fast_forward),iconSize: 35.0,onPressed: (){
                      if(widget.index-1!=0){
                        play(widget.url[widget.index-1]);
                         setState(() {
                          widget.index--; 
                         });
                      }
                    },),
                     IconButton(
                       icon:playing==null? Icon(Icons.play_circle_filled,
                       color: Colors.green,):Icon(Icons.pause),
                       iconSize: 55.0,
                       onPressed: (){
                       playing==null?   play(widget.url[widget.index]):puse();
                         
                         },),
                      IconButton(icon: Icon(Icons.fast_rewind),iconSize: 35.0,onPressed: (){
                            if(widget.index+1!=widget.name.length){
                            play(widget.url[widget.index+1]);
                             setState(() {
                          widget.index++; 
                       
                          
                         });
                            }
                      },),
                  ],
                ),
                
         SeekBar(
               progressWidth: 2.5,
               thumbRadius: 3.5,
              value: songtime,
           onProgressChanged: (val){
               seek(val);
              
           },
               progressColor: Colors.lightBlue,
               onStartTrackingTouch: ()
               {
                
               },
               
               barColor: Colors.red,
               
           ),
         
         SizedBox(height: 10.0,),
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          
         
          Text("${t1[1]}:${t2[0]}",style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),),
              SizedBox(width: MediaQuery.of(context).size.width-100.0,),
          
          Text("${((widget.duration[widget.index]/1000)/60).toInt()}:${((widget.duration[widget.index]/1000)%60).toInt()}",
          style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),
          ),
        
        ],
      )
                
          ],
        ),
              ),
            );
            
            
          },
          
        )
      ),
    );
  }
}
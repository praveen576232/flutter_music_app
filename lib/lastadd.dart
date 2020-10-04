
import 'package:flutter/material.dart';
import 'package:vediomusic/addsong.dart';
import 'package:vediomusic/player.dart';

void main()=>runApp(MySong());
class MySong extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: LastAdd(),
    );
  }
  
}




class LastAdd extends StatefulWidget {
  @override
  _LastAddState createState() => _LastAddState();
}

class _LastAddState extends State<LastAdd>
  {
   List<String> songs=[];
  bool darkmode=false;
  bool senserisonoroff=false;
  @override
  void initState() {
    super.initState();
    getaddedsong();
   checkdarkmode();
   checksenser();
  }
  Future getaddedsong() async
  {
    songs=List.from(await songadd().getsong());
    
  }
  Future checkdarkmode() async
  {
    bool temp=await songadd().darkmode();
    print("in darkmode$temp");
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
        senserisonoroff=false;
      }
      else
        senserisonoroff=temp;
        print("is senser$senserisonoroff");
    });
  }
  _orecoirded(int oldindex,int newindex)
  {
    setState(() {
     if(newindex>oldindex)
     {
       newindex-=1;
     } 
     var x=songs.removeAt(oldindex);
     songs.insert(newindex, x);
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:darkmode? ThemeData.dark():ThemeData.light(),
      debugShowCheckedModeBanner: false,
        home: Scaffold(
          body:Builder(
            builder: (BuildContext context){
              return songs.isNotEmpty? ReorderableListView(
          
            padding: EdgeInsets.only(top: 25.0),
            onReorder: _orecoirded,
            children: songs.map((s)=> Dismissible(
              key:Key(UniqueKey().toString()),
              onDismissed: (direction){
               //  Key(s.title);
                
                 bool delet=false;
                    int deletesongindex=songs.indexOf(s);
                    var x=songs.removeAt(deletesongindex);
                    Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(" item deleted"),
                    action: SnackBarAction(
                      label:"UNDO" ,
                      onPressed: (){
                       setState(() {
                        songs.insert(deletesongindex, x); 
                        delet=true;
                       });
                      },
                      
                    ),
                  
                    ));
                 if(!delet)
                 {
                 //  songadd().removesong(s);
                 }
              },
              
                          child: ListTile(
                  key: ObjectKey(s),
                 // title: Text(s.title),
                 // trailing: Text("${((duration/1000)/60).toInt()}:${((s.duration/1000)%60).toInt()}"),
                   onTap: (){
                     if(songs.contains(s))
                     {
                        int index=songs.indexOf(s);
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                        Player()));
                     }
                   },
                ),
            )).toList()
          ):Container(child: Center(child: Text("no song added",style: TextStyle(fontWeight: FontWeight.bold),),),);
            },
          )
        ),
    );
  }
}
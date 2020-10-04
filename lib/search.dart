
import 'package:flutter/material.dart';
import 'package:vediomusic/player.dart';
class  search extends SearchDelegate {
  List<String> name=[];
  List<String> url=[];
 List<String>album=[];
 List<String> artist=[];
 List<int>duration=[];
  bool darkthem;
  bool senser;
 
  search( s,bool b,bool c)
  {
     
     this.darkthem=b;
     this.senser=c;

  }
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [IconButton(icon: Icon(Icons.cancel),onPressed: (){query='';},)];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(icon:AnimatedIcon(icon: AnimatedIcons.menu_arrow,progress: transitionAnimation, ), onPressed: (){close(context, null);});
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    List<String> title=[];
    List<String> songname=[];
   
  List<String> myurl=[];
 List<String>myalbum=[];
 List<String> myartist=[];
 List<int>myduration=[];
    
    
    if(songname.isNotEmpty)
    {
      songname.clear();
    }
    if(myurl.isNotEmpty)
    myurl.clear();
    if(myalbum.isNotEmpty)
    myalbum.clear();
    if(myartist.isNotEmpty)
    myartist.clear();
    if(myduration.isNotEmpty)
    myduration.clear();
    for (int i = 0; i < name.length; i++) {
      title.add(name[i].toLowerCase());
    }
    final sortlist=query.isEmpty?title:title.where((p)=>p.startsWith(query)).toList();
     for(int i=0;i<sortlist.length;i++)
   {
         for(int j=0;j<title.length;j++)
           { 
             if(sortlist[i]==title[j])
             {
               songname.add(name[j]);
               myartist.add(artist[j]);
               myalbum.add(album[j]);
               myduration.add(duration[j]);
               myurl.add(url[j]);

               
                
             }
           }
   }
    return 
     ListView.builder(
      itemCount: sortlist?.length,
      itemBuilder: (context,index)
      {
         return ListTile(
           leading: Container(
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assert/logo.jpg"),
                )
              ),
           ),
              title: Text(songname[index]),
              trailing: Text( "${((myduration[index]/1000)/60).toInt()}:${((myduration[index]/1000)%60).toInt()}"),
              onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                      Player()));
              },
         );
      }
    );
  }

  
}

import 'package:matcher/matcher.dart';
 class  songadd
{
    List<String> name=[];
  List<String> url=[];
 List<String>album=[];
 List<String> artist=[];
 List<int>duration=[];
 static bool isdarkmode;
 static bool issenser=false;
 sogadd(String name, String album,String url,String artist,int duration)
 {
   this.name.add(name);
   this.duration.add(duration);
   this.album.add(album);
   this.artist.add(artist);
   this.url.add(url);

   
    
 }
 Future<void>removesong(int index)
 {
   name.removeAt(index);
   url.removeAt(index);
   album.removeAt(index);
   artist.removeAt(index);
   duration.removeAt(index);
 }
 Future<void> darkthem(bool b)
 {
   isdarkmode=b;
 }
 Future<void> sensermode(bool s)
 {
   issenser=s;
 }
 Future<List<String>> getsong()
 {
   return Future.value(name);
 }
 Future<bool> darkmode()
 {
   return Future.value(isdarkmode);
 }
 Future <bool> sennsercheck()
 {
   return Future.value(issenser);
 }
  songduration()
{
  Set n= duration.toSet();
 
  return Future.value(n);
}
 songname()
{
  Set n= name.toSet();
 
  return Future.value(n);
}
 songurl()
{
  Set n=url.toSet();
  
  return Future.value(n);
}
 songartist()
{
  Set n=artist.toSet();
  
  return Future.value(n);
}
 songalbum()
{
  Set n=album.toSet();
  
  return Future.value(n);
}
}
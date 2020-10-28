import 'package:flutter/material.dart';

class createBlog extends StatefulWidget {
  @override
  _createBlogState createState() => _createBlogState();
}

class _createBlogState extends State<createBlog> {

  String authorName, title, desc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(elevation:0.0,backgroundColor:Colors.transparent,title: Row(mainAxisAlignment:MainAxisAlignment.center,
      children: <Widget>[
        Text("Flutter",style: TextStyle(fontSize: 22,color: Colors.white),),
        Text("Blog",style: TextStyle(fontSize: 22,color: Colors.blue),)
      ],),actions:
    [
      Container(padding: EdgeInsets.symmetric(horizontal: 16),child: Icon(Icons.file_upload)),
    ],),
      body:
      Column(
        children: [
          SizedBox(height: 10,),
          Container(margin: EdgeInsets.symmetric(horizontal: 16.0),height: 150, width: MediaQuery.of(context).size.width, child: Icon(Icons.add_a_photo,color: Colors.black45,),decoration: BoxDecoration(
            color: Colors.white,borderRadius: BorderRadius.circular(6)
          ),),
          SizedBox(height: 8,),
          Container(padding:EdgeInsets.symmetric(horizontal: 16),child: Column(children: [
            TextField(decoration: InputDecoration(hintText: "Author name"),onChanged: (value){authorName=value;},),
          ],),),
          Container(padding:EdgeInsets.symmetric(horizontal: 16),child: Column(children: [
            TextField(decoration: InputDecoration(hintText: "Title"),onChanged: (value){title=value;},),
          ],),),
          Container(padding:EdgeInsets.symmetric(horizontal: 16),child: Column(children: [
            TextField(decoration: InputDecoration(hintText: "Description"),onChanged: (value){desc=value;},),
          ],),)
        ],
      ),);
  }
}

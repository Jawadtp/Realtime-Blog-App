import 'package:blog_app/views/create_blog.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(elevation:0.0,backgroundColor:Colors.transparent,title: Row(mainAxisAlignment:MainAxisAlignment.center,
      children: <Widget>[
      Text("Blog",style: TextStyle(fontSize: 22,color: Colors.white),),
      Text("App",style: TextStyle(fontSize: 22,color: Colors.blue),)
    ],),),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(mainAxisAlignment:MainAxisAlignment.center,children: [
          FloatingActionButton(child: Icon(Icons.add),onPressed: ()
          {
            Navigator.push(context, MaterialPageRoute(builder: (context) => createBlog()));
          },)
        ],),
      ) ,);
  }
}

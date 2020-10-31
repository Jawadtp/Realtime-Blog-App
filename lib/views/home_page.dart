import 'package:blog_app/services/crud.dart';
import 'package:blog_app/views/create_blog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  CrudMethods crudMethods = new CrudMethods();
  Stream blogsStream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    crudMethods.getData().then((result)
    {
      blogsStream=result;
    });
  }
/*
  ListView.builder(itemCount: blogsSnapshot.docs.length,itemBuilder: (context, index)
  {

  return BlogsTile(name: blogsStream.docs[index].get('title'), desc: blogsSnapshot.docs[index].get('desc'), imgURL: blogsSnapshot.docs[index].get('imgURL'), authorName: blogsSnapshot.docs[index].get('authorName'),);

  })       :Container(child: Center(child: CircularProgressIndicator()),) */


  Widget BlogsList()
  {
    return Container(child: blogsStream!=null ?
      StreamBuilder(stream: blogsStream, builder: (context,snapshot){
        return ListView.builder(itemCount: snapshot.data.docs.length,itemBuilder: (context, index)
        {

          return BlogsTile(name: snapshot.data.docs[index].get('title'), desc: snapshot.data.docs[index].get('desc'), imgURL: snapshot.data.docs[index].get('imgURL'), authorName: snapshot.data.docs[index].get('authorName'),);

        });
      },):Center(child: Container(child: CircularProgressIndicator(),))
    );
  }

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
      ) ,body: BlogsList()

      ,);
  }
}

class BlogsTile extends StatelessWidget
{
  String name, desc, imgURL, authorName;

  BlogsTile({@required this.name, @required this.desc, @required this.imgURL, @required this.authorName});

  CrudMethods crudMethods;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(borderRadius: BorderRadius.circular(30),
      child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)), height: 150, width: MediaQuery.of(context).size.width,margin: EdgeInsets.only(left: 10, right: 10,bottom: 20),
      child: Stack(
        children: [
          Image.network(imgURL,width: MediaQuery.of(context).size.width,fit: BoxFit.cover,),
          Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
              Container(margin:EdgeInsets.only(bottom: 8),child: Text(name, style: TextStyle(fontWeight:FontWeight.bold,fontSize: 25),)),
              Container(margin:EdgeInsets.only(bottom: 8),child: Text(desc, style: TextStyle(fontSize: 20),)),
              Text(authorName, style: TextStyle(fontSize: 17),)

            ],),
          ),
        ],
      ),),
    );
  }
}

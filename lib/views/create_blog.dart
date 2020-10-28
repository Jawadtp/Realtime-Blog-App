import 'package:blog_app/services/crud.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class createBlog extends StatefulWidget {
  @override
  _createBlogState createState() => _createBlogState();
}

class _createBlogState extends State<createBlog> {

  String authorName, title, desc;
  CrudMethods crudMethods = new CrudMethods();
  File selectedImage;

  bool isSelected=false;
  bool _isLoading=false;
  Future getImage() async
  {
    //var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    PickedFile picked = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      selectedImage=File(picked.path);
      isSelected=true;
    });
  }

  uploadBlog() async
  {
    if(isSelected)
      {
        setState(() {
          _isLoading=true;
        });
        StorageReference firebasestor=FirebaseStorage.instance.ref().child("blogImages").child("${randomAlphaNumeric(9)}.jpg");
        final StorageUploadTask task = firebasestor.putFile(selectedImage);
        var downloadURL = await (await task.onComplete).ref.getDownloadURL();
        print("This is the URL: $downloadURL");
        Map<String, String> blogMap =
        {
          "imgURL":downloadURL,
          "authorName": authorName,
          "title": title,
          "desc": desc
        };
        crudMethods.addData(blogMap).then((result) => Navigator.pop(context));

      }
    else
      {

      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(elevation:0.0,backgroundColor:Colors.transparent,title: Row(mainAxisAlignment:MainAxisAlignment.center,
      children: <Widget>[
        Text("Flutter",style: TextStyle(fontSize: 22,color: Colors.white),),
        Text("Blog",style: TextStyle(fontSize: 22,color: Colors.blue),)
      ],),actions:
    [
      Container(padding: EdgeInsets.symmetric(horizontal: 16),child: IconButton(icon: Icon(Icons.file_upload),onPressed: (){uploadBlog();},)),
    ],),
      body: _isLoading? Container(child: Center(child: CircularProgressIndicator(),),):
      Column(
        children: [
          SizedBox(height: 10,),
          GestureDetector(
            onTap: (){getImage();},
            child: (selectedImage!=null) ?
            Container(child: ClipRRect(borderRadius: BorderRadius.circular(6),child: Image.file(selectedImage,fit: BoxFit.cover,)), margin: EdgeInsets.symmetric(horizontal: 16.0),height: 150, width: MediaQuery.of(context).size.width,decoration: BoxDecoration(
                color: Colors.white,borderRadius: BorderRadius.circular(6)))

            :Container(margin: EdgeInsets.symmetric(horizontal: 16.0),height: 150, width: MediaQuery.of(context).size.width, child: Icon(Icons.add_a_photo,color: Colors.black45,),decoration: BoxDecoration(
              color: Colors.white,borderRadius: BorderRadius.circular(8)
            ),),
          ),
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

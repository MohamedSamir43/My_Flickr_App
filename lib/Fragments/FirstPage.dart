import 'package:flutter/material.dart';
import 'package:My_Flickr_App/Fragments/Photos.dart';
import 'package:My_Flickr_App/Widgets/CustomListView.dart';
import 'package:My_Flickr_App/Core/Services.dart';

class First extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: new Scaffold(
        body: new Center(
          child: new FutureBuilder<Photos>(
            future: fetchphotos('cats','1'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Photos photos = snapshot.data;
                return new CustomListView(photos);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }else //<-----------< Here <----------------------
                return new CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

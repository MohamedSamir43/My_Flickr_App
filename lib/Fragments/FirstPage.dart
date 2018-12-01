import 'dart:async';

import 'package:flutter/material.dart';
import 'package:My_Flickr_App/Fragments/Photo.dart';
import 'package:My_Flickr_App/Fragments/Photos.dart';
import 'package:My_Flickr_App/Widgets/CustomListView.dart';
import 'package:My_Flickr_App/Core/Services.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';


class First extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Photos data = new Photos();
  int currentLength = 0;
  int currentPageNumber = 1;
  int currentPhotosCount = 0;

  @override
  void initState() {
    _loadMore();
    super.initState();
  }

  void _loadMore() {
    setState(() {
      currentPageNumber++;
      Future<Photos> addedPhotos = getPhotos("dogs", currentPageNumber, 10);

      addedPhotos.then((newPhotos) {
        if(data.photolist != null)
           data.photolist.addAll(newPhotos.photolist);
        else
          data.photolist = newPhotos.photolist;
        currentPhotosCount=data.photolist.length;
      }, onError: (e) {
        print(e);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: LazyLoadScrollView(
        onEndOfPage: () => _loadMore(),

        child: ListView.builder(
          itemCount: currentPhotosCount,
          itemBuilder: (context, position) {
            return createViewItem(data.photolist[position], context);
          },
        ),
      ),
    );
  }

}

Widget createViewItem(Photo photo, BuildContext context) {
  return new ListTile(
    title: new Card(
        elevation: 1.0,
        child: new Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.purple)),
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Padding(
                child: Image.network(photo.url),
                padding: EdgeInsets.only(bottom: 8.0),
              ),
              Row(
                children: <Widget>[
                  Padding(
                      child: Text(
                        photo.title,
                        style: new TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.right,
                      ),
                      padding: EdgeInsets.all(1.0)),
                  Text(" * "),
                  Padding(
                    child: Text(
                      photo.owner,
                      style: new TextStyle(fontStyle: FontStyle.italic),
                      textAlign: TextAlign.right,
                    ),
                    padding: EdgeInsets.all(1.0),
                  )
                ],
              )
            ],
          ),
        )),
  );
}

//class First extends StatelessWidget {
//
//  Photos currentPhotos;
//  int currentPageIndex;
//
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      theme: new ThemeData(
//        primarySwatch: Colors.purple,
//      ),
//      home: new Scaffold(
//        body:  LazyLoadScrollView(
//          onEndOfPage: () => loadMore(),
//          child: ListView.builder(
//            itemCount: .length,
//            child: new FutureBuilder<Photos>(
//              future: getPhotos('cats',1,10),
//              builder: (context, snapshot) {
//                if (snapshot.hasData) {
//                  currentPhotos = snapshot.data;
//                  return new CustomListView(currentPhotos);
//                } else if (snapshot.hasError) {
//                  return Text('${snapshot.error}');
//                }else //<-----------< Here <----------------------
//                  return new CircularProgressIndicator();
//              },
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//
//  loadMore() {
//
//  }
//}

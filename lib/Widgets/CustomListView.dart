import 'package:flutter/material.dart';
import 'package:My_Flickr_App/Models/Photos.dart';
import 'package:My_Flickr_App/Models/Photo.dart';

class CustomListView extends StatelessWidget {
  final Photos photols;
  int currentPhotosCount;
  CustomListView(this.currentPhotosCount,this.photols);

  Widget build(context) {
    return ListView.builder(
      itemCount: currentPhotosCount,
      itemBuilder: (context, int index) {
        return createViewItem(photols.photolist[index], context);
      },
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

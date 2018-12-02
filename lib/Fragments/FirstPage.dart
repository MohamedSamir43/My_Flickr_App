import 'package:flutter/material.dart';
import 'package:My_Flickr_App/Models/Photo.dart';
import 'package:My_Flickr_App/Models/Photos.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:My_Flickr_App/Core/PhotosSearchLogic.dart';

class First extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new MyFirstPage(),
    );
  }
}

class MyFirstPage extends StatefulWidget {
  @override
  _MyFirstPageState createState() => new _MyFirstPageState();
}

class _MyFirstPageState extends State<MyFirstPage> {
  PhotosSearchLogic _logic = new PhotosSearchLogic();
  static TextEditingController _filter = new TextEditingController();
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new TextField(
    controller: _filter,
    decoration: new InputDecoration(hintText: 'Search...'),
  );

  Photos photos = new Photos();
  Photos filteredPhotos = new Photos();

  String currentSearchText = '';

  int currentPageNumber = 1;
  int currentPageSize = 10;
  int currentPhotosCount = 0;

  _MyFirstPageState() {
    _filter.addListener(() {
      if (!_filter.text.isEmpty) {
        setState(() {
          currentSearchText = _filter.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: Container(
        child: _buildList(),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
    );
  }

  Widget _buildList() {
    return new Scaffold(
      body: LazyLoadScrollView(
        onEndOfPage: () => _loadMore(),
        child: ListView.builder(
          itemCount: currentPhotosCount,
          itemBuilder: (context, position) {
            return createViewItem(photos.photolist[position], context);
          },
        ),
      ),
    );
  }

  void _getPhotos() async {
    _logic
        .getPhotos(currentSearchText, currentPageNumber, currentPageSize)
        .then((response) {
      setState(() {
        if (photos.photolist == null)
          photos = response;
        else
          photos.photolist.addAll(response.photolist);
        currentPhotosCount = photos.photolist.length;
      });
    }, onError: (e) {
      print(e);
    });
  }

  void _searchPressed() {
    setState(() {
      _getPhotos();
      _filter.clear();
      photos = new Photos();
      currentPhotosCount = 0;
    });
  }

  void _loadMore() {
    setState(() {
      currentPageNumber++;
    });
    _getPhotos();

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
}

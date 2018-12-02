import 'package:flutter/material.dart';
import 'package:My_Flickr_App/Fragments/FirstPage.dart' as first;
import 'package:My_Flickr_App/Fragments/SecondPage.dart' as second;

void main () {
  runApp(new MaterialApp(
    home: new MyTabs(),
  ));
}

class MyTabs extends StatefulWidget {
  @override
  MyTabsState createState() => MyTabsState();
}

class MyTabsState extends State<MyTabs> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("My Flickr App"),
        backgroundColor: Colors.lightBlueAccent,
        bottom: new TabBar(
          controller: controller,
          tabs: <Tab>[
            new Tab(icon: new Icon(Icons.image) , text: 'Search Photos',),
            new Tab(icon: new Icon(Icons.people) , text: 'Search Groups',),
          ],
        ),
      ),
      body: new TabBarView(
          controller: controller,
          children: <Widget>[
            new first.First(),
            new second.Second(),
          ]),
    );
  }
}
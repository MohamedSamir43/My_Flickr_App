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
        title: new Text("Pages"),
        backgroundColor: Colors.lightBlueAccent,
        bottom: new TabBar(
          controller: controller,
          tabs: <Tab>[
            new Tab(icon: new Icon(Icons.local_pizza) , text: 'First Page',),
            new Tab(icon: new Icon(Icons.favorite) , text: 'Second Page',),
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
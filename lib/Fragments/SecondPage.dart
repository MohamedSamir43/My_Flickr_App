import 'package:flutter/material.dart';
import 'package:My_Flickr_App/Models/Group.dart';
import 'package:My_Flickr_App/Models/Groups.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:My_Flickr_App/Core/GroupsSearchLogic.dart';

class Second extends StatelessWidget {
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
  GroupsSearchLogic _logic = new GroupsSearchLogic();
  static TextEditingController _filter = new TextEditingController();
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new TextField(
    controller: _filter,
    decoration: new InputDecoration(hintText: 'Search...'),
  );

  Groups groups = new Groups();

  String currentSearchText = '';

  int currentPageNumber = 1;
  int currentPageSize = 10;
  int currentGroupsCount = 0;

  _MyHomePageState() {
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
          itemCount: currentGroupsCount,
          itemBuilder: (context, position) {
            return createViewItem(groups.grouplist[position], context);
          },
        ),
      ),
    );
  }

  void _getGroups() async {
    _logic
        .getGroups(currentSearchText, currentPageNumber, currentPageSize)
        .then((response) {
      setState(() {
        if (groups.grouplist == null)
          groups = response;
        else
          groups.grouplist.addAll(response.grouplist);
        currentGroupsCount = groups.grouplist.length;
      });
    }, onError: (e) {
      print(e);
    });
  }

  void _searchPressed() {
    setState(() {
      _getGroups();
      _filter.clear();
      groups = new Groups();
      currentGroupsCount = 0;
    });
  }

  void _loadMore() {
    setState(() {
      currentPageNumber++;
    });
    _getGroups();

  }

  Widget createViewItem(Group group, BuildContext context) {
    return new ListTile(
      title: new Card(
          elevation: 1.0,
          child: new Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.purple)),
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                        child: Text(
                          group.name,
                          style: new TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.right,
                        ),
                        padding: EdgeInsets.all(1.0)),
                    Text(" * "),
                    Padding(
                      child: Text(
                        group.members,
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
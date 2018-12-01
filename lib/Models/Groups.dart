import 'package:My_Flickr_App/Models/Group.dart';

class Groups {
  final int page, pages, perpage;
  final int total;
  List<Group> grouplist;


  Groups({this.page, this.pages, this.perpage, this.total, this.grouplist});

  factory Groups.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['groups']['group'] as List;
    return new Groups(
        page: parsedJson['page'],
        pages: parsedJson['pages'],
        perpage: parsedJson['perpage'],
        total: parsedJson['total'],
        grouplist: list.map((i) => Group.fromJson(i)).toList());
  }
}

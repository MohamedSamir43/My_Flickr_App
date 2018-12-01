import 'package:My_Flickr_App/Models/Photo.dart';

class Photos {
  final int page, pages, perpage;
  final int total;
  List<Photo> photolist;


  Photos({this.page, this.pages, this.perpage, this.total, this.photolist});

  factory Photos.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['photos']['photo'] as List;
    return new Photos(
        page: parsedJson['page'],
        pages: parsedJson['pages'],
        perpage: parsedJson['perpage'],
        total: parsedJson['total'],
        photolist: list.map((i) => Photo.fromJson(i)).toList());
  }
}

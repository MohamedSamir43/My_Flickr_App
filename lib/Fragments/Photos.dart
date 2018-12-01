import 'Photo.dart';

class Photos {
  final int pageNumber, totalPages, pageSize;
  final int totalPhotos;
  List<Photo> photolist = new List<Photo>();

  Photos({this.pageNumber, this.totalPages, this.pageSize, this.totalPhotos, this.photolist});

  factory Photos.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['photos']['photo'] as List;
    return new Photos(
        pageNumber: parsedJson['page'],
        totalPages: parsedJson['pages'],
        pageSize: parsedJson['perpage'],
        totalPhotos: parsedJson['total'],
        photolist: list.map((i) => Photo.fromJson(i)).toList());
  }
}

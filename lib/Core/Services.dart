import 'package:My_Flickr_App/Fragments/Photos.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'PublicKeys.dart';

Future<Photos> getPhotos(String searchText ,int currentPageNumber,int currentPageSize) async {
  PublicKeys.searchText = searchText;
  PublicKeys.pageNumber = currentPageNumber;
  PublicKeys.pageSize = currentPageSize;

  final jsonEndPoint = PublicKeys.photosSearchAPI;

  final response = await http.get(jsonEndPoint);

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return Photos.fromJson(data);
  } else {
    return throw Exception('we were unable to retreive json data');
  }
}
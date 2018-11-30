import 'package:My_Flickr_App/Fragments/Photos.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'PublicKeys.dart';

Future<Photos> fetchphotos(String searchText ,String currentPageNumber) async {
  PublicKeys.searchText = searchText;
  PublicKeys.pageNumber = currentPageNumber;
  final jsonEndPoint = PublicKeys.photosSearchAPI;

  final response = await http.get(jsonEndPoint);

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return Photos.fromJson(data);
  } else {
    return throw Exception('we were unable to retreive json data');
  }
}
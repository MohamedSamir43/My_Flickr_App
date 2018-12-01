import 'package:My_Flickr_App/Models/Groups.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'PublicKeys.dart';

class GroupsSearchLogic {
  Future<Groups> getGroups(String searchText ,int currentPageNumber,int currentPageSize) async {
    PublicKeys.search_Text = searchText;
    PublicKeys.pageNumber = currentPageNumber;
    PublicKeys.pageSize = currentPageSize;

    var jsonEndPoint = PublicKeys.getGroupsSearchAPI();

    var response = await http.get(jsonEndPoint);

    if (response.statusCode == 200) {

      var data = json.decode(response.body);
      return Groups.fromJson(data);
    } else {
      return throw Exception('we were unable to retreive json data');
    }
  }
}
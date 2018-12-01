import 'package:My_Flickr_App/Fragments/Photo.dart';

abstract class Repository {
  Future<Photo> getPhoto(int index);
}
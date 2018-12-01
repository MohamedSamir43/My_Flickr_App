import 'dart:async';
import 'dart:collection';

import 'Repository.dart';
import 'Cache.dart';
import 'package:My_Flickr_App/Fragments/Photo.dart';
import 'package:My_Flickr_App/Fragments/Photos.dart';
import 'package:My_Flickr_App/Core/Services.dart';

class CachingRepository extends Repository {
  final int pageSize;
  final Cache<Photo> cache;

  final pagesInProgress = Set<int>();
  final pagesCompleted = Set<int>();
  final completers = HashMap<int, Set<Completer>>();

  int totalProducts;

  CachingRepository({this.pageSize, this.cache});

  @override
  Future<Photo> getPhoto(int index) {
    final pageIndex = pageIndexFromPhotoIndex(index);

    if (pagesCompleted.contains(pageIndex)) {
      return cache.get(index);
    } else {
      if (!pagesInProgress.contains(pageIndex)) {
        pagesInProgress.add(pageIndex);
        var future = getPhotos('cats',pageIndex, pageSize);
        future.asStream().listen(onData);
      }
      return buildFuture(index);
    }
  }

  Future<Photo> buildFuture(int index) {
    var completer = Completer<Photo>();

    if (completers[index] == null) {
      completers[index] = Set<Completer>();
    }
    completers[index].add(completer);

    return completer.future;
  }

  void onData(Photos photos) {
    if (photos != null) {
      totalProducts = photos.totalPhotos;
      pagesInProgress.remove(photos.pageNumber);
      pagesCompleted.add(photos.pageNumber);

      for (int i = 0; i < pageSize; i++) {
        int index = photos.pageSize * photos.pageNumber + i;
        Photo product = photos.photolist[i];

        cache.put(index, product);
        Set<Completer> comps = completers[index];

        if (comps != null) {
          for (var completer in comps) {
            completer.complete(product);
          }
          comps.clear();
        }
      }
    } else {
      print("CachingRepository.onData(null)!!!");
    }
  }

  int pageIndexFromPhotoIndex(int photoIndex) {
    return photoIndex ~/ pageSize;
  }
}
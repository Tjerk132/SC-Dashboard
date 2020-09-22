import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/tile_size.dart';
import 'package:flutter_test_project/printers/logger.dart';

class ImageDao {

  /// [minimalToCompute] the number of items the list of items has to contain to start using isolates.
  ImageDao({this.minimalToCompute = 20}) {
    this.divideTo = this.minimalToCompute;
    if(this.divideTo.isOdd) {
      throw new ArgumentError('minimalToCompute argument must be an even number');
    }
  }

  Logger logger = new Logger(name: ImageDao, timedPrinting: true);

  // minimal items in list to enable computing
  int minimalToCompute;
  // number of isolates to be spawned
  /// will always be calculated in the [calculateIsolateCount] method
  int isolateCount = 0;
  // size of the list each isolate will process
  int divideTo;
  // flag to indicate if the given list of items is uneven
  bool unevenItemCount = false;
  // determines if the given list can be processed evenly
  bool dividableToIsolates = true;

  /// Retrieve the images with the given list of [sizes],
  /// if the length of [tileSizes] is higher than [minimalToCompute]
  /// [isolateCount] isolates will be spawned to compute the dividable images.
  ///
  /// If [unevenItemCount] is true of if [dividableToIsolates] is false then
  /// the non dividable images will be retrieved on the main thread.
  Future<List<NetworkImage>> getImages(List<TileSize> tileSizes) async {

    List<TileSize> sizes = new List<TileSize>.from(tileSizes);

    isolateCount = calculateIsolateCount(sizes.length);

    if(isolateCount > 0) {
      logger.log(message: '$isolateCount isolates are going to be spawned');
      List<NetworkImage> images = new List<NetworkImage>();

      // handle the non dividable on main thread
      // this MUST happen first because non dividable sizes for images get removed from [sizes]
      if(unevenItemCount || !dividableToIsolates) {
        // add images from sublist to images list
        images.addAll(retrieveNondividableItems(sizes));
      }
      // let isolates compute images
      List<List<TileSize>> subLists = divideList(sizes, isolateCount);
      for (List<TileSize> sizes in subLists) {
        List<NetworkImage> isolateImages = await compute(retrieveImages, sizes);
        images.addAll(isolateImages);
      }
      return images;
    }
    else return retrieveImages(sizes);
  }

  /// divide sizes list by [divideTo] if more then [minimalToCompute] sizes are present to divide for isolates
  /// and calculate if all items can be computed with the given [sizeLength]
  /// returns the number of isolates to compute with
  int calculateIsolateCount(int sizeLength) {

    if(sizeLength.isOdd) {
      logger.log(message: 'uneven list: not all items will be computed');
      unevenItemCount = true;
    }
    if(sizeLength > minimalToCompute) {
      double isolateCount = sizeLength / divideTo;

      if(!(isolateCount is int || isolateCount == isolateCount.roundToDouble())) {
        dividableToIsolates = false;
        logger.log(message: 'non dividable: not all items could be divided with the available number of isolates');
      }
      return isolateCount.floor();
    }
    else return 0;
  }

  /// Divide the given [sizes] list into subLists with a length of [divideIn]
  List<List<TileSize>> divideList(List<TileSize> sizes, int divideIn) {
    int totalLength = sizes.length;
    int subListLength = (totalLength / divideIn).round();
    List<List<TileSize>> subLists = List<List<TileSize>>();

    for(int i = 0; i < totalLength; i += subListLength) {
      int end = i + subListLength;
      subLists.add(sizes.sublist(i,end));
    }
    return subLists;
  }

  /// Retrieve the non dividable items from [sizes] on the main thread
  List<NetworkImage> retrieveNondividableItems(List<TileSize> sizes) {
    int dividableByIsolates = divideTo * isolateCount;

    int start = dividableByIsolates - 1;
    int end = sizes.indexOf(sizes.last);
    // create sublist of not dividable sizes
    List<TileSize> indivisibleByIsolates = sizes.sublist(start, end);
    // remove sublist from main sizes list
    sizes.removeRange(start, end);
    return retrieveImages(indivisibleByIsolates);
  }
}

/// Retrieve images of type [NetworkImage] with the given [sizes] list
/// Note: this method needs to be placed outside of class [ImageDao] to allow
/// isolates to compute their list
List<NetworkImage> retrieveImages(List<TileSize> sizes) {

  List<NetworkImage> images = new List<NetworkImage>();

  for (TileSize size in sizes) {
    NetworkImage image = createImage(
        'https://picsum.photos/${size.width}/${size.height}/');
    images.add(image);
  }
  return images;
}

NetworkImage createImage(String imageUrl) => NetworkImage(imageUrl);

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test_project/data/image_dao.dart';
import 'package:flutter_test_project/printers/logger.dart';
import 'package:flutter_test_project/shimmering/tile_shimmer.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_group.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_groups.dart';

import '../models/tile_size.dart';
import '../models/tile_state.dart';

class DashboardLogic {
  Logger logger = new Logger(name: DashboardLogic, timedPrinting: true);

  ImageDao _dao;
  List<TileState> _states;

  final int crossAxisCount;
  int occupied = 0;
  Random r;

  DashboardLogic(int sizesLength, this.crossAxisCount) {
    this._states = List.generate(
      sizesLength,
      (index) => new TileState(index),
    );
    this._dao = new ImageDao();
    this.r = new Random();
  }

  TileGroup createTile(NetworkImage image, int index, int sizesLength) {
    //todo callback hasData
    if (index == sizesLength - 1) {
      return createLastTile(index, image);
    }
    return createNewTile(index, image);
  }

  TileGroup createNewTile(int index, NetworkImage image) {
    int dimension = r.nextInt(3) + 1;

    TileGroup group = TileGroup.dimensionFactory(image,
        horizontal: dimension, vertical: dimension);
    occupied += group.data.occupiedSpaces;

    if (group is MediumTileGroup) {
      //todo callback aligned vertical
      _states[index].alignVertical = true;
    }
    return group;
  }

  TileGroup createLastTile(int index, NetworkImage image) {
    int size = occupied % crossAxisCount;
    logger.log(message: 'space for last tile is $size');
    return TileGroup.sizeFactory(image, size: size);
  }

  Widget createShimmer(int index) {
    setTileShimmering(index, true);
    return TileShimmer(
        height: 600,
        imageShimmerRatio: 0.45,
        titleShimmer: true,
        textShimmers: 2);
  }

  Future<List<NetworkImage>> getImages(List<TileSize> sizes) async =>
      await _dao.getImages(sizes);

  void setTileShimmering(int index, bool shimmer) =>
      _states[index].shimmering = shimmer;

  bool getTileShimmer(int index) => _states[index].shimmering;

  bool getTileAlignVertical(int index) => _states[index].alignVertical;

  void setStateHasData(int index) => _states[index].setHasData();
}

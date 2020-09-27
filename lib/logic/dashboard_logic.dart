import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test_project/data/image_dao.dart';
import 'package:flutter_test_project/shimmering/tile_shimmer.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_groups.dart';

import '../models/tile_size.dart';
import '../models/tile_state.dart';

class DashboardLogic {
  ImageDao _dao;

  List<TileState> _states;

  List<TileSize> _sizes;

  int occupied = 0;

  Random r;

  DashboardLogic(this._sizes) {
    this._states = List.generate(
      _sizes.length,
      (index) => new TileState(index),
    );
    this._dao = new ImageDao();
    this.r = new Random();
  }

  Widget createTile(NetworkImage image, int index, int crossAxisCount) {
    setStateHasData(index);
    if (_sizes[index] == _sizes.last) {
      return createLastTile(index, crossAxisCount, image);
    }
    return createNewTile(index, image);
  }

  Widget createNewTile(int index, NetworkImage image) {
    switch (r.nextInt(3)) {
      case 0:
        occupied += 1;
        return SmallTileGroup(image);
      case 1:
        occupied += 2;
        _states[index].alignVertical = true;
        return MediumTileGroup(image);
      case 2:
        occupied += 4;
        return LargeTileGroup(image);
      default:
        return SizedBox();
    }
  }

  Widget createLastTile(int index, int crossAxisCount, NetworkImage image) {
    print('unfillable space ${occupied % crossAxisCount} for last tile');
    switch (occupied % crossAxisCount) {
      case 0:
        if (_states.length.isOdd) {
          return LargeTileGroup(image);
        }
        return SizedBox();
      case 1:
        return SmallTileGroup(image);
      case 2:
        return MediumTileGroup(image);
      case 3:
        return Text('3');
      default:
        return Text('default');
    }
  }

  Widget createShimmer(int index) {
    setTileShimmering(index, true);
    return TileShimmer(
        height: 600,
        imageShimmerRatio: 0.45,
        titleShimmer: true,
        textShimmers: 2);
  }

  Future<List<NetworkImage>> getImages() async => await _dao.getImages(_sizes);

  void setTileShimmering(int index, bool shimmer) =>
      _states[index].shimmering = shimmer;

  bool getTileShimmer(int index) => _states[index].shimmering;

  bool getTileAlignVertical(int index) => _states[index].alignVertical;

  void setStateHasData(int index) => _states[index].setHasData();
}

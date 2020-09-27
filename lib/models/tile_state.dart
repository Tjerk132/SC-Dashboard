import 'dart:core';

class TileState {

                         //initially unset is false
  TileState(this.index, {this.alignVertical = false, this.shimmering = true});

  int index;
  bool alignVertical;
  //initially always true
  bool shimmering;
  bool hasData = false;

  void setHasData() {
    this.shimmering = false;
    this.hasData = true;
  }



//  set setShimmering() => states.putIfAbsent(index, () => false)
//
//  void addValueToMap<K, V>(Map<K, List<V>> map, K key, V value) =>
//      map.update(key, (list) => list..add(value), ifAbsent: () => [value]);
//
//  get bool isLoaded() => states.c
}
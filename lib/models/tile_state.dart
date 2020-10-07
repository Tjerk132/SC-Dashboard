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
}
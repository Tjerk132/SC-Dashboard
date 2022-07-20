// import 'package:flutter/material.dart';
// import 'package:flutter_test_project/enums/tile_group_type.dart';
// import 'package:flutter_test_project/views/dashboard/tile_components/tile_group.dart';
//

/// TileGroup requires to be extended by a subclass,
/// all extending classes of the [TileGroup] class are present
/// in the file [tile_groups.dart]
///
/// Example:
/// ```dart
/// class SmallTileGroup extends TileGroup {
///   SmallTileGroup(List<Widget> children)
///       : super.fromDimensions(children, horizontal: 2, vertical: 2);
/// }
/// ```
/// and requires the parameters [horizontal], [vertical]
/// and [children]. [children] is what will be displayed
/// inside the TileGroup and has to be of type [Widget].

// TileGroup.fromDimensions(
//   this.children, {
//   // required this.singularSize,
//   // required this.occupationSize,
//   // required this.horizontal,
//   // required this.vertical,
//   required this.groupType,
// });

// class SmallTileGroup extends TileGroup {
//   SmallTileGroup(List<Widget> children)
//       : super.fromDimensions(children,
//             occupationSize: 4,
//             // horizontal: 2,
//             // vertical: 2,
//             groupType: TileGroupType.small);
// }
//
// class MediumTileGroup extends TileGroup {
//   MediumTileGroup(List<Widget> children)
//       : super.fromDimensions(children,
//             occupationSize: 2,
//             // horizontal: 2,
//             // vertical: 1,
//             groupType: TileGroupType.medium);
// }
//
// class LargeTileGroup extends TileGroup {
//   LargeTileGroup(List<Widget> children)
//       : super.fromDimensions(children,
//             occupationSize: 4,
//             // horizontal: 1,
//             // vertical: 1,
//             groupType: TileGroupType.large);
// }
//
// class TitleTileGroup extends TileGroup {
//   TitleTileGroup(Widget child)
//       : super.fromDimensions([child],
//             occupationSize: 2,
//             // horizontal: 4,
//             // vertical: 1,
//             groupType: TileGroupType.large);
// }

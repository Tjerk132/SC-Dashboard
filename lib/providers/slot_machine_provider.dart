import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SlotMachineProvider with ChangeNotifier, DiagnosticableTreeMixin {
  int _count = 0;
  int get count => _count;

  void onSpin() {
    _count++;
    notifyListeners();
  }

  /// Makes `SlotMachineProvider` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('count', count));
  }
}
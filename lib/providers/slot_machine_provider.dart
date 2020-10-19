import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SlotMachineProvider with ChangeNotifier, DiagnosticableTreeMixin {

  void onSpin() {
    notifyListeners();
  }

  /// Makes `SlotMachineProvider` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }
}
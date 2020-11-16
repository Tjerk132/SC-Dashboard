import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TimeFilterProvider with ChangeNotifier, DiagnosticableTreeMixin {

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  DateTime get startDate => _startDate;
  DateTime get endDate => _endDate;

  void onSelectedDate({DateTime startDate, DateTime endDate}) {
    this._startDate = startDate ?? _startDate;
    this._endDate = endDate ?? _endDate;
    notifyListeners();
  }

  /// Makes `TimeFilterProvider` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    //tod add timeSpan property
  }
}
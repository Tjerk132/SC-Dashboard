import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/dialogs/custom_dialog.dart';

class TimeFilterProvider with ChangeNotifier, DiagnosticableTreeMixin {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  DateTime get startDate => _startDate;

  DateTime get endDate => _endDate;

  void onSelectedDate(
    BuildContext context, {
    DateTime startDate,
    DateTime endDate,
  }) {
    startDate = startDate ?? _startDate;
    endDate = endDate ?? _endDate;
    //if start is after end then end is always before start
    if (startDate.isAfter(endDate)) {
      showDialog(
        context: context,
        child: CustomDialog(
          title: "SmartClips",
          message: 'Gelieve geldige datums in te voeren',
          icon: Icons.info,
          actions: <String, Function()>{
            'oke': () async {
              Navigator.of(context).pop(true);
            }
          },
        ),
      );
      return;
    }
    else {
      this._startDate = startDate;
      this._endDate = endDate;
      notifyListeners();
    }
  }

  /// Makes `TimeFilterProvider` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<DateTime>('startDate', _startDate,
        description: 'filter startDate', defaultValue: DateTime.now()));
    properties.add(DiagnosticsProperty<DateTime>('endDate', _endDate,
        description: 'filter endDate', defaultValue: DateTime.now()));
  }
}

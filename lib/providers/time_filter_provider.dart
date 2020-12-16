import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/dialogs/custom_dialog.dart';

class TimeFilterProvider with ChangeNotifier, DiagnosticableTreeMixin {
  DateTime _start = DateTime.now();
  DateTime _end = DateTime.now();

  DateTime get start => _start;
  DateTime get end => _end;

  void onSelectedDate(
    BuildContext context, {
    DateTime start,
    DateTime end,
  }) {
    print('received filter for start=$start & end=$end');
    start = start ?? _start;
    end = end ?? _end;
    //if start is after end then end is always before start
    if (start.isAfter(end)) {
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
      this._start = start;
      this._end = end;
      notifyListeners();
    }
  }

  /// Makes `TimeFilterProvider` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<DateTime>('startDate', _start,
        description: 'filter startDate', defaultValue: DateTime.now()));
    properties.add(DiagnosticsProperty<DateTime>('endDate', _end,
        description: 'filter endDate', defaultValue: DateTime.now()));
  }
}

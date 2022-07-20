import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/dialogs/custom_dialog.dart';
import 'package:flutter_test_project/enums/time_filter_type.dart';

class TimeFilterProvider with ChangeNotifier, DiagnosticableTreeMixin {
  late DateTime _start;
  late DateTime _end;
  late TimeFilterType _type;

  DateTime get start => _start;

  DateTime get end => _end;

  TimeFilterType get type => _type;

  /// the [TimeFilterType] is necessary in case the user wants to filter
  /// for lastSession, see the [getFuture] method of [dashboard_view_tablet.dart]
  void onSelectedDate(
    BuildContext context,
    TimeFilterType? type, {
    DateTime? start,
    DateTime? end,
  }) {
    print('filtering with start: $start & end: $end');
    assert((start != null && end != null) || type == TimeFilterType.adjusted);
    _type = type ?? _type;
    if (type != TimeFilterType.adjusted) {
      start = _type.start;
      end = _type.end;
    } else {
      start ??= _start;
      end ??= _end;
    }
    //if start is after end then end is always before start
    if (start.isAfter(end)) {
      showDialog(
        context: context,
        builder: (context) {
          return CustomDialog(
            title: "SmartClips",
            message: 'Gelieve geldige datums in te voeren',
            icon: Icons.info,
            actions: <String, Function()>{
              'oké': () async {
                Navigator.of(context).pop(true);
              }
            },
          );
        },
      );
      return;
    } else {
      _start = start;
      _end = end;
      notifyListeners();
    }
  }

  /// Makes `TimeFilterProvider` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<DateTime>(
      'startDate',
      _start,
      description: 'filter startDate',
      defaultValue: DateTime.now(),
    ));
    properties.add(DiagnosticsProperty<DateTime>(
      'endDate',
      _end,
      description: 'filter endDate',
      defaultValue: DateTime.now(),
    ));
    properties.add(DiagnosticsProperty<TimeFilterType>(
      'timeFilterType',
      _type,
      description: 'the type of filter',
      defaultValue: TimeFilterType.lastWeek,
    ));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/app/locator.dart';
import 'package:flutter_test_project/enums/time_filter_type.dart';
import 'package:flutter_test_project/models/session/session.dart';
import 'package:flutter_test_project/models/skills/skill.dart';
import 'package:flutter_test_project/providers/time_filter_provider.dart';
import 'package:flutter_test_project/services/session_service.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class DashboardViewModel extends BaseViewModel {
  final SessionService _sessionService = locator<SessionService>();
  final TimeFilterType initialFilter;

  late TimeFilterProvider provider;
  late List<Session>? _sessions;

  List<Session>? get sessions => _sessions;

  List<Skill> skills = [
    Skill(
      title: 'Coordinatie',
      percentage: 11.4,
      color: Colors.blue[900]!,
      icon: Icons.fitness_center,
    ),
    Skill(
      title: 'Snelheid',
      percentage: 25.1,
      color: Colors.yellow[600]!,
      icon: Icons.fitness_center,
    ),
    Skill(
      title: 'Uithoudingsvermogen',
      percentage: 55.1,
      color: Colors.brown[900]!,
      icon: Icons.fitness_center,
    ),
    Skill(
      title: 'Lenigheid',
      percentage: 15.1,
      color: Colors.orange[800]!,
      icon: Icons.fitness_center,
    ),
    Skill(
      title: 'Reactievermogen',
      percentage: 55.1,
      color: Colors.green[600]!,
      icon: Icons.fitness_center,
    ),
    Skill(
      title: 'Wendbaarheid',
      percentage: 95.1,
      color: Colors.purple[300]!,
      icon: Icons.fitness_center,
    ),
    Skill(
      title: 'Kracht',
      percentage: 15.1,
      color: Colors.red[900]!,
      icon: Icons.fitness_center,
    ),
  ];

  DashboardViewModel({
    required BuildContext context,
    required int crossAxisCount,
    required this.initialFilter,
  }) {
    _sessionService.crossAxisCount = crossAxisCount;

    provider = context.read<TimeFilterProvider>();
    provider.addListener(providerCallback);
    _sessions = this.getSessions(byProvider: false);
    notifyListeners();
  }

  void providerCallback() {
    _sessions = this.getSessions(byProvider: true);
    notifyListeners();
  }

  List<Session> getSessions({bool byProvider = true}) {
    if ((byProvider ? provider.type : initialFilter) ==
        TimeFilterType.lastSession) {
      return _sessionService.lastSession();
    } else
      return _sessionService.sessionsByDate(
        start: byProvider ? provider.start : initialFilter.start,
        end: byProvider ? provider.end : initialFilter.end,
      );
  }

  @override
  void dispose() {
    provider.removeListener(providerCallback);
    super.dispose();
  }
}

// import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test_project/providers/time_filter_provider.dart';
import 'package:flutter_test_project/services/group_type_service.dart';
import 'package:flutter_test_project/services/session_service.dart';
import 'package:flutter_test_project/views/dashboard/dashboard_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'app/locator.dart';

Future<void> main() async {
  setupLocator();

  Intl.defaultLocale = 'nl';
  runApp(
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) {
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TimeFilterProvider(),
        ),
      ],
      child: App(),
    ),
    // },
    // ),
  );
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  final SessionService _sessionService = locator<SessionService>();
  final GroupTypeService _groupTypeService = locator<GroupTypeService>();

  @override
  void initState() {
    super.initState();
    this.loadData();
  }

  void loadData() async {
    await _sessionService.initialize();
  }

  final List<Locale> locales = const [
    Locale('nl', 'NL'),
    Locale('en', 'US'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: locales,
      title: 'SmartClips Dashboard',
      theme: ThemeData(
        // brightness: Brightness.dark,
        // primaryColor: Color(0xff13d38e),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // locale: DevicePreview.locale(context),
      // builder: DevicePreview.appBuilder,
      // navigatorKey: StackedService.navigatorKey,
      // onGenerateRoute: StackedRouter().onGenerateRoute,
      home: DashboardView(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/models/app_state/log_state.dart';
import 'package:studyme/ui/dashboard/dashboard.dart';
import 'package:studyme/ui/editor/measure_library_screen.dart';
import 'package:studyme/ui/editor/trial_creator/trial_creator.dart';

void main() async {
  await Hive.initFlutter();
  var logsBox = await Hive.openBox('logs');
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AppState>(
      create: (context) => AppState(),
    ),
    ChangeNotifierProvider<LogState>(
      create: (context) => LogState(box: logsBox),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Study Me',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => TrialCreator(),
          '/measure_library': (context) => MeasureLibraryScreen(),
          '/dashboard': (context) => Dashboard(),
        });
  }
}

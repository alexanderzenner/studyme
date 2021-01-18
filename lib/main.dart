import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/ui/dashboard/dashboard.dart';
import 'package:studyme/ui/editor/measure_library_screen.dart';
import 'package:studyme/ui/editor/trial_creator/trial_creator.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  _initHive();
  runApp(
    ChangeNotifierProvider<AppState>(
      create: (context) => AppState(),
      child: MyApp(),
    ),
  );
}

Future _initHive() async {
  final dir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
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

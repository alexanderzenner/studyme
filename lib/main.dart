import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/ui/creation_custom/measure_overview_screen.dart';
import 'package:studyme/ui/creation_custom/set_a_screen.dart';
import 'package:studyme/ui/creation_custom/set_b_screen.dart';
import 'package:studyme/ui/creation_guided/1_set_outcome.dart';
import 'package:studyme/ui/creation_guided/2_set_current_intervention.dart';
import 'package:studyme/ui/welcome_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider<AppState>(
      create: (context) => AppState(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Study Me',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.green,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => WelcomeScreen(),
          '/1_set_outcome': (context) => SetOutcomePage(),
          '/2_set_start': (context) => SetCurrentIntervention(),
          '/set_a': (context) => SetAScreen(),
          '/set_b': (context) => SetInterventionScreen(),
          '/measure_overview': (context) => MeasureOverviewScreen(),
        });
  }
}

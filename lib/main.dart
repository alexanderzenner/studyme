import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/models/app_state/log_state.dart';
import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/models/intervention/no_intervention.dart';
import 'package:studyme/models/measure/choice.dart';
import 'package:studyme/models/measure/free_measure.dart';
import 'package:studyme/models/measure/scale_measure.dart';
import 'package:studyme/models/trial.dart';
import 'package:studyme/models/trial_schedule.dart';
import 'package:studyme/ui/dashboard/dashboard.dart';
import 'package:studyme/ui/editor/measure_library_screen.dart';
import 'package:studyme/ui/editor/trial_creator/trial_creator.dart';

import 'models/measure/choice_measure.dart';

void main() async {
  await Hive.initFlutter();
  _registerHiveAdapters();
  var app_data_box = await Hive.openBox('app_data');
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AppState>(
      create: (context) => AppState(box: app_data_box),
    ),
    ChangeNotifierProvider<LogState>(
      create: (context) => LogState(),
    )
  ], child: MyApp()));
}

_registerHiveAdapters() {
  Hive.registerAdapter<Trial>(TrialAdapter());
  Hive.registerAdapter<TrialSchedule>(TrialScheduleAdapter());
  Hive.registerAdapter<PhaseOrder>(PhaseOrderAdapter());

  Hive.registerAdapter<NoIntervention>(NoInterventionAdapter());
  Hive.registerAdapter<Intervention>(InterventionAdapter());

  Hive.registerAdapter<FreeMeasure>(FreeMeasureAdapter());
  Hive.registerAdapter<Choice>(ChoiceAdapter());
  Hive.registerAdapter<ChoiceMeasure>(ChoiceMeasureAdapter());
  Hive.registerAdapter<ScaleMeasure>(ScaleMeasureAdapter());
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

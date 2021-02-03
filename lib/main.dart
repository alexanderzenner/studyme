import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/app_state/log_data.dart';
import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/models/intervention/no_intervention.dart';
import 'package:studyme/models/log/measure_log.dart';
import 'package:studyme/models/measure/choice.dart';
import 'package:studyme/models/measure/free_measure.dart';
import 'package:studyme/models/measure/scale_measure.dart';
import 'package:studyme/models/measure/synced_measure.dart';
import 'package:studyme/models/reminder.dart';
import 'package:studyme/models/trial.dart';
import 'package:studyme/models/trial_schedule.dart';
import 'package:studyme/routes.dart';
import 'package:studyme/ui/screens/onboarding.dart';
import 'package:studyme/ui/screens/init.dart';

import 'models/app_state/app_state.dart';
import 'models/measure/choice_measure.dart';
import 'ui/screens/dashboard.dart';
import 'ui/screens/measure_library.dart';
import 'ui/screens/creator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _setupHive();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AppData>(
      create: (context) => AppData(),
    ),
    ChangeNotifierProvider<LogData>(
      create: (context) => LogData(),
    )
  ], child: MyApp()));
}

_setupHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter<AppState>(AppStateAdapter());

  Hive.registerAdapter<Trial>(TrialAdapter());
  Hive.registerAdapter<TrialSchedule>(TrialScheduleAdapter());
  Hive.registerAdapter<PhaseOrder>(PhaseOrderAdapter());

  Hive.registerAdapter<NoIntervention>(NoInterventionAdapter());
  Hive.registerAdapter<Intervention>(InterventionAdapter());

  Hive.registerAdapter<FreeMeasure>(FreeMeasureAdapter());
  Hive.registerAdapter<Choice>(ChoiceAdapter());
  Hive.registerAdapter<ChoiceMeasure>(ChoiceMeasureAdapter());
  Hive.registerAdapter<ScaleMeasure>(ScaleMeasureAdapter());
  Hive.registerAdapter<SyncedMeasure>(SyncedMeasureAdapter());

  Hive.registerAdapter<Reminder>(ReminderAdapter());

  Hive.registerAdapter<MeasureLog>(MeasureLogAdapter());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Study Me',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        initialRoute: Routes.init,
        routes: {
          Routes.init: (context) => Init(),
          Routes.onboarding: (context) => Onboarding(),
          Routes.creator: (context) => Creator(),
          Routes.measure_library: (context) => MeasureLibrary(),
          Routes.dashboard: (context) => Dashboard(),
        });
  }
}

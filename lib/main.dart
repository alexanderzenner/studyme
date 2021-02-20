import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/log/completed_task_log.dart';

import 'models/app_state/app_data.dart';
import 'models/app_state/app_state.dart';
import 'models/app_state/log_data.dart';
import 'models/intervention/intervention.dart';
import 'models/intervention/no_intervention.dart';
import 'models/log/trial_log.dart';
import 'models/measure/aggregations.dart';
import 'models/measure/choice.dart';
import 'models/measure/choice_measure.dart';
import 'models/measure/free_measure.dart';
import 'models/measure/scale_measure.dart';
import 'models/measure/synced_measure.dart';
import 'models/schedule.dart';
import 'models/schedule/phase_order.dart';
import 'models/schedule/trial_phases.dart';
import 'models/trial.dart';
import 'routes.dart';
import 'ui/screens/creator.dart';
import 'ui/screens/dashboard.dart';
import 'ui/screens/init.dart';
import 'ui/screens/measure_library.dart';
import 'ui/screens/onboarding.dart';

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
  Hive.registerAdapter<TrialPhases>(TrialPhasesAdapter());
  Hive.registerAdapter<PhaseOrder>(PhaseOrderAdapter());

  Hive.registerAdapter<Schedule>(ScheduleAdapter());
  Hive.registerAdapter<NoIntervention>(NoInterventionAdapter());
  Hive.registerAdapter<Intervention>(InterventionAdapter());

  Hive.registerAdapter<ValueAggregation>(ValueAggregationAdapter());
  Hive.registerAdapter<FreeMeasure>(FreeMeasureAdapter());
  Hive.registerAdapter<Choice>(ChoiceAdapter());
  Hive.registerAdapter<ChoiceMeasure>(ChoiceMeasureAdapter());
  Hive.registerAdapter<ScaleMeasure>(ScaleMeasureAdapter());
  Hive.registerAdapter<SyncedMeasure>(SyncedMeasureAdapter());

  Hive.registerAdapter<TrialLog>(TrialLogAdapter());
  Hive.registerAdapter<CompletedTaskLog>(CompletedTaskLogAdapter());
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

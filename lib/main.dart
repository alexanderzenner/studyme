import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/log/completed_task_log.dart';
import 'package:studyme/models/outcome.dart';
import 'package:studyme/ui/screens/creator_1_details.dart';

import 'models/app_state/app_data.dart';
import 'models/app_state/app_state.dart';
import 'models/app_state/log_data.dart';
import 'models/intervention/intervention.dart';
import 'models/intervention/no_intervention.dart';
import 'models/log/trial_log.dart';
import 'models/measure/aggregations.dart';
import 'models/measure/list_item.dart';
import 'models/measure/list_measure.dart';
import 'models/measure/keyboard_measure.dart';
import 'models/measure/scale_measure.dart';
import 'models/measure/automatic_measure.dart';
import 'models/schedule.dart';
import 'models/phase_order.dart';
import 'models/trial_schedule.dart';
import 'models/trial.dart';
import 'routes.dart';
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
  Hive.registerAdapter<TrialSchedule>(TrialScheduleAdapter());
  Hive.registerAdapter<Outcome>(OutcomeAdapter());
  Hive.registerAdapter<PhaseOrder>(PhaseOrderAdapter());

  Hive.registerAdapter<Schedule>(ScheduleAdapter());
  Hive.registerAdapter<NoIntervention>(NoInterventionAdapter());
  Hive.registerAdapter<Intervention>(InterventionAdapter());

  Hive.registerAdapter<ValueAggregation>(ValueAggregationAdapter());
  Hive.registerAdapter<KeyboardMeasure>(KeyboardMeasureAdapter());
  Hive.registerAdapter<ListItem>(ListItemAdapter());
  Hive.registerAdapter<ListMeasure>(ListMeasureAdapter());
  Hive.registerAdapter<ScaleMeasure>(ScaleMeasureAdapter());
  Hive.registerAdapter<AutomaticMeasure>(AutomaticMeasureAdapter());

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
          Routes.creator: (context) => CreatorDetails(),
          Routes.measure_library: (context) => MeasureLibrary(),
          Routes.dashboard: (context) => Dashboard(),
        });
  }
}

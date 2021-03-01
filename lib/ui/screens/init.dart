import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/models/app_state/log_data.dart';
import 'package:studyme/routes.dart';
import 'package:studyme/util/health_connector.dart';

class Init extends StatefulWidget {
  @override
  _InitState createState() => _InitState();
}

class _InitState extends State<Init> {
  @override
  Widget build(BuildContext context) {
    _initAppState();
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  _initAppState() async {
    // first make sure app data is fetched from box
    await Provider.of<AppData>(context, listen: false).loadAppState();
    AppData appData = Provider.of<AppData>(context, listen: false);
    AppState state = appData.state;
    if (state == AppState.ONBOARDING) {
      Navigator.pushReplacementNamed(context, Routes.onboarding);
    } else if (state == AppState.CREATING_DETAILS ||
        state == AppState.CREATING_PHASES) {
      Navigator.pushReplacementNamed(context, Routes.creator);
    } else if (state == AppState.DOING) {
      // sync measures
      HealthConnector().syncMeasures(
          appData.trial,
          Provider.of<LogData>(context, listen: false)
              .checkForDuplicatesAndAdd);
      // schedule notifications for next day
      appData.scheduleNotificationsFor(DateTime.now().add(Duration(days: 1)));
      Navigator.pushReplacementNamed(context, Routes.dashboard);
    }
  }
}

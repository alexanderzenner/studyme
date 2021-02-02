import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/routes.dart';

class InitialLoading extends StatefulWidget {
  @override
  _InitialLoadingState createState() => _InitialLoadingState();
}

class _InitialLoadingState extends State<InitialLoading> {
  initAppState() async {
    await Provider.of<AppData>(context, listen: false).loadAppState();
    AppState state = Provider.of<AppData>(context, listen: false).state;
    if (state == AppState.CREATING) {
      Navigator.pushReplacementNamed(context, Routes.creator);
    } else if (state == AppState.DOING) {
      Navigator.pushReplacementNamed(context, Routes.dashboard);
    } else if (state == AppState.ONBOARDING) {
      Navigator.pushReplacementNamed(context, Routes.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    initAppState();
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

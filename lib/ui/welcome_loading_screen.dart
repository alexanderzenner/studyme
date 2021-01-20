import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/routes.dart';

class WelcomeLoadingScreen extends StatefulWidget {
  @override
  _WelcomeLoadingScreenState createState() => _WelcomeLoadingScreenState();
}

class _WelcomeLoadingScreenState extends State<WelcomeLoadingScreen> {
  initAppState() async {
    await Provider.of<AppState>(context, listen: false).loadAppState();
    if (Provider.of<AppState>(context, listen: false).isEditing) {
      Navigator.pushReplacementNamed(context, Routes.creator);
    } else {
      Navigator.pushReplacementNamed(context, Routes.dashboard);
    }
  }

  @override
  Widget build(BuildContext context) {
    initAppState();
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

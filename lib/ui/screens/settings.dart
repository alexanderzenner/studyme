import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/util/debug_functions.dart';

import '../../routes.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          ButtonBar(
            children: [
              OutlineButton.icon(
                icon: Icon(Icons.edit),
                label: Text("Edit Trial"),
                onPressed: () => _editTrial(context),
              ),
              OutlineButton.icon(
                icon: Icon(Icons.cancel),
                label: Text("Cancel Trial"),
                onPressed: () => _cancelTrial(context),
              )
            ],
          )
        ],
      ),
    );
  }

  _editTrial(BuildContext context) async {
    debugCancelAllNotifications();
    deleteLogs(Provider.of<AppData>(context, listen: false).trial);
    Provider.of<AppData>(context, listen: false)
        .saveAppState(AppState.CREATING);
    Navigator.pushReplacementNamed(context, Routes.onboarding);
  }

  _cancelTrial(BuildContext context) async {
    bool _confirmed = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Cancel trial"),
              actions: [
                FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel")),
                FlatButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text("Confirm"))
              ],
            ));

    if (_confirmed != null && _confirmed) {
      debugCancelAllNotifications();
      deleteLogs(Provider.of<AppData>(context, listen: false).trial);
      Provider.of<AppData>(context, listen: false).createNewTrial();
      Navigator.pushReplacementNamed(context, Routes.onboarding);
    }
  }

}

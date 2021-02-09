import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/app_state/app_state.dart';

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
                onPressed: () {
                  Provider.of<AppData>(context, listen: false)
                      .debugCancelAllNotifications();
                  Provider.of<AppData>(context, listen: false)
                      .saveAppState(AppState.CREATING);
                  Navigator.pushReplacementNamed(context, Routes.onboarding);
                },
              ),
              OutlineButton.icon(
                icon: Icon(Icons.cancel),
                label: Text("Cancel Trial"),
                onPressed: () => _cancel(context),
              )
            ],
          )
        ],
      ),
    );
  }

  _cancel(BuildContext context) async {
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
      Provider.of<AppData>(context, listen: false)
          .debugCancelAllNotifications();
      Provider.of<AppData>(context, listen: false).createNewTrial();
      Navigator.pushReplacementNamed(context, Routes.onboarding);
    }
  }
}

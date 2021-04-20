import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/ui/widgets/choice_card.dart';
import 'package:studyme/util/debug_functions.dart';

import '../../routes.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool createFreshExperiment;

  @override
  Widget build(BuildContext context) {
    bool _lastTrialHasEnded = DateTime.now()
        .isAfter(Provider.of<AppData>(context, listen: false).trial.endDate);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Create new experiment',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).primaryColor)),
          ChoiceCard(
              value: false,
              selectedValue: createFreshExperiment,
              onSelect: (value) {
                setState(() {
                  createFreshExperiment = value;
                });
              },
              title: Text('Based on current experiment'),
              body: [
                Text(
                    'The details of your current experiment are kept and you can edit and use them in your next experiment')
              ]),
          ChoiceCard(
              value: true,
              selectedValue: createFreshExperiment,
              onSelect: (value) {
                setState(() {
                  createFreshExperiment = value;
                });
              },
              title: Text('Start Fresh'),
              body: [
                Text(
                    'The app will be reset and you can start creating a new experiment.')
              ]),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              OutlinedButton.icon(
                icon: Icon(Icons.check),
                label: Text(_lastTrialHasEnded
                    ? "Create new Experiment"
                    : "Abort and create new Experiment"),
                onPressed: createFreshExperiment != null
                    ? () => _editTrial(context)
                    : null,
              )
            ],
          ),
        ],
      ),
    );
  }

  _editTrial(BuildContext context) async {
    bool _confirmed = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Create new Experiment"),
              content: Text(
                  'Are you sure you want to abort and create a new experiment' +
                      (createFreshExperiment == true
                          ? ' starting fresh'
                          : ' based on your current experiment') +
                      '?'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel")),
                TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text("Confirm"))
              ],
            ));

    if (_confirmed != null && _confirmed) {
      _resetNotificationsAndLogs(context);
      Provider.of<AppData>(context, listen: false)
          .saveAppState(AppState.CREATING_DETAILS);
      if (createFreshExperiment == true) {
        Provider.of<AppData>(context, listen: false).createNewTrial();
      }
      Navigator.pushReplacementNamed(context, Routes.creator);
    }
  }

  _resetNotificationsAndLogs(BuildContext context) {
    Provider.of<AppData>(context, listen: false).cancelAllNotifications();
    deleteLogs(Provider.of<AppData>(context, listen: false).trial);
  }
}

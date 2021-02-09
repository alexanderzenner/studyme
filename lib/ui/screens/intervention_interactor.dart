import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/log_data.dart';
import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/models/log/trial_log.dart';
import 'package:studyme/ui/widgets/save_button.dart';

class InterventionInteractor extends StatefulWidget {
  final Intervention intervention;

  InterventionInteractor(this.intervention);

  @override
  _InterventionInteractorState createState() => _InterventionInteractorState();
}

class _InterventionInteractorState extends State<InterventionInteractor> {
  bool _confirmed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text(widget.intervention.name),
        actions: <Widget>[
          SaveButton(canPress: _confirmed, onPressed: _logValue)
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              SwitchListTile(
                title: Text("I completed the intervention"),
                value: _confirmed,
                onChanged: (value) {
                  setState(() {
                    _confirmed = value;
                  });
                },
              )
            ],
          )),
    );
  }

  _logValue() {
    var log = TrialLog(widget.intervention.id, DateTime.now(), 1);
    Provider.of<LogData>(context, listen: false).addAdherenceLog(log);
    Navigator.pop(context, true);
  }
}

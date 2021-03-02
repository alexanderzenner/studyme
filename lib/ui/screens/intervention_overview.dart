import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/ui/widgets/editable_list_tile.dart';

import 'intervention_editor_name.dart';
import 'schedule_editor.dart';

class InterventionOverview extends StatefulWidget {
  final bool isPreview;
  final bool isA;
  final Intervention intervention;

  const InterventionOverview(
      {@required this.isPreview, @required this.isA, this.intervention});

  @override
  _InterventionOverviewState createState() => _InterventionOverviewState();
}

class _InterventionOverviewState extends State<InterventionOverview> {
  bool _isDeleting;

  @override
  void initState() {
    _isDeleting = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.intervention != null) {
      return _buildInterventionOverview(widget.intervention);
    } else {
      if (_isDeleting) {
        return Text('');
      } else {
        return Consumer<AppData>(builder: (context, model, child) {
          Intervention intervention =
              widget.isA ? model.trial.a : model.trial.b;
          return _buildInterventionOverview(intervention);
        });
      }
    }
  }

  Widget _buildInterventionOverview(Intervention intervention) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Text(intervention.name),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                EditableListTile(
                    title: Text("Name"),
                    subtitle: Text(intervention.name),
                    canEdit: !widget.isPreview,
                    onTap: () => _editName(intervention)),
                if (!widget.isPreview && intervention.schedule != null)
                  ListTile(
                      title: Text("Schedule"),
                      subtitle: Text(intervention.schedule.readable),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () => _editSchedule(intervention)),
                ButtonBar(
                  children: [
                    if (widget.isPreview)
                      OutlineButton.icon(
                          icon: Icon(Icons.add),
                          label: Text("Add to trial"),
                          onPressed: () {
                            _addIntervention();
                          }),
                    if (!widget.isPreview)
                      OutlineButton.icon(
                          icon: Icon(Icons.delete),
                          label: Text("Remove"),
                          onPressed: _remove),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  _addIntervention() {
    Function saveFunction = (Intervention intervention) {
      _getSetter()(intervention);
      Navigator.pushNamedAndRemoveUntil(context, '/creator', (r) => false);
    };

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScheduleEditor(
              title: widget.intervention.name,
              objectWithSchedule: widget.intervention,
              onSave: saveFunction),
        ));
  }

  _editName(intervention) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InterventionEditorName(
              isA: widget.isA,
              intervention: intervention,
              onSave: (Intervention _intervention) {
                _getSetter()(_intervention);
                Navigator.pop(context);
              },
              save: true),
        ));
  }

  _editSchedule(intervention) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScheduleEditor(
              title: intervention.name,
              objectWithSchedule: intervention,
              onSave: (Intervention _intervention) {
                _getSetter()(_intervention);
                Navigator.pop(context);
              }),
        ));
  }

  _remove() {
    setState(() {
      _isDeleting = true;
    });
    _getSetter()(null);
    Navigator.pop(context);
  }

  _getSetter() {
    return widget.isA
        ? Provider.of<AppData>(context, listen: false).setInterventionA
        : Provider.of<AppData>(context, listen: false).setInterventionB;
  }
}

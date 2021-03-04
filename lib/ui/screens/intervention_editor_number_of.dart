import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/ui/widgets/action_button.dart';
import 'package:studyme/ui/widgets/choice_card.dart';

class InterventionEditorNumberOf extends StatefulWidget {
  final int numberOfInterventions;
  final Function(int numberOfInterventions) onSave;

  InterventionEditorNumberOf({this.numberOfInterventions, this.onSave});

  @override
  _InterventionEditorNumberOfState createState() =>
      _InterventionEditorNumberOfState();
}

class _InterventionEditorNumberOfState
    extends State<InterventionEditorNumberOf> {
  int _numberOfInterventions;

  @override
  void initState() {
    _numberOfInterventions = widget.numberOfInterventions;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String interventionAName = Provider.of<AppData>(context).trial.a.name;
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          actions: <Widget>[
            ActionButton(
                icon: Icons.check,
                canPress: _canSubmit(),
                onPressed: _onSubmit),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Do you want to compare “$interventionAName” to something else?',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).primaryColor)),
                SizedBox(height: 10),
                ChoiceCard<int>(
                  value: 1,
                  selectedValue: _numberOfInterventions,
                  onSelect: _selectOption,
                  title: Text('No'),
                  body: [
                    Text(
                        'I just want to find out if “$interventionAName” helps me achieve my goal')
                  ],
                ),
                ChoiceCard<int>(
                    value: 2,
                    selectedValue: _numberOfInterventions,
                    onSelect: _selectOption,
                    title: Text('Yes'),
                    body: [
                      Text(
                          'I want to compare “$interventionAName” to something else to see which of the two options is better for achieving my goal')
                    ]),
              ],
            ),
          ),
        ));
  }

  _canSubmit() {
    return _numberOfInterventions != null;
  }

  _onSubmit() {
    widget.onSave(_numberOfInterventions);
  }

  _selectOption(int number) {
    setState(() {
      _numberOfInterventions = number;
    });
  }
}

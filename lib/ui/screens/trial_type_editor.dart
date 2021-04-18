import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/trial_type.dart';
import 'package:studyme/ui/widgets/action_button.dart';
import 'package:studyme/ui/widgets/choice_card.dart';

class TrialTypeEditor extends StatefulWidget {
  final TrialType type;
  final Function(TrialType type) onSave;

  TrialTypeEditor({this.type, this.onSave});

  @override
  _TrialTypeEditorState createState() => _TrialTypeEditorState();
}

class _TrialTypeEditorState extends State<TrialTypeEditor> {
  TrialType _type;

  @override
  void initState() {
    _type = widget.type;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String interventionAName =
        Provider.of<AppData>(context).trial.interventionA.name;
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
                ChoiceCard<TrialType>(
                  value: TrialType.Reversal,
                  selectedValue: _type,
                  onSelect: _selectOption,
                  title: Text('No'),
                  body: [
                    Text(
                        'I just want to find out if “$interventionAName” helps me achieve my goal')
                  ],
                ),
                ChoiceCard<TrialType>(
                    value: TrialType.alternativeTreatment,
                    selectedValue: _type,
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
    return _type != null;
  }

  _onSubmit() {
    widget.onSave(_type);
  }

  _selectOption(TrialType type) {
    setState(() {
      _type = type;
    });
  }
}

import 'package:flutter/material.dart';
import 'package:studyme/ui/widgets/action_button.dart';
import 'package:studyme/ui/widgets/choice_card.dart';
import 'package:studyme/ui/widgets/hint_card.dart';

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
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Interventions"),
              Visibility(
                visible: true,
                child: Text(
                  'Number of Interventions',
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ActionButton(
                icon: Icons.check,
                canPress: _canSubmit(),
                onPressed: () => widget.onSave(_numberOfInterventions)),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HintCard(
                  titleText: "Choose number of interventions",
                  body: [
                    Text('1) One Intervention',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                        "Compare one intervention to your baseline. Baseline means that you don't change anything about your existing lifestyle."),
                    Text(''),
                    Text(
                        "Example: You want to find out if drinking tea makes you more productive than you currently are.",
                        style: TextStyle(fontStyle: FontStyle.italic)),
                    Text("A: Drink tea",
                        style: TextStyle(fontStyle: FontStyle.italic)),
                    Text("B: Baseline (*do nothing*)",
                        style: TextStyle(fontStyle: FontStyle.italic)),
                    Text(''),
                    Text('2) Two Interventions',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("Compare one intervention to another intervention. "),
                    Text(''),
                    Text(
                        "Example: You want to find out if drinking tea or drinking coffee makes you more productive.",
                        style: TextStyle(fontStyle: FontStyle.italic)),
                    Text("A: Drink tea",
                        style: TextStyle(fontStyle: FontStyle.italic)),
                    Text("B: Drink coffee",
                        style: TextStyle(fontStyle: FontStyle.italic)),
                    Text(''),
                  ],
                ),
                ChoiceCard<int>(
                    value: 1,
                    selectedValue: _numberOfInterventions,
                    onSelect: _selectOption,
                    title: Text('Compare one intervention to baseline')),
                ChoiceCard<int>(
                    value: 2,
                    selectedValue: _numberOfInterventions,
                    onSelect: _selectOption,
                    title: Text('Compare two interventions')),
              ],
            ),
          ),
        ));
  }

  _canSubmit() {
    return _numberOfInterventions != null;
  }

  _selectOption(int number) {
    setState(() {
      _numberOfInterventions = number;
    });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/measure/choice.dart';
import 'package:studyme/models/measure/choice_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/ui/screens/measure_editor_aggregation.dart';

import '../widgets/action_button.dart';
import '../widgets/section_title.dart';
import 'schedule_editor.dart';

class MeasureEditorChoice extends StatefulWidget {
  final ChoiceMeasure measure;
  final Function(Measure measure) onSave;
  final bool save;

  const MeasureEditorChoice(
      {@required this.measure, @required this.onSave, @required this.save});

  @override
  _MeasureEditorChoiceState createState() => _MeasureEditorChoiceState();
}

class _MeasureEditorChoiceState extends State<MeasureEditorChoice> {
  List<Choice> _choices;
  String _editedChoice;

  @override
  void initState() {
    _choices = widget.measure.choices.toList();
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
              Text(widget.measure.title),
              Visibility(
                visible: true,
                child: Text(
                  'Choices',
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ActionButton(
                icon: widget.save ? Icons.check : Icons.arrow_forward,
                canPress: _canSubmit(),
                onPressed: _submit)
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SectionTitle("Choices",
                    isSubtitle: true,
                    action: IconButton(
                        icon: Icon(Icons.add), onPressed: _addChoice)),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _choices.length,
                    itemBuilder: (content, index) {
                      Choice choice = _choices[index];

                      return Card(
                          child: ListTile(
                        title: Text(choice.value),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _removeChoice(index),
                        ),
                      ));
                    }),
              ],
            ),
          ),
        ));
  }

  _addChoice() async {
    setState(() {
      _editedChoice = null;
    });
    bool _confirmed = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Add Choice"),
              content: TextFormField(
                autofocus: true,
                initialValue: null,
                onChanged: (text) => setState(() {
                  _editedChoice = text;
                }),
              ),
              actions: [
                FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel")),
                FlatButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text("Confirm"))
              ],
            ));
    if (_confirmed && _editedChoice != null && _editedChoice.length > 0) {
      setState(() {
        _choices.add(Choice(value: _editedChoice));
      });
    }
  }

  _removeChoice(int index) {
    setState(() {
      _choices.removeAt(index);
    });
  }

  _canSubmit() {
    return _choices.length > 0 &&
        _choices.every((element) => element.value != null);
  }

  _submit() {
    widget.measure.choices = _choices;
    widget.save
        ? widget.onSave(widget.measure)
        : Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MeasureEditorAggregation(
                  measure: widget.measure, onSave: widget.onSave, save: false),
            ));
  }
}

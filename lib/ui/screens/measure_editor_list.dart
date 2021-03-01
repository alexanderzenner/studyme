import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/measure/list_item.dart';
import 'package:studyme/models/measure/list_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/ui/screens/schedule_editor.dart';

import '../widgets/action_button.dart';

class MeasureEditorList extends StatefulWidget {
  final ListMeasure measure;
  final Function(Measure measure) onSave;
  final bool save;

  const MeasureEditorList(
      {@required this.measure, @required this.onSave, @required this.save});

  @override
  _MeasureEditorListState createState() => _MeasureEditorListState();
}

class _MeasureEditorListState extends State<MeasureEditorList> {
  List<ListItem> _choices;
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
              Text(widget.measure.name),
              Visibility(
                visible: true,
                child: Text(
                  'List Items',
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
                Text('Add the items you want your list to have',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).primaryColor)),
                SizedBox(height: 10),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _choices.length,
                    itemBuilder: (content, index) {
                      ListItem choice = _choices[index];

                      return Card(
                          child: ListTile(
                        title: Text(choice.value),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _removeChoice(index),
                        ),
                      ));
                    }),
                ButtonBar(
                  children: [
                    OutlineButton.icon(
                        icon: Icon(Icons.add),
                        label: Text('Add Item'),
                        onPressed: _addChoice),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  _addChoice() async {
    setState(() {
      _editedChoice = null;
    });
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Add Option"),
              content: TextFormField(
                autofocus: true,
                initialValue: null,
                onChanged: _updateEditedChoice,
              ),
              actions: [
                FlatButton(
                    onPressed: () {
                      _updateEditedChoice(null);
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")),
                FlatButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text("Confirm"))
              ],
            ));
    if (_editedChoice != null && _editedChoice.length > 0) {
      setState(() {
        _choices.add(ListItem(value: _editedChoice));
      });
    }
  }

  _updateEditedChoice(String value) {
    setState(() {
      _editedChoice = value;
    });
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
              builder: (context) => ScheduleEditor(
                  title: widget.measure.name,
                  objectWithSchedule: widget.measure,
                  onSave: widget.onSave),
            ));
  }
}

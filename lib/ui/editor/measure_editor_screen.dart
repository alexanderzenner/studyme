import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/measure/choice.dart';
import 'package:studyme/models/measure/choice_measure.dart';
import 'package:studyme/models/measure/free_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/measure/scale_measure.dart';
import 'package:studyme/widgets/choice_editor.dart';
import 'package:uuid/uuid.dart';

class MeasureEditorScreen extends StatefulWidget {
  final bool isCreator;
  final Measure measure;

  const MeasureEditorScreen({@required this.isCreator, @required this.measure});

  @override
  _MeasureEditorScreenState createState() => _MeasureEditorScreenState();
}

class _MeasureEditorScreenState extends State<MeasureEditorScreen> {
  Measure _measure;

  @override
  initState() {
    _measure = widget.measure.clone();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _body = _buildMeasureBody();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text((widget.isCreator ? "Create" : "Edit") + " Measure"),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              if (widget.isCreator) _buildDropDown(),
              TextFormField(
                initialValue: _measure.name,
                onChanged: (text) {
                  setState(() {
                    _measure.name = text;
                  });
                },
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                initialValue: _measure.description,
                onChanged: (text) {
                  setState(() {
                    _measure.description = text;
                  });
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              if (_body != null) _body,
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, _measure);
        },
        child: Icon(Icons.check),
        backgroundColor: Colors.green,
      ),
    );
  }

  _buildDropDown() {
    return DropdownButton<String>(
      value: _measure.type,
      onChanged: _changeMeasureType,
      items: [
        FreeMeasure.measureType,
        ChoiceMeasure.measureType,
        ScaleMeasure.measureType
      ].map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text('${value[0].toUpperCase()}${value.substring(1)}'),
        );
      }).toList(),
    );
  }

  _changeMeasureType(String type) {
    if (type != _measure.type) {
      Measure _newMeasure;
      if (type == FreeMeasure.measureType) {
        _newMeasure = FreeMeasure();
      } else if (type == ChoiceMeasure.measureType) {
        _newMeasure = ChoiceMeasure();
      } else if (type == ScaleMeasure.measureType) {
        _newMeasure = ScaleMeasure();
      }
      _newMeasure.id = Uuid().v4();
      _newMeasure.name = _measure.name;
      _newMeasure.description = _measure.description;
      setState(() {
        _measure = _newMeasure;
      });
    }
  }

  _buildMeasureBody() {
    switch (_measure.runtimeType) {
      case FreeMeasure:
        return null;
      case ChoiceMeasure:
        return _buildChoiceMeasureBody(_measure);
      case ScaleMeasure:
        return _buildScaleMeasureBody(_measure);
      default:
        return null;
    }
  }

  _buildScaleMeasureBody(ScaleMeasure measure) {
    return Column(children: [
      TextFormField(
        keyboardType: TextInputType.number,
        initialValue: measure.min.toInt().toString(),
        onChanged: (text) {
          setState(() {
            measure.min = double.parse(text);
          });
        },
        decoration: InputDecoration(labelText: 'Min'),
      ),
      TextFormField(
        keyboardType: TextInputType.number,
        initialValue: measure.max.toInt().toString(),
        onChanged: (text) {
          setState(() {
            measure.max = double.parse(text);
          });
        },
        decoration: InputDecoration(labelText: 'Max'),
      ),
    ]);
  }

  _buildChoiceMeasureBody(ChoiceMeasure measure) {
    return Column(children: [
      ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: measure.choices.length,
          itemBuilder: (content, index) {
            return ChoiceEditor(
                key: UniqueKey(),
                choice: measure.choices[index],
                index: index,
                remove: () => setState(() {
                      measure.choices.removeAt(index);
                    }));
          }),
      SizedBox(height: 20),
      OutlineButton(
          child: Text('Add Choice'),
          onPressed: () => setState(() {
                measure.choices.add(Choice());
              }))
    ]);
  }
}

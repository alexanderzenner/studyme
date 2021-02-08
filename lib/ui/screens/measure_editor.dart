import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/measure/aggregations.dart';
import 'package:studyme/models/measure/choice.dart';
import 'package:studyme/models/measure/choice_measure.dart';
import 'package:studyme/models/measure/free_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/measure/scale_measure.dart';
import 'package:studyme/ui/widgets/choice_editor.dart';
import 'package:studyme/ui/widgets/save_button.dart';
import 'package:studyme/ui/widgets/section_title.dart';
import 'package:uuid/uuid.dart';

class MeasureEditor extends StatefulWidget {
  final bool isCreator;
  final Measure measure;

  const MeasureEditor({@required this.isCreator, @required this.measure});

  @override
  _MeasureEditorState createState() => _MeasureEditorState();
}

class _MeasureEditorState extends State<MeasureEditor> {
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
          brightness: Brightness.dark,
          title: Text((widget.isCreator ? "Create" : "Edit") + " Measure"),
          actions: <Widget>[
            SaveButton(
              canPress: _canSubmit(),
              onPressed: () {
                Navigator.pop(context, _measure);
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SectionTitle("Measure"),
                if (widget.isCreator) _buildTypeDropdown(),
                TextFormField(
                  initialValue: _measure.name,
                  onChanged: _changeName,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                if (_body != null) _body,
                Divider(height: 30),
                SectionTitle("Other"),
                _buildAggregationDropdown()
              ],
            ),
          ),
        ));
  }

  _canSubmit() {
    return _measure.name != null && _measure.name.length > 0;
  }

  _changeName(text) {
    setState(() {
      _measure.name = text;
    });
  }

  _buildTypeDropdown() {
    return DropdownButtonFormField<String>(
      autofocus: true,
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
      decoration: InputDecoration(labelText: 'Type'),
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

  _buildAggregationDropdown() {
    return DropdownButtonFormField<ValueAggregation>(
      decoration: InputDecoration(labelText: 'Aggregation'),
      onChanged: _changeAggregationType,
      value: _measure.aggregation,
      items: ValueAggregation.values
          .map((aggregation) => DropdownMenuItem<ValueAggregation>(
              value: aggregation, child: Text(aggregation.readable)))
          .toList(),
    );
  }

  _changeAggregationType(ValueAggregation aggregation) {
    if (aggregation != _measure.aggregation) {
      setState(() {
        _measure.aggregation = aggregation;
      });
    }
  }

  _buildMeasureBody() {
    switch (_measure.runtimeType) {
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
      Divider(height: 30),
      SectionTitle("Scale"),
      TextFormField(
        keyboardType: TextInputType.number,
        initialValue: measure.min.toInt().toString(),
        onChanged: (text) {
          setState(() {
            measure.min = num.parse(text);
          });
        },
        decoration: InputDecoration(labelText: 'Min'),
      ),
      TextFormField(
        keyboardType: TextInputType.number,
        initialValue: measure.max.toInt().toString(),
        onChanged: (text) {
          setState(() {
            measure.max = num.parse(text);
          });
        },
        decoration: InputDecoration(labelText: 'Max'),
      ),
    ]);
  }

  _buildChoiceMeasureBody(ChoiceMeasure measure) {
    return Column(children: [
      Divider(height: 30),
      SectionTitle("Choices",
          action: IconButton(
              icon: Icon(Icons.add),
              onPressed: () => setState(() {
                    measure.choices.add(Choice());
                  }))),
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
    ]);
  }
}

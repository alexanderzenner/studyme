import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/models/intervention/intervention_schedule.dart';
import 'package:studyme/models/intervention/no_intervention.dart';
import 'package:studyme/ui/widgets/save_button.dart';
import 'package:studyme/ui/widgets/section_title.dart';

class InterventionEditor extends StatefulWidget {
  final bool isA;
  final Intervention intervention;

  const InterventionEditor({@required this.isA, @required this.intervention});

  @override
  _InterventionEditorState createState() => _InterventionEditorState();
}

class _InterventionEditorState extends State<InterventionEditor> {
  Intervention _intervention;

  Frequency _frequency;

  @override
  initState() {
    _intervention = widget.intervention.clone();
    if (_intervention.schedule != null) {
      _frequency = _intervention.schedule.frequency == 1
          ? Frequency.Daily
          : Frequency.EveryXDays;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Text(widget.isA ? "Set A" : "Set B"),
          actions: <Widget>[
            SaveButton(
                canPress: _canSubmit(),
                onPressed: () {
                  Navigator.pop(context, _intervention);
                })
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                if (!widget.isA)
                  Center(
                    child: ToggleButtons(
                      children: <Widget>[
                        Padding(
                          child: Text("No Intervention"),
                          padding: const EdgeInsets.all(10.0),
                        ),
                        Padding(
                          child: Text("Intervention"),
                          padding: const EdgeInsets.all(10.0),
                        ),
                      ],
                      onPressed: _changeInterventionType,
                      isSelected: [
                        _isNullIntervention(),
                        !_isNullIntervention()
                      ],
                    ),
                  ),
                if (!_isNullIntervention())
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionTitle("Intervention"),
                      TextFormField(
                        autofocus: _intervention.name == null,
                        initialValue: _intervention.name,
                        onChanged: _changeName,
                        decoration: InputDecoration(
                          labelText: 'Name',
                        ),
                      ),
                      Divider(height: 30),
                      SectionTitle("Schedule"),
                      _buildFrequencySelector(),
                      SizedBox(height: 20),
                      SectionTitle('Times',
                          isSubtitle: true,
                          action: IconButton(
                              icon: Icon(Icons.add), onPressed: _addTime)),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _intervention.schedule.times.length,
                          itemBuilder: (content, index) {
                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 2),
                              child: ListTile(
                                title: GestureDetector(
                                  onTap: () => _editTime(index),
                                  child: Text(_intervention
                                      .schedule.times[index].readable),
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () => _removeTime(index),
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
              ],
            ),
          ),
        ));
  }

  _buildFrequencySelector() {
    Widget _dropDown = DropdownButtonFormField<Frequency>(
      decoration: InputDecoration(
        labelText: 'Frequency',
      ),
      onChanged: _changeFrequency,
      value: _frequency,
      items: Frequency.values
          .map((value) => DropdownMenuItem<Frequency>(
              value: value, child: Text(value.readable)))
          .toList(),
    );

    if (_frequency == Frequency.Daily) {
      return _dropDown;
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: _dropDown),
          SizedBox(width: 5),
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.number,
              initialValue: _intervention.schedule.frequency.toString(),
              onChanged: _setFrequency,
            ),
          ),
          SizedBox(width: 5),
          Text("days")
        ],
      );
    }
  }

  _changeFrequency(Frequency newFrequency) {
    if (newFrequency != _frequency) {
      setState(() {
        _frequency = newFrequency;
        _intervention.schedule.frequency = newFrequency.initial;
      });
    }
  }

  _setFrequency(String text) {
    try {
      int value = text.length > 0 ? int.parse(text) : 0;
      if (value > 1) {
        _intervention.schedule.frequency = value;
      }
    } on Exception catch (_) {
      print("Invalid number");
    }
  }

  _canSubmit() {
    print(_intervention.schedule.times.length);
    return _intervention.name != null &&
        _intervention.name.length > 0 &&
        !(!(_intervention is NoIntervention) &&
            _intervention.schedule.times.length == 0);
  }

  _changeName(text) {
    setState(() {
      _intervention.name = text;
    });
  }

  _changeInterventionType(int index) {
    setState(() {
      if (index == 0) {
        _intervention = NoIntervention();
      } else if (index != 0) {
        _intervention = Intervention();
      }
    });
  }

  _isNullIntervention() {
    return _intervention is NoIntervention;
  }

  Future<void> _editTime(int index) async {
    final TimeOfDay picked = await showTimePicker(
        context: context, initialTime: _intervention.schedule.times[index]);

    if (picked != null) {
      setState(() {
        _intervention.schedule.updateTime(index, picked);
      });
    }
  }

  Future<void> _addTime() async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (picked != null) {
      setState(() {
        _intervention.schedule.addTime(picked);
      });
    }
  }

  _removeTime(int index) {
    setState(() {
      _intervention.schedule.removeTime(index);
    });
  }
}

enum Frequency { Daily, EveryXDays }

extension FrequencyExtension on Frequency {
  String get readable {
    if (this == Frequency.Daily) {
      return 'Daily';
    } else if (this == Frequency.EveryXDays) {
      return 'Every ...';
    } else {
      return null;
    }
  }

  int get initial {
    if (this == Frequency.Daily) {
      return 1;
    } else if (this == Frequency.EveryXDays) {
      return 2;
    } else {
      return null;
    }
  }
}

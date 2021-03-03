import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/mixins/has_schedule.dart';
import 'package:studyme/models/schedule.dart';
import 'package:studyme/ui/widgets/action_button.dart';
import 'package:studyme/util/notifications.dart';
import 'package:studyme/util/time_of_day_extension.dart';

class ScheduleEditor extends StatefulWidget {
  final String title;
  final HasSchedule objectWithSchedule;
  final Function onSave;

  const ScheduleEditor(
      {@required this.title,
      @required this.objectWithSchedule,
      @required this.onSave});

  @override
  _ScheduleEditorState createState() => _ScheduleEditorState();
}

class _ScheduleEditorState extends State<ScheduleEditor> {
  Frequency _frequency;
  Schedule _schedule;

  @override
  initState() {
    _schedule = widget.objectWithSchedule.schedule.clone();
    if (_schedule != null) {
      _frequency =
          _schedule.frequency == 1 ? Frequency.Daily : Frequency.EveryXDays;
    } else {
      _frequency = Frequency.Daily;
    }
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
              Text(widget.title),
              Visibility(
                visible: true,
                child: Text(
                  'Schedule',
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ActionButton(
                icon: Icons.check, canPress: _canSubmit(), onPressed: _submit),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('At what time do you want to get reminded?',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).primaryColor)),
                SizedBox(height: 10),
                _buildFrequencySelector(),
                SizedBox(height: 10),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _schedule.times.length,
                    itemBuilder: (content, index) {
                      return Card(
                        child: ListTile(
                          title: Text(_schedule.times[index].readable),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _removeTime(index),
                          ),
                        ),
                      );
                    }),
                ButtonBar(
                  children: [
                    OutlinedButton.icon(
                        icon: Icon(Icons.add),
                        label: Text("Add Time"),
                        onPressed: _addTime),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  _submit() {
    widget.objectWithSchedule.schedule = _schedule;
    widget.onSave(widget.objectWithSchedule);
  }

  _canSubmit() {
    return _schedule.times.length > 0;
  }

  _buildFrequencySelector() {
    Widget _dropDown = DropdownButtonFormField<Frequency>(
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
              initialValue: _schedule.frequency.toString(),
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
        _schedule.frequency = newFrequency.initial;
      });
    }
  }

  _setFrequency(String text) {
    try {
      int value = text.length > 0 ? int.parse(text) : 0;
      if (value > 1) {
        _schedule.frequency = value;
      }
    } on Exception catch (_) {
      print("Invalid number");
    }
  }

  Future<void> _addTime() async {
    bool hasGrantedNotificationPermissions =
        await Notifications().requestPermission();
    if (hasGrantedNotificationPermissions != false) {
      final TimeOfDay picked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay(hour: TimeOfDay.now().hour, minute: 0));

      if (picked != null) {
        setState(() {
          _schedule.addTime(picked);
        });
      }
    }
  }

  _removeTime(int index) {
    setState(() {
      _schedule.removeTime(index);
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

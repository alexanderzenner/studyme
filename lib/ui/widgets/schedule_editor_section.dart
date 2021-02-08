import 'package:flutter/material.dart';
import 'package:studyme/models/schedule.dart';
import 'package:studyme/ui/widgets/section_title.dart';

class ScheduleEditorSection extends StatefulWidget {
  final Schedule schedule;

  ScheduleEditorSection({@required this.schedule});

  @override
  _ScheduleEditorSectionState createState() => _ScheduleEditorSectionState();
}

class _ScheduleEditorSectionState extends State<ScheduleEditorSection> {
  Frequency _frequency;

  @override
  initState() {
    if (widget.schedule != null) {
      _frequency = widget.schedule.frequency == 1
          ? Frequency.Daily
          : Frequency.EveryXDays;
    } else {
      _frequency = Frequency.Daily;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle("Schedule"),
        _buildFrequencySelector(),
        SizedBox(height: 20),
        SectionTitle('Times',
            isSubtitle: true,
            action: IconButton(icon: Icon(Icons.add), onPressed: _addTime)),
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.schedule.times.length,
            itemBuilder: (content, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 2),
                child: ListTile(
                  title: GestureDetector(
                    onTap: () => _editTime(index),
                    child: Text(widget.schedule.times[index].readable),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _removeTime(index),
                  ),
                ),
              );
            }),
      ],
    );
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
              initialValue: widget.schedule.frequency.toString(),
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
        widget.schedule.frequency = newFrequency.initial;
      });
    }
  }

  _setFrequency(String text) {
    try {
      int value = text.length > 0 ? int.parse(text) : 0;
      if (value > 1) {
        widget.schedule.frequency = value;
      }
    } on Exception catch (_) {
      print("Invalid number");
    }
  }

  Future<void> _editTime(int index) async {
    final TimeOfDay picked = await showTimePicker(
        context: context, initialTime: widget.schedule.times[index]);

    if (picked != null) {
      setState(() {
        widget.schedule.updateTime(index, picked);
      });
    }
  }

  Future<void> _addTime() async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (picked != null) {
      setState(() {
        widget.schedule.addTime(picked);
      });
    }
  }

  _removeTime(int index) {
    setState(() {
      widget.schedule.removeTime(index);
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

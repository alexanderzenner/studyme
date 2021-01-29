import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/models/reminder.dart';
import 'package:studyme/ui/widgets/save_button.dart';
import 'package:weekday_selector/weekday_selector.dart';

class ReminderEditor extends StatefulWidget {
  final bool isCreator;
  final Reminder reminder;

  ReminderEditor({@required this.isCreator, @required this.reminder});

  @override
  _ReminderEditorState createState() => _ReminderEditorState();
}

class _ReminderEditorState extends State<ReminderEditor> {
  Reminder _reminder;

  @override
  void initState() {
    super.initState();
    _reminder = widget.reminder.clone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text((widget.isCreator ? "Create" : "Edit") + " Reminder"),
        actions: <Widget>[
          SaveButton(
            canPress: _canSubmit(),
            onPressed: () {
              Navigator.pop(context, _reminder);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DateTimePicker(
                initialValue: _reminder.time.format(context),
                timeLabelText: "Time",
                type: DateTimePickerType.time,
                onChanged: _changeTime),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (!widget.isCreator)
                  OutlineButton.icon(
                      icon: Icon(Icons.delete),
                      label: Text("Remove"),
                      onPressed: () {
                        _removeReminder(context);
                      }),
              ],
            )
          ],
        ),
      ),
    );
  }

  _canSubmit() {
    return true;
  }

  _changeTime(String timeString) {
    int _hour = int.parse(timeString.split(":")[0]);
    int _minute = int.parse(timeString.split(":")[1]);
    setState(() {
      _reminder.time = TimeOfDay(hour: _hour, minute: _minute);
    });
  }

  _removeReminder(context) {
    Provider.of<AppState>(context, listen: false)
        .removeReminder(widget.reminder);
    Navigator.pop(context);
  }
}

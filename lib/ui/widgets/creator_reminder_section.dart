import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/models/reminder.dart';
import 'package:studyme/ui/screens/reminder_editor.dart';
import 'package:studyme/ui/widgets/reminder_card.dart';
import 'package:studyme/ui/widgets/section_title.dart';
import 'package:studyme/util/notifications.dart';

class CreatorReminderSection extends StatelessWidget {
  final AppState model;

  CreatorReminderSection(this.model);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle('Reminders',
            action: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _createReminder(context, model);
              },
            )),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: model.trial.reminders.length,
          itemBuilder: (context, index) {
            Reminder reminder = model.trial.reminders[index];
            return ReminderCard(
                reminder: reminder,
                onTap: () {
                  _editReminder(context, model, reminder);
                });
          },
        )
      ],
    );
  }

  _createReminder(context, model) async {
    bool hasGrantedNotificationPermissions =
        await Notifications().requestPermission();
    if (hasGrantedNotificationPermissions != false) {
      Reminder _reminder =
          await _navigateToReminderEditor(context, true, Reminder());
      if (_reminder != null) {
        model.addReminder(_reminder);
      }
    }
  }

  _editReminder(context, model, reminder) async {
    Reminder _reminder =
        await _navigateToReminderEditor(context, false, reminder);
    if (_reminder != null) {
      model.updateReminder(reminder, _reminder);
    }
  }

  Future _navigateToReminderEditor(context, isCreator, reminder) async {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ReminderEditor(isCreator: isCreator, reminder: reminder),
      ),
    );
  }
}

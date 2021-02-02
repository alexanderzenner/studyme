import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/reminder.dart';
import 'package:studyme/ui/screens/reminder_editor.dart';
import 'package:studyme/ui/widgets/reminder_card.dart';
import 'package:studyme/ui/widgets/section_title.dart';
import 'package:studyme/util/notifications.dart';

class CreatorReminderSection extends StatelessWidget {
  final AppData model;

  final bool isActive;

  CreatorReminderSection(this.model, {@required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isActive ? 1.0 : 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle('Reminders',
              action: IconButton(
                icon: Icon(Icons.add),
                onPressed: isActive
                    ? () {
                        _createReminder(context, model);
                      }
                    : null,
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
      ),
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

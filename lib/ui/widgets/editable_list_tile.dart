import 'package:flutter/material.dart';

class EditableListTile extends StatelessWidget {
  final Widget title;
  final Widget subtitle;
  final bool canEdit;
  final void Function() onTap;

  EditableListTile({this.title, this.subtitle, this.canEdit, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: title,
        subtitle: subtitle,
        trailing: canEdit ? Icon(Icons.chevron_right) : null,
        onTap: canEdit ? onTap : null);
  }
}

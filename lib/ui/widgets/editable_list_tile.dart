import 'package:flutter/material.dart';

class EditableListTile extends StatelessWidget {
  final Widget title;
  final Widget subtitle;
  final bool canEdit;
  final void Function() onTap;

  EditableListTile(
      {this.title, this.subtitle, this.onTap, this.canEdit = true});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: title,
        subtitle: subtitle,
        trailing: canEdit && onTap != null ? Icon(Icons.chevron_right) : null,
        onTap: canEdit ? onTap : null);
  }
}

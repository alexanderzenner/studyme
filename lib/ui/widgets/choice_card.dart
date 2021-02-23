import 'package:flutter/material.dart';

class ChoiceCard<T> extends StatelessWidget {
  final T value;
  final Widget title;
  final T selectedValue;
  final void Function(T value) onSelect;

  ChoiceCard({this.value, this.title, this.selectedValue, this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        ListTile(
            leading: Icon(_isSelected()
                ? Icons.radio_button_checked
                : Icons.radio_button_off),
            title: title,
            onTap: () => onSelect(value)),
      ],
    ));
  }

  _isSelected() {
    return value == selectedValue;
  }
}

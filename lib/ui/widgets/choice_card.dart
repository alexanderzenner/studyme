import 'package:flutter/material.dart';

class ChoiceCard<T> extends StatelessWidget {
  final T value;
  final Widget title;
  final List<Widget> body;
  final T selectedValue;
  final void Function(T value) onSelect;

  ChoiceCard(
      {this.value, this.title, this.body, this.selectedValue, this.onSelect});

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
        if (body != null)
          Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Column(
                children: body,
              ))
      ],
    ));
  }

  _isSelected() {
    return value == selectedValue;
  }
}

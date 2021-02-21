import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final bool canPress;
  final void Function() onPressed;

  ActionButton(
      {@required this.icon, @required this.canPress, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: canPress ? Colors.white : null),
      onPressed: canPress ? () => onPressed() : null,
    );
  }
}

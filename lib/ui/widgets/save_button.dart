import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final bool canPress;
  final void Function() onPressed;

  SaveButton({@required this.canPress, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.check, color: canPress ? Colors.white : null),
      onPressed: canPress ? () => onPressed() : null,
    );
  }
}

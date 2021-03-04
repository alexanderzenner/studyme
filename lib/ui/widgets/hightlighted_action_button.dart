import 'package:flutter/material.dart';

class HighlightedActionButton extends StatelessWidget {
  final IconData icon;
  final String labelText;
  final Function() onPressed;

  HighlightedActionButton(
      {@required this.icon,
      @required this.labelText,
      @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
        icon: Icon(icon, color: Colors.white),
        label: Text(
          labelText,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        onPressed: onPressed);
  }
}

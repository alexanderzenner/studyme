import 'package:flutter/material.dart';

class ConfirmButton extends StatelessWidget {
  final IconData icon;
  final String labelText;
  final Function() onPressed;

  ConfirmButton(
      {@required this.icon,
      @required this.labelText,
      @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
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
          onPressed: onPressed),
    );
  }
}

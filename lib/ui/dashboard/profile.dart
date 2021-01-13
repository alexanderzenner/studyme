import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: OutlineButton(
        child: Text('change'),
        onPressed: () => Navigator.pushReplacementNamed(context, '/'),
      ),
    );
  }
}

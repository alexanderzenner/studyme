import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/routes.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: OutlineButton(
        child: Text('change'),
        onPressed: () {
          Provider.of<AppState>(context).saveIsEditing(true);
          Navigator.pushReplacementNamed(context, Routes.creator);
        },
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/app_state/app_state.dart';

class ScheduleSection extends StatelessWidget {
  final AppState model;

  ScheduleSection(this.model);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Schedule',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        Container(
          height: 50,
          child: Scrollbar(
            child: ListView(scrollDirection: Axis.horizontal, children: [
              Container(
                  width: 50.0,
                  margin: EdgeInsets.only(right: 10),
                  color: Colors.red,
                  child: Text('A')),
            ]),
          ),
        )
      ],
    );
  }
}

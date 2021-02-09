import 'package:flutter/material.dart';

abstract class Task {
  String title;
  String body;
  TimeOfDay time;

  Task({this.title, this.body, this.time});
}

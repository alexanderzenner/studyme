import 'package:flutter/material.dart';

class Util {
  static toast(context, text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}

class Option {
  String name;
  void Function() callback;

  Option({this.name, this.callback});
}

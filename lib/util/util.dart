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

textToIntSetter(text, setterFunction) {
  try {
    int value = text.length > 0 ? int.parse(text) : 0;
    setterFunction(value);
  } on Exception catch (_) {
    print("Invalid number");
  }
}

textToDoubleSetter(text, setterFunction) {
  try {
    double value = text.length > 0 ? double.parse(text) : 0;
    setterFunction(value);
  } on Exception catch (_) {
    print("Invalid number");
  }
}

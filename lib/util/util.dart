import 'package:flutter/material.dart';

class Util {
  static toast(context, text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}

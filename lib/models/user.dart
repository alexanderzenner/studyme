import 'package:studyme/models/trial.dart';

class User {
  int age;
  Gender gender;
  String countryCode;
  List<Trial> trialDrafts;
}

enum Gender { male, female }

import 'package:studyme/models/outcome.dart';

List<Outcome> get defaultOutcomes {
  int id = 0;
  return [
    Outcome(id: (id++).toString(), outcome: 'Reduce Back Pain'),
    Outcome(id: (id++).toString(), outcome: 'Treat Leg Cramps'),
  ];
}

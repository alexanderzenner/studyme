import 'package:studyme/models/intervention/intervention.dart';

List<Intervention> get defaultInterventions {
  int id = 0;
  return [
    Intervention(id: (id++).toString(), name: "Willow-Bark Tea"),
    Intervention(id: (id++).toString(), name: "Arnika Gel"),
    Intervention(id: (id++).toString(), name: "Warming Pad")
  ];
}

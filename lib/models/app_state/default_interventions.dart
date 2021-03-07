import 'package:studyme/models/intervention.dart';

List<Intervention> get defaultInterventions {
  return [
    Intervention(
      id: 'go_for_walk',
      name: "Go for a 30min walk",
    ),
    Intervention(
      id: 'drink_tea',
      name: "Drink one cup of tea",
    ),
    Intervention(
      id: 'meditate',
      name: "Meditate for 15min",
    ),
    Intervention(
      id: 'shower',
      name: "Take a hot shower",
    ),
  ];
}

import 'package:studyme/models/intervention.dart';

List<Intervention> get defaultInterventions {
  return [
    Intervention(
      id: 'go_for_walk',
      name: 'Short walk',
      instructions: "Go for a 30min walk",
    ),
    Intervention(
      id: 'drink_tea',
      name: 'Tea',
      instructions: "Drink one cup of tea",
    ),
    Intervention(
      id: 'meditate',
      name: "Meditation",
      instructions: "Meditate for 15min",
    ),
    Intervention(
      id: 'shower',
      name: "Hot shower",
      instructions: "Take a hot shower",
    ),
  ];
}

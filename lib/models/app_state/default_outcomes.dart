import 'package:studyme/models/outcome.dart';

import '../intervention.dart';

List<Outcome> get defaultOutcomes {
  return [
    Outcome(
        id: 'back_pain',
        outcome: 'Reduce Back Pain',
        suggestedInterventions: [
          Intervention(
            id: 'willow_bark_tea',
            name: "Drink willow bark tea",
            description:
                "Willow bark contains powerful anti-inflamatory compunds such as flavonoids and salicin that help relieve pain.",
            instructions: "Drink one cup of Willow-Bark tea.",
          ),
          Intervention(
              id: 'arnika_gel',
              name: "Apply Arnica gel",
              description:
                  "Arnica gel has been proven to soothe muscle soreness, strain and reduce swelling when rubbed on the affected area.",
              instructions:
                  "Apply a dime sized amount of Arnica gel to your lower back and massage for 10 mins."),
          Intervention(
              id: 'warming_pad',
              name: "Apply warming pad",
              description:
                  "Applying a warming pad is a quick and easy way to soothe sore muscles and joints.",
              instructions: "Apply warming pad to lower back for 5 minutes."),
        ]),
    Outcome(
        id: 'leg_cramps',
        outcome: 'Treat Leg Cramps',
        suggestedInterventions: [
          Intervention(
              id: 'magnesium',
              name: "Take Magnesium",
              description:
                  "There is some evidence that leg cramps can be reduced with additional magnesium intake.",
              instructions: "Take a pill of 150-400mg Magnesium."),
          Intervention(
              id: 'vitamin_b12',
              name: "Take Vitamin B12",
              description:
                  "There is some evidence that leg cramps can be reduced with additional vitamin B12 intake.",
              instructions: "Take a pill of 200µg vitamin B12."),
          Intervention(
              id: 'massage',
              name: "Massage affected muscles",
              description:
                  "Leg cramps can sometimes be reduced by regular massage of affected muscles.",
              instructions:
                  "Apply 5 minutes of smooth massage movements to your affected legs.")
        ]),
    Outcome(
        id: 'rheumathoid_arthritis',
        outcome: 'Treat Rheumathoid Arthritis',
        suggestedInterventions: [
          Intervention(
              id: 'omega_3',
              name: "Take omega-3 supplement",
              description:
                  "Omega-3 supplement has been proven to help Rheumathoid Arthritis related joint pains.",
              instructions: "Take one dose of omega-3 supplement."),
          Intervention(
              id: 'olive_oil',
              name: "Massage with olive oil",
              description:
                  "Massaging olive oil reduces inflammation and stiffness of joints.",
              instructions:
                  "Massage your painful joints with olive oil for 15 minutes."),
          Intervention(
              id: 'cold_patch',
              name: "Apply cold patch",
              description: "Applying a cold patch can reduce joint pain.",
              instructions:
                  "Apply a cold patch to the affected joints for 15 minutes."),
        ]),
    Outcome(
        id: 'irritable_bowel_syndrome',
        outcome: 'Treat Irritable Bowel Syndrome',
        suggestedInterventions: [
          Intervention(
              id: 'gluten_free_diet',
              name: "Follow gluten-free diet",
              description:
                  "Avoiding gluten might help with gastrointestinal complaints.",
              instructions: "Avoid all foods containing gluten today."),
          Intervention(
              id: 'fructose_free_diet',
              name: "Follow fructose-free diet",
              description:
                  "Avoiding fructose might help with gastrointestinal complaints.",
              instructions: "Avoid all foods containing fructose today."),
          Intervention(
              id: 'low_fibre_diet',
              name: "Follow low-fibre diet",
              description:
                  "Avoiding fibre might help with gastrointestinal complaints.",
              instructions: "Avoid all foods containing a lot of fibre."),
        ]),
  ];
}

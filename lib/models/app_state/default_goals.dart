import 'package:studyme/models/goal.dart';

import '../intervention.dart';

List<Goal> get defaultGoals {
  return [
    Goal(id: 'back_pain', goal: 'Reduce Back Pain', suggestedInterventions: [
      Intervention(
        id: 'willow_bark_tea',
        name: "Willow bark tea",
        description:
            "Willow bark contains powerful anti-inflamatory compunds such as flavonoids and salicin that can help relieve pain.",
        instructions: "Drink one cup of willow bark tea.",
      ),
      Intervention(
          id: 'arnika_gel',
          name: "Arnica gel",
          description:
              "Arnica gel has been proven to soothe muscle soreness, strain and reduce swelling when rubbed on the affected area.",
          instructions:
              "Apply a dime sized amount of Arnica gel to your lower back and massage for 10 mins."),
      Intervention(
          id: 'warming_pad',
          name: "Warming pad",
          description:
              "Applying a warming pad is a quick and easy way to soothe sore muscles and joints.",
          instructions: "Apply warming pad to lower back for 5 minutes."),
    ]),
    Goal(id: 'leg_cramps', goal: 'Treat Leg Cramps', suggestedInterventions: [
      Intervention(
          id: 'magnesium',
          name: "Magnesium",
          description:
              "There is some evidence that leg cramps can be reduced with additional magnesium intake.",
          instructions: "Take a pill of 150-400mg Magnesium."),
      Intervention(
          id: 'vitamin_b12',
          name: "Vitamin B12",
          description:
              "There is some evidence that leg cramps can be reduced with additional vitamin B12 intake.",
          instructions: "Take a pill of 200µg vitamin B12."),
      Intervention(
          id: 'massage',
          name: "Massage",
          description:
              "Leg cramps can sometimes be reduced by regular massage of affected muscles.",
          instructions:
              "Apply 5 minutes of smooth massage movements to your affected legs.")
    ]),
    Goal(
        id: 'rheumathoid_arthritis',
        goal: 'Treat Rheumathoid Arthritis',
        suggestedInterventions: [
          Intervention(
              id: 'omega_3',
              name: "Omega-3 supplement",
              description:
                  "Omega-3 supplement has been proven to help Rheumathoid Arthritis related joint pains.",
              instructions: "Take one dose of omega-3 supplement."),
          Intervention(
              id: 'olive_oil',
              name: "Olive oil massage",
              description:
                  "Massaging olive oil reduces inflammation and stiffness of joints.",
              instructions:
                  "Massage your painful joints with olive oil for 15 minutes."),
          Intervention(
              id: 'cold_patch',
              name: "Cold patch",
              description: "Applying a cold patch can reduce joint pain.",
              instructions:
                  "Apply a cold patch to the affected joints for 15 minutes."),
        ]),
    Goal(
        id: 'irritable_bowel_syndrome',
        goal: 'Treat Irritable Bowel Syndrome',
        suggestedInterventions: [
          Intervention(
              id: 'gluten_free_diet',
              name: "Gluten-free diet",
              description:
                  "Avoiding gluten might help with gastrointestinal complaints.",
              instructions: "Avoid all foods containing gluten today."),
          Intervention(
              id: 'fructose_free_diet',
              name: "Fructose-free diet",
              description:
                  "Avoiding fructose might help with gastrointestinal complaints.",
              instructions: "Avoid all foods containing fructose today."),
          Intervention(
              id: 'low_fibre_diet',
              name: "Low-fibre diet",
              description:
                  "Avoiding fibre might help with gastrointestinal complaints.",
              instructions: "Avoid all foods containing a lot of fibre."),
        ]),
  ];
}

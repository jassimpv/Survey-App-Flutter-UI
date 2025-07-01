import "package:flutter/material.dart";

class FoodWasteQuestionnaire extends StatefulWidget {
  const FoodWasteQuestionnaire({super.key});

  @override
  State<FoodWasteQuestionnaire> createState() => _FoodWasteQuestionnaireState();
}

class _FoodWasteQuestionnaireState extends State<FoodWasteQuestionnaire> {
  bool isWastingFood = false;
  String foodType = "";
  String kg = "";

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Food Waste Questionnaire")),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text("Are you wasting food?", style: TextStyle(fontSize: 18)),
          Switch(
            value: isWastingFood,
            onChanged: (bool value) {
              setState(() {
                isWastingFood = value;
              });
            },
          ),
          if (isWastingFood) ...<Widget>[
            const SizedBox(height: 16),
            const Text("What kind of food?", style: TextStyle(fontSize: 16)),
            TextField(
              decoration: const InputDecoration(
                hintText: "e.g. Rice, Vegetables",
              ),
              onChanged: (String value) {
                setState(() {
                  foodType = value;
                });
              },
            ),
            const SizedBox(height: 16),
            const Text("How many kg?", style: TextStyle(fontSize: 16)),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "e.g. 2.5"),
              onChanged: (String value) {
                setState(() {
                  kg = value;
                });
              },
            ),
          ],
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              // Handle submission logic here
              if (isWastingFood && (foodType.isEmpty || kg.isEmpty)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please fill all fields")),
                );
                return;
              }
              // Submit data
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Submitted!")));
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    ),
  );
}

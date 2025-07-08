import 'dart:convert';
import 'dart:developer';
import 'package:collect/models/task_card_model.dart';
import 'package:collect/views/widget/battery_indicator.dart';
import 'package:collect/views/widget/custom_app_bar.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:flutter/services.dart';
import 'package:collect/extension/survet_kit/survey_kit.dart';
import 'package:get/get.dart';

class FoodWasteQuestionnaire extends StatefulWidget {
  const FoodWasteQuestionnaire({Key? key, required this.data})
    : super(key: key);
  final TransferCardData data;

  @override
  _FoodWasteQuestionnaireState createState() => _FoodWasteQuestionnaireState();
}

class _FoodWasteQuestionnaireState extends State<FoodWasteQuestionnaire> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Align(
          alignment: Alignment.center,
          child: FutureBuilder<Task>(
            future: getSampleTask(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData &&
                  snapshot.data != null) {
                final task = snapshot.data!;
                return SurveyKitView(task: task);
              }
              return const CircularProgressIndicator.adaptive();
            },
          ),
        ),
      ),
    );
  }

  Future<Task> getSampleTask() {
    final task = NavigableTask(
      navigationRules: {
        StepIdentifier(): ConditionalNavigationRule(
          resultToStepIdentifierMapper: (String? value) {
            switch (value) {
              case 'Yes':
                return StepIdentifier(id: 'OnlyConent');
              case 'No':
                return StepIdentifier(id: 'Completion');
              default:
                return null;
            }
          },
        ),
      },
      steps: [
        InstructionStep(
          stepIdentifier: StepIdentifier(id: "1"),
          title: widget.data.restaurantName,
          text: widget.data.emirate,
        ),
        QuestionStep(
          stepIdentifier: StepIdentifier(id: "2"),
          title: 'How much food is wasted daily?',
          text:
              'Please estimate the amount of food wasted in your restaurant each day.',
          answerFormat: SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: "Less than 1 kg", value: "less_than_1kg"),
              TextChoice(text: "1-5 kg", value: "1_5kg"),
              TextChoice(text: "5-10 kg", value: "5_10kg"),
              TextChoice(text: "More than 10 kg", value: "more_than_10kg"),
            ],
          ),
        ),
        QuestionStep(
          stepIdentifier: StepIdentifier(id: "3"),
          title: 'What type of food is wasted the most?',
          text: 'Select all that apply.',
          answerFormat: MultipleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: "Vegetables", value: "vegetables"),
              TextChoice(text: "Meat", value: "meat"),
              TextChoice(text: "Bread", value: "bread"),
              TextChoice(text: "Rice", value: "rice"),
              TextChoice(text: "Other", value: "other"),
            ],
          ),
        ),
        QuestionStep(
          stepIdentifier: StepIdentifier(id: "4"),
          title: 'Main reason for food waste?',
          text: 'What is the main reason for food waste in your restaurant?',
          answerFormat: SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: "Over-preparation", value: "over_preparation"),
              TextChoice(
                text: "Customer leftovers",
                value: "customer_leftovers",
              ),
              TextChoice(
                text: "Expired ingredients",
                value: "expired_ingredients",
              ),
              TextChoice(text: "Other", value: "other"),
            ],
          ),
        ),
        QuestionStep(
          stepIdentifier: StepIdentifier(id: "5"),
          title: 'How do you dispose of food waste?',
          text: 'Select the primary method.',
          answerFormat: SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: "Thrown away", value: "thrown_away"),
              TextChoice(text: "Donated", value: "donated"),
              TextChoice(text: "Composted", value: "composted"),
              TextChoice(text: "Other", value: "other"),
            ],
          ),
        ),
        CompletionStep(
          stepIdentifier: StepIdentifier(id: "6"),
          title: 'Thank you!',
          text: 'You have finished the food waste survey.',
          buttonText: 'Submit survey',
        ),
      ],
    );

    return Future.value(task);
  }

  Future<Task> getJsonTask() async {
    final taskJson = await rootBundle.loadString('assets/example_json.json');
    final taskMap = json.decode(taskJson) as Map<String, dynamic>;

    return Task.fromJson(taskMap);
  }
}

class SurveyKitView extends StatelessWidget {
  SurveyKitView({super.key, required this.task});

  final Task task;
  final SurveyController surveyController = SurveyController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SurveyKit(
            surveyController: surveyController,
            onResult: (SurveyResult result) {},
            task: task,
            surveyProgressbarConfiguration: SurveyProgressConfiguration(
              backgroundColor: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}

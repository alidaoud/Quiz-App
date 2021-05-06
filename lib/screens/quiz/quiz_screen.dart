import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/providers/questions_state.dart';

import 'components/body.dart';

class QuizScreen extends StatelessWidget {
  static const ROUTE_NAME = "QuizScreen";

  @override
  Widget build(BuildContext context) {
    QuestionsState _qState = Get.put(QuestionsState());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // Flutter shows the back button automatically
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(onPressed: _qState.nextQuestion, child: Text("Skip")),
        ],
      ),
      body: Body(),
    );
  }
}

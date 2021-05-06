import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/providers/questions_state.dart';
import 'package:quiz_app/screens/home_screen.dart';

class ScoreScreen extends StatelessWidget {
  static const ROUTE_NAME = "ScoreScreen";
  @override
  Widget build(BuildContext context) {
    QuestionsState _qState = Get.put(QuestionsState());
    final _correctAnswers = _qState.numOfCorrectAns;
    final _questionsCount = _qState.questions.length;
    final _userName = _qState.userName;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset("assets/images/bg.svg", fit: BoxFit.fill),
          Column(
            children: [
              Spacer(flex: 3),
              Text(
                _correctAnswers == _questionsCount
                    ? "Awesome ! $_userName"
                    : _correctAnswers >= _questionsCount / 2
                        ? "Good job ! $_userName"
                        : _correctAnswers > 0
                            ? "Still far :( $_userName"
                            : "Good luck in the next time $_userName",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: kSecondaryColor),
              ),
              Spacer(),
              Text(
                "Score",
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    .copyWith(color: kSecondaryColor),
              ),
              Spacer(),
              Text(
                "${_correctAnswers * 10}/${_questionsCount * 10}",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: kSecondaryColor),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  _qState.reset();
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(kDefaultPadding * 0.75), // 15
                  margin:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  decoration: BoxDecoration(
                    gradient: kPrimaryGradient,
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Text(
                    "Try  again",
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(color: Colors.black),
                  ),
                ),
              ),
              Spacer(flex: 3),
            ],
          )
        ],
      ),
    );
  }
}

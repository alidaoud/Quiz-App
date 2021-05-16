import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/providers/questions_state.dart';
import 'package:quiz_app/screens/quiz/quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  static const ROUTE_NAME = "HomeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isLoading = false;
  set isLoading(bool loading) {
    setState(() {
      _isLoading = loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _qState = Get.put(QuestionsState());

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            IMG_BG,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(flex: 2), //2/6
                  Text(
                    "Let's Play Quiz,",
                    style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Enter your name below",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Spacer(), // 1/6
                  TextField(
                    controller: _qState.textController,
                    focusNode: _qState.focusNode,
                    onChanged: (val) => _qState.userName = val,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey,
                      hintText: "Full Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                  Spacer(), // 1/6
                  InkWell(
                    onTap: _isLoading
                        ? null
                        : () async {
                            if (_qState.textController.text.isNotEmpty) {
                              isLoading = true;
                              _qState.shuffleQuestions().then((value) {
                                isLoading = false;
                                _qState.userName = _qState.textController.text;
                                _qState.onInit();
                                Navigator.of(context)
                                    .pushNamed(QuizScreen.ROUTE_NAME);
                              }).catchError((error) {
                                isLoading = false;
                                Get.snackbar(
                                  "Error !",
                                  "an error occurred while fetching questions",
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              });
                            } else {
                              Get.snackbar(
                                "Filed is empty!",
                                "Enter your name please",
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            }
                          },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(kDefaultPadding * 0.75), // 15
                      decoration: BoxDecoration(
                        gradient: kPrimaryGradient,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: _isLoading
                          ? CircularProgressIndicator()
                          : Text(
                              "Start Quiz",
                              style: Theme.of(context)
                                  .textTheme
                                  .button
                                  .copyWith(color: Colors.black),
                            ),
                    ),
                  ),
                  Spacer(flex: 2), // it will take 2/6 spaces
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

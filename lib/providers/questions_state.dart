import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/screens/score/score_screen.dart';
import 'package:quiz_app/services/database_service.dart';

class QuestionsState extends GetxController with SingleGetTickerProviderMixin {
  final _dbService = DBService();

  AnimationController _animationController;
  Animation _animation;
  Animation get animation => this._animation;

  PageController _pageController;
  PageController get pageController => this._pageController;

  TextEditingController textController = TextEditingController();

  List<Question> _questions;
  List<Question> get questions => this._questions;
  set questions(List<Question> questions) {
    _questions = questions;
    update();
  }

  bool _isLoading = false;
  bool get isLoading => this._isLoading;
  set isLoading(bool isLoading) {
    this._isLoading = isLoading;
    update();
  }

  bool _isAnswered = false;
  bool get isAnswered => this._isAnswered;

  int _correctAns = 0;
  int get correctAns => this._correctAns;

  int _selectedAns;
  int get selectedAns => this._selectedAns;

  RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => this._questionNumber;

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => this._numOfCorrectAns;

  String _userName = "";
  String get userName => this._userName;
  set userName(String name) {
    this._userName = name;
  }

  FocusNode _focusNode;
  FocusNode get focusNode => this._focusNode;
  set focusNode(FocusNode node) {
    this._focusNode = node;
  }

  @override
  void onInit() async {
    _animationController =
        AnimationController(duration: Duration(seconds: 15), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        // update like setState
        update();
      });

    // start our animation
    // Once 60s is completed go to the next qn
    _animationController.forward().whenComplete(nextQuestion);
    _pageController = PageController();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
  }

  Future<void> shuffleQuestions() async {
    isLoading = true;
    _questions = await _dbService.getRandomQuestions();
    isLoading = false;
  }

  void checkAns(Question question, int selectedIndex) {
    // because once user press any option then it will run
    _isAnswered = true;
    _correctAns = question.answerIndex;
    _selectedAns = selectedIndex;

    if (_correctAns == _selectedAns) _numOfCorrectAns++;
    // It will stop the counter
    _animationController.stop();
    update();

    // Once user select an ans after 1s it will go to the next qn
    Future.delayed(Duration(seconds: 1), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (_questionNumber.value != _questions.length) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);

      // Reset the counter
      _animationController.reset();

      // Then start it again
      // Once timer is finish go to the next qn
      _animationController.forward().whenComplete(nextQuestion);
    } else {
      // Get package provide us simple way to naviigate another page
      Get.offAndToNamed(ScoreScreen.ROUTE_NAME);
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }

  //reset all values the to start point
  //triggred on quiz screen poped
  Future<bool> reset() async {
    _isAnswered = false;
    _correctAns = 0;
    _questionNumber = 1.obs;
    _numOfCorrectAns = 0;
    _selectedAns = 0;
    _userName = "";
    textController.text = "";
    _focusNode.unfocus();
    _animationController.reset();
    return true;
  }
}

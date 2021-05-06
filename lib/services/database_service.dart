import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/models/question.dart';

class DBService {
  static const TAG = "DBService:";
  final _dbRef = FirebaseFirestore.instance;
  static const _COL_QUESTIONS = "questions";

  static const QUIZ_QUESTIONS_COUNT = 5;
  static const QUESTIONS_COUNT = 5;

  Future<List<Question>> getRandomQuestions() async {
    print("$TAG getting questions from database..");
    // Random random = new Random();
    // int randomNumber = random.nextInt(QUESTIONS_COUNT - QUIZ_QUESTIONS_COUNT);
    int randomNumber =
        0; //todo un comment the lines above instead to retrieve random questions after adding more questions to db
    List<Question> questions;
    await _dbRef
        .collection(_COL_QUESTIONS)
        .where("id", isGreaterThanOrEqualTo: randomNumber)
        .get()
        .then((value) => questions = questionsFromSnapshot(value));
    return questions;
  }
}

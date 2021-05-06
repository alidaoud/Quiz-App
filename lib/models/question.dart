import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Question questionFromJson(String str) => Question.fromJson(json.decode(str));

String questionToJson(Question data) => json.encode(data.toJson());

List<Question> questionsFromSnapshot(QuerySnapshot snapshot) =>
    List<Question>.generate(snapshot.size,
            (index) => Question.fromJson(snapshot.docs.elementAt(index).data()))
        .toList();

class Question {
  Question({
    this.id,
    this.answerIndex,
    this.question,
    this.options,
  });

  int id;
  int answerIndex;
  String question;
  List<String> options;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        answerIndex: json["answer_index"],
        question: json["question"],
        options: List<String>.from(json["options"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "answer_index": answerIndex,
        "question": question,
        "options": List<dynamic>.from(options.map((x) => x)),
      };
}

const List sample_data = [
  {
    "id": 1,
    "question":
        "Flutter is an open-source UI software development kit created by ______",
    "options": ['Apple', 'Google', 'Facebook', 'Microsoft'],
    "answer_index": 1,
  },
  {
    "id": 2,
    "question": "When google release Flutter.",
    "options": ['Jun 2017', 'Jun 2017', 'May 2017', 'May 2018'],
    "answer_index": 2,
  },
  {
    "id": 3,
    "question": "A memory location that holds a single letter or number.",
    "options": ['Double', 'Int', 'Char', 'Word'],
    "answer_index": 2,
  },
  {
    "id": 4,
    "question": "What command do you use to output data to the screen?",
    "options": ['Cin', 'Count>>', 'Cout', 'Output>>'],
    "answer_index": 2,
  },
];

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
        answerIndex: json["answer_id"],
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

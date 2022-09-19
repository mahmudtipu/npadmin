import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../constants.dart';

class Question {
  final int id, answer;
  final String question;
  final List<String> options;

  Question({required this.id, required this.question, required this.answer, required this.options});

  factory Question.fromMap(dynamic fieldData) {
    return Question(
        id: fieldData['id'],
        answer: fieldData['answer'],
        question: fieldData['question'],
        options: fieldData['options']);
  }
}
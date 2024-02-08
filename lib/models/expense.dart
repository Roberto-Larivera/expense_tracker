import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category {
  food,
  travel,
  leisure,
  work,
}

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id; // id univoco a stringa
  // final int id; // 1,2,3,4,5
  final String title;
  final double amount; // 1,99
  final DateTime date;
  final Category category;
}

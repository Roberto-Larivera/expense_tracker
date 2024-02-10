import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

final formatted = DateFormat.yMd();

enum Category {
  food,
  travel,
  leisure,
  work,
}

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

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

  get formattedDate {
    return formatted.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (var expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}

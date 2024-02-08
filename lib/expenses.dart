import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {

  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Pizza',
      amount: 10.99,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'Shoes',
      amount: 99.99,
      date: DateTime.now(),
      category: Category.leisure,
    ),
    Expense(
      title: 'Uber',
      amount: 15.99,
      date: DateTime.now(),
      category: Category.travel,
    ),
    Expense(
      title: 'Salary',
      amount: 1000,
      date: DateTime.now(),
      category: Category.work,
    ),
  ];



  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Text('The chart'),
          Text('Expenses list...'),
        ],
      ),
    );
  }
}

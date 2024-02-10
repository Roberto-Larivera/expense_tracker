import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/expenses.dart';

///
/// Variabili globali che iniziano con la k
///
var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 95, 59, 181));

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer,
          )),
      home: const Expenses(),
    ),
  );
}

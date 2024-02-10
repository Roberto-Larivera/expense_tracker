import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final initialDate = _selectedDate != null
        ? DateTime(
            _selectedDate!.year, _selectedDate!.month, _selectedDate!.day)
        : now;
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickerDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickerDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsValid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty || amountIsValid) {
      if (Platform.isIOS) {
        showCupertinoDialog(
            context: context,
            builder: (ctx) {
              return CupertinoAlertDialog(
                title: const Text('Invalid input'),
                content: const Text('Please enter a valid title and amount'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: const Text('Okay'),
                  )
                ],
              );
            });
      } else {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Invalid input'),
            content: const Text('Please enter a valid title and amount'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('Okay'),
              )
            ],
          ),
        );
      }
      return;
    }
    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keywordSpace = MediaQuery.of(context).viewInsets.bottom;

    /// Cosi ottengo lo spazio che occupano tutti gli elementi
    /// dell'interfaccia utente che vengono aggiunti all'intefaccia dal basso.

    return LayoutBuilder(
      builder: (ctx, constraints) {
        final width = constraints.maxWidth;

        return SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, keywordSpace + 16),
              child: Column(
                children: [
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _titleController,
                            maxLength: 50,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: 'Title',
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              prefixText: '€ ',
                              labelText: 'Amount',
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    TextField(
                      controller: _titleController,
                      maxLength: 50,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                      ),
                    ),
                  if (width >= 600)
                    Row(
                      children: [
                        DropdownButton(
                            items: Category.values
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(category.name.toUpperCase()),
                                  ),
                                )
                                .toList(),
                            value: _selectedCategory,
                            onChanged: (value) {
                              if (value == null) return;
                              setState(() {
                                _selectedCategory = value;
                              });
                            }),
                        const SizedBox(height: 16),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // const Spacer(),
                              Text(_selectedDate != null
                                  ? formatted.format(_selectedDate!)
                                  : 'No date selected'),
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: const Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            // inputFormatters: [
                            //   // FilteringTextInputFormatter.digitsOnly,
                            //   FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
                            // ],
                            decoration: const InputDecoration(
                              prefixText: '€ ',
                              labelText: 'Amount',
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // const Spacer(),
                              Text(_selectedDate != null
                                  ? formatted.format(_selectedDate!)
                                  : 'No date selected'),
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: const Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  const SizedBox(height: 16),
                  if (width >= 600)
                    Row(
                      children: [
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text('Add Expense'),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        DropdownButton(
                            items: Category.values
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(category.name.toUpperCase()),
                                  ),
                                )
                                .toList(),
                            value: _selectedCategory,
                            onChanged: (value) {
                              if (value == null) return;
                              setState(() {
                                _selectedCategory = value;
                              });
                            }),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text('Add Expense'),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:expenses/models/transaction.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';

class TransactionUser extends StatefulWidget {
  @override
  _TransactionUserState createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  final _transactions = [
    Transaction(
      id: '1', 
      title: 'Box Pokemon', 
      value: 199.00, 
      date: DateTime.now()
    ),
    Transaction(
      id: '2', 
      title: 'Conta de Luz', 
      value: 100.55, 
      date: DateTime.now()
    ),
    Transaction(
      id: '1', 
      title: 'Box Pokemon', 
      value: 199.00, 
      date: DateTime.now()
    ),
    Transaction(
      id: '2', 
      title: 'Conta de Luz', 
      value: 100.55, 
      date: DateTime.now()
    ),
    Transaction(
      id: '1', 
      title: 'Box Pokemon', 
      value: 199.00, 
      date: DateTime.now()
    ),
    Transaction(
      id: '2', 
      title: 'Conta de Luz', 
      value: 100.55, 
      date: DateTime.now()
    ),
  ];

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: DateTime.now());

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionList(_transactions),
        TransactionForm(_addTransaction),
      ],
    );
  }
}

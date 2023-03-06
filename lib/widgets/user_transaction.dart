import 'package:flutter/material.dart';
import './new_transaction.dart';
import './transaction_list.dart';
import '../models/transaction.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State {
  @override

  final List<Transaction> _userTransactions = [
    Transaction(
      id: "teste",
      title: "New shoes",
      amount: 89.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: "anotherTeste",
      title: "New teste",
      amount: 99.99,
      date: DateTime.now(),
    ),
  ];

  void _addNewTransaction(String newTitle, double newAmount) {
    final newTransaction = Transaction(
        id: DateTime.now().toString(),
        title: newTitle,
        amount: newAmount,
        date: DateTime.now()
    );

    setState(() {
      return _userTransactions.add(newTransaction);
    });
  }

  Widget build(BuildContext context) {
    return (
      Column(
        children: [
          NewTransaction(_addNewTransaction),
          TransactionList(_userTransactions),
        ],
      )
    );
  }
}
import 'package:flutter/material.dart';
import './models/transaction.dart';
import './widgets/user_transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  final List<Transaction> transactions = [
    Transaction(
        id: "teste", title: "New shoes", amount: 89.99, date: DateTime.now()),
    Transaction(
        id: "anotherTeste",
        title: "New teste",
        amount: 99.99,
        date: DateTime.now()),
  ];

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text('Flutter App'),
          actions: <Widget> [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.add),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Card(
                  elevation: 3,
                  child: Text("Text placeholder!"),
                ),
              ),
              UserTransactions(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {},
        ),
      ),
    );
  }
}

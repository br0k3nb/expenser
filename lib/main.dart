import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expenser',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          titleLarge: TextStyle(
            // color: Colors.purple,
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
            fontSize: 18
          ),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyHomePage> {
  @override

  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: "teste",
    //   title: "New shoes",
    //   amount: 89.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: "anotherTeste",
    //   title: "New teste",
    //   amount: 99.99,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((element) {
      return element.date.isAfter(
          DateTime.now().subtract(
              Duration(days: 7),
          ),
        );
      }
    ).toList();
  }

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

  void _openModal(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
        );
      },
    );
  }

  Widget build(BuildContext context) {
    // print(
    //
    //   // DateFormat.E(DateTime.now().subtract(Duration(days: 1)))
    // );
    return Scaffold(
        appBar: AppBar(
          title: Text('Expenser'),
          actions: <Widget> [
            IconButton(
              onPressed: () => _openModal(context),
              icon: Icon(Icons.add),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Chart(_recentTransactions),
              // Container(
              //   width: double.infinity,
              //   // child: Card(
              //   //   elevation: 3,
              //   //   child: Text("Text placeholder!"),
              //   // ),
              // ),
              TransactionList(_userTransactions),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _openModal(context),
        ),
      );
  }
}

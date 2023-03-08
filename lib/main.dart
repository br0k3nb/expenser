import 'dart:io';

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
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          titleLarge: TextStyle(
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
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyHomePage> {
  @override

  final List<Transaction> _userTransactions = [];

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

  void _addNewTransaction(String newTitle, double newAmount, DateTime selectedDate) {
    final newTransaction = Transaction(
        id: DateTime.now().toString(),
        title: newTitle,
        amount: newAmount,
        date: selectedDate
    );

    setState(() {
      return _userTransactions.add(newTransaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
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

  bool _showChart = true;

  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isInLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text('Expenser'),
      actions: <Widget> [
        IconButton(
          onPressed: () => _openModal(context),
          icon: Icon(Icons.add),
        ),
      ],
    );

    return Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if(isInLandscape) Container(
                margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text(
                     'Show chart',
                     style: TextStyle(
                       fontSize: 16,
                     ),
                   ),
                   Switch.adaptive(
                       value: _showChart,
                       onChanged: (val) {
                         setState(() {
                           _showChart = val;
                         });
                       }
                   ),
                 ],
               )
              ),
              if(isInLandscape) _showChart ? Container(
                height: (mediaQuery.size.height - appBar.preferredSize.height
                        - mediaQuery.padding.top) * 0.65,
                child:Chart(_recentTransactions),
              ) : Container(
                height: (mediaQuery.size.height - appBar.preferredSize.height
                    - mediaQuery.padding.top) * 0.72,
                child: TransactionList(
                  _userTransactions,
                  _deleteTransaction,
                ),
              ),
              if(!isInLandscape) Container(
                height: (mediaQuery.size.height - appBar.preferredSize.height
                    - mediaQuery.padding.top) * 0.28,
                child:Chart(_recentTransactions),
              ),
              if(!isInLandscape) Container(
                height: (mediaQuery.size.height - appBar.preferredSize.height
                    - mediaQuery.padding.top) * 0.72,
                child: TransactionList(
                  _userTransactions,
                  _deleteTransaction,
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Platform.isIOS ? Container() :
        FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _openModal(context),
        ),
      );
  }
}
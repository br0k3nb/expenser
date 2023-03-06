import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  @override

  List<Transaction> userTransactions;

  TransactionList(this.userTransactions);

  Widget build(BuildContext context) {
    return (
        Container(
          height: 300,
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 4,
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.purple,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        '\$${userTransactions[index].amount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          userTransactions[index].title,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          DateFormat().format(userTransactions[index].date),
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
            itemCount: userTransactions.length,
        )
      )
    );
  }
}
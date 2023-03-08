import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  @override

  List<Transaction> userTransactions;
  Function deleteTransaction;

  TransactionList(this.userTransactions, this.deleteTransaction);

  Widget build(BuildContext context) {
    return (
        Container(
          height: 350,
          child: userTransactions.length == 0 ? Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "No transactions added yet!",
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1,
                  fontSize: 25,
                ),
              ),
              Container(
                height: 230,
                margin: EdgeInsets.fromLTRB(0, 36, 0, 0),
                child: Image.asset(
                  'assets/images/waiting.png'
                )
              )
            ]
          ) :ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                 child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('\$${userTransactions[index].amount}')
                      ),
                    ),
                  ),
                  title: Text(
                    userTransactions[index].title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(userTransactions[index].date)
                  ),
                 trailing: IconButton(
                   icon: Icon(Icons.delete),
                   color: Theme.of(context).colorScheme.error,
                   onPressed: () => deleteTransaction(userTransactions[index].id),
                 ) ,
                )
              );
            },
            itemCount: userTransactions.length,
        )
      )
    );
  }
}
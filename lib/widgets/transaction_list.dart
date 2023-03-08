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
          height: 530,
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
                )
              );
              // return Card(
              //   elevation: 4,
              //   child: Row(
              //     children: <Widget>[
              //       Container(
              //         margin: EdgeInsets.symmetric(
              //           vertical: 10,
              //           horizontal: 15,
              //         ),
              //         padding: EdgeInsets.all(8),
              //         decoration: BoxDecoration(
              //           border: Border.all(
              //             color: Theme.of(context).primaryColor,
              //             width: 1,
              //           ),
              //         ),
              //         child: Text(
              //           '\$${userTransactions[index].amount.toStringAsFixed(2)}',
              //           style: Theme.of(context).textTheme.titleLarge,
              //         ),
              //       ),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: <Widget>[
              //           Text(
              //             userTransactions[index].title,
              //             style: TextStyle(
              //                 fontSize: 17,
              //                 fontFamily: 'Quicksand',
              //                 fontWeight: FontWeight.bold
              //             ),
              //           ),
              //           Text(
              //             DateFormat().format(userTransactions[index].date),
              //             style: TextStyle(
              //                 color: Colors.grey,
              //                 fontSize: 13
              //             ),
              //           ),
              //         ],
              //       )
              //     ],
              //   ),
              // );
            },
            itemCount: userTransactions.length,
        )
      )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chart_bars.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  @override

  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));

      var totalSum = 0.0;

      for(var i = 0; i < recentTransactions.length; i++) {
        var day = recentTransactions[i].date.day;
        var month = recentTransactions[i].date.month;
        var year = recentTransactions[i].date.year;

        if(day == weekday.day && month == weekday.month && year == weekday.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {'day': DateFormat.E().format(weekday).substring(0,1), 'amount': totalSum};

    }).reversed.toList();
  }

  double get weekSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Container(
        child: Card(
          elevation: 8,
          margin: EdgeInsets.all(20),
          child: Padding(
            padding: EdgeInsets.all(13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransactionValues.map((data) {
                return Expanded(
                  child: ChartBar(
                    data['day'],
                    data['amount'],
                    weekSpending == 0 ? 0 : (data['amount'] as double) / weekSpending)
                );
              }
            ).toList()
          ),
        )
      )
    );
  }
}
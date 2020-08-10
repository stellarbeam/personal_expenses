import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chartbar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      var weekDay = DateTime.now().subtract(Duration(days: index));
      var date = DateFormat.yMd().format(weekDay);

      var totalAmount = recentTransactions
          .where((txn) => DateFormat.yMd().format(txn.date) == date)
          .fold<double>(0.0, (totalAmount, txn) => totalAmount + txn.amount);

      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalAmount,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactions.fold<double>(0.0, (totalAmount, txn) {
      return totalAmount + txn['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactions.map((grpTxn) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  dayLabel: grpTxn['day'],
                  totalSpending: grpTxn['amount'],
                  spendingProportion: (grpTxn['amount'] as double) /
                      (totalSpending + double.minPositive),
                ),
              );
            }).toList()),
      ),
    );
  }
}

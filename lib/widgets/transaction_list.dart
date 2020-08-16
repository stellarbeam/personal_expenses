import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactionList;
  final Function _deleteTransaction;

  TransactionList(this._transactionList, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _transactionList.isEmpty
          ? LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    const Text(
                      "You have no transactions!",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                );
              },
            )
          : ListView.builder(
              itemCount: _transactionList.length,
              itemBuilder: (context, index) {
                return TransactionItem(
                    transaction: _transactionList[index],
                    deleteTransaction: _deleteTransaction);
              },
            ),
    );
  }
}

import 'package:flutter/material.dart';

import 'transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 2999.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Macbook Air',
      amount: 72999.00,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Text(
              'Chart',
              textAlign: TextAlign.center,
            ),
          ),
          Column(
            children: transactions.map((txn) {
              return Card(
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        txn.amount.toString(),
                        style: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.purple,
                          width: 2,
                        ),
                      ),
                      padding: EdgeInsets.all(10),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          txn.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          txn.date.toString(),
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}

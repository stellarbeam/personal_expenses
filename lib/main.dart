import 'package:flutter/material.dart';

import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.pinkAccent,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactionList = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 29.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Macbook Air',
      amount: 899.90,
      date: DateTime.now(),
    ),
  ];

  void _addNewTransaction(String title, double amount) {
    var txn = Transaction(
      amount: amount,
      date: DateTime.now(),
      id: DateTime.now().toString(),
      title: title,
    );
    print("Adding new transaction.");
    setState(() {
      _transactionList.add(txn);
    });
  }

  void _openNewTransactionForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => NewTransaction(_addNewTransaction),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openNewTransactionForm(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Text(
                'Chart',
                textAlign: TextAlign.center,
              ),
            ),
            TransactionList(_transactionList),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openNewTransactionForm(context),
      ),
    );
  }
}

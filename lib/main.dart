import 'package:flutter/material.dart';

import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.pinkAccent,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                ),
              ),
        ),
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
  var _showChart = false;

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
      amount: 89.90,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactionList
        .where((txn) => txn.date.isAfter(
              DateTime.now().subtract(Duration(days: 7)),
            ))
        .toList();
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    var txn = Transaction(
      amount: amount,
      date: date,
      id: DateTime.now().toString(),
      title: title,
    );
    print("Adding new transaction.");
    setState(() {
      _transactionList.add(txn);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactionList.removeWhere((txn) => txn.id == id);
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
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: const Text('Personal Expenses'),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _openNewTransactionForm(context),
        )
      ],
    );

    Container getChartContainer(chartHeight) {
      return Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            chartHeight,
        child: Chart(_recentTransactions),
      );
    }

    Container getListContainer(listHeight) {
      return Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            listHeight,
        child: TransactionList(_transactionList, _deleteTransaction),
      );
    }

    List<Widget> _buildPortraitContent({
      @required chartHeight,
      @required listHeight,
    }) {
      return [
        getChartContainer(chartHeight),
        getListContainer(listHeight),
      ];
    }

    List<Widget> _buildLandscapeContent({
      @required chartHeight,
      @required listHeight,
    }) {
      return [
        Container(
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              0.15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Show chart'),
              Switch(
                value: _showChart,
                onChanged: (value) {
                  setState(() {
                    _showChart = value;
                  });
                },
              )
            ],
          ),
        ),
        _showChart
            ? getChartContainer(chartHeight)
            : getListContainer(listHeight),
      ];
    }

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: isLandscape
              ? _buildLandscapeContent(
                  chartHeight: 0.7,
                  listHeight: 0.85,
                )
              : _buildPortraitContent(
                  chartHeight: 0.3,
                  listHeight: 0.7,
                ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _openNewTransactionForm(context),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './widgets/transactions_list.dart';
import './widgets/chart.dart';
import './widgets/new_transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple)
            .copyWith(secondary: Colors.orange),
        fontFamily: 'Quicksand',
        textTheme: TextTheme(
            caption: const TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black),
        button: const TextStyle().copyWith(color: Colors.white )),

        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [

  ];

  void addTransaction(String newTitle, double newAmount, DateTime chosenDate) {
    setState(() {
      transactions.add(
        Transaction(
          title: newTitle,
          amount: newAmount,
          date: chosenDate,
          id: DateTime.now().toString(),
        ),
      );
    });
  }

  void deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((tx) => tx.id==id);
    });
  }

  void showNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              size: 30,
            ),
            onPressed: () {
              showNewTransaction(context);
            },
          ),
        ],
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Chart(transactions),
            TransactionsList(transactions,deleteTransaction),
          ],
        ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showNewTransaction(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

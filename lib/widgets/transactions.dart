import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transactions_list.dart';
import './new_transaction.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  final List<Transaction> transactions = [
    Transaction(id: 'aa', title: 'Biriyani', amount: 100, date: DateTime.now()),
    Transaction(id: 'ab', title: 'Soda', amount: 120, date: DateTime.now())
  ];

  void addTransaction(String newTitle, double newAmount) {
    setState(() {
      transactions.add(
        Transaction(
          title: newTitle,
          amount: newAmount,
          date: DateTime.now(),
          id: DateTime.now().toString(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        NewTransaction(addTransaction),
        TransactionsList(transactions),
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionsList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: transactions.isEmpty
          ? Column(
            children: [
              Text('No transactions yet'),
              SizedBox(height: 10),
              Container(height:200,child:Image.asset('assets/images/waiting.png',fit: BoxFit.fill,),),
            ],
          )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                return Card(
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).colorScheme.secondary,
                              width: 2),
                        ),
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          '\$${transactions[index].amount.toStringAsFixed(2)}',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(transactions[index].title.toString(),
                              style: Theme.of(context).textTheme.caption),
                          Text(
                            DateFormat.yMMMMEEEEd()
                                .format(transactions[index].date),
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}

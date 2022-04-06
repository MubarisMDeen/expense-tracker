import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  const TransactionsList(this.transactions, this.deleteTransaction, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
          ? Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  'No transactions yet',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            )
          : SingleChildScrollView(
              child: Container(
                height: 400,
                child: ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (ctx, index) {
                    return Card(
                      elevation: 2,
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: FittedBox(
                              child: Text(
                                '\$${transactions[index].amount.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                        ),
                        title: Text(transactions[index].title.toString(),
                            style: Theme.of(context).textTheme.caption),
                        subtitle: Text(
                          DateFormat.yMMMMEEEEd()
                              .format(transactions[index].date),
                          style: const TextStyle(color: Colors.grey),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete,
                              color: Theme.of(context).errorColor),
                          onPressed: () =>
                              deleteTransaction(transactions[index].id),
                        ),
                      ),
                    );
                  },
                ),
              ),

    );
  }
}

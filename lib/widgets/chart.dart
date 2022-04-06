import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;

  const Chart(this.transactions, {Key? key}) : super(key: key);

  List<Transaction> get recentTransactions {
    return transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var sum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (weekDay.day == recentTransactions[i].date.day &&
            weekDay.month == recentTransactions[i].date.month &&
            weekDay.year == recentTransactions[i].date.year) {
          sum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': sum
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTransactions.fold(0.0, (sum, element) {
      return sum + (element['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...groupedTransactions.map((e) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Column(
                      children: [
                        Container(height: 20,
                          child: FittedBox(
                              child: Text(
                                  '\$${(e['amount'] as double).toStringAsFixed(0)}')),
                        ),
                        Container(
                          height: 100,
                          width: 12,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromRGBO(220, 220, 220, 1),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: FractionallySizedBox(
                            heightFactor: maxSpending == 0
                                ? 0
                                : (e['amount'] as double) / maxSpending,
                            widthFactor: 1,
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        Text(e['day'].toString()),
                      ],
                    ),
                  ),
                );
              }).toList(),
              //    Text(groupedTransactions.toString()),
            ],
          ),
        ),
      ),
    );
  }
}

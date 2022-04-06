import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  const NewTransaction(this.addTransaction, {Key? key}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  DateTime? selectedDate;

  void onSubmit() {
    if(amountController.text.isEmpty){
      return;
    }
    final String inputTitle = titleController.text;
    var inputAmount = double.parse(amountController.text);
    if (inputTitle.isEmpty || inputAmount <= 0 || selectedDate == null) {
      return;
    }
    widget.addTransaction(inputTitle, inputAmount, selectedDate);
    Navigator.of(context).pop();
  }

  void openDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now()).then((pickedDate) {
          if(pickedDate == null){
            return;
          }
          setState(() {
            selectedDate = pickedDate;
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Card(
        elevation: 15,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(fontSize: 15),
                ),
                controller: titleController,
                onSubmitted: (_) {
                  onSubmit();
                },
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  labelStyle: TextStyle(fontSize: 15),
                ),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) {
                  onSubmit();
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: Text(selectedDate==null?'No date chosen!':DateFormat.yMEd().format(selectedDate!),)),
                  TextButton(
                    onPressed: openDatePicker,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: onSubmit,
                child: Text(
                  'Add Transaction',
                  style: Theme.of(context)
                      .textTheme
                      .button
                      ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.secondary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

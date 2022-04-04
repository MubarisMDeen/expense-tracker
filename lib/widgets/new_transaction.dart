import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  const NewTransaction(this.addTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void onSubmit(){
    final String inputTitle = titleController.text;
    var inputAmount = double.parse(amountController.text);
    if(inputTitle.isEmpty || inputAmount<=0){
     return;
    }
    widget.addTransaction(inputTitle,inputAmount);
    Navigator.of(context).pop();
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
                onSubmitted: (_){
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
                onSubmitted: (_){
                  onSubmit();
                },
              ),
              SizedBox(height: 13),
              TextButton(
                onPressed: onSubmit,
                child: Text(
                  'Add Transaction',
                  style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).colorScheme.secondary,fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

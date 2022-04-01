import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void onSubmit(){
    final String inputTitle = titleController.text;
    var inputAmount = double.parse(amountController.text);
    if(inputTitle.isEmpty || inputAmount<=0){
      return;
    }
    addTransaction(inputTitle,inputAmount);
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
              TextButton(
                onPressed: onSubmit,
                child: const Text(
                  'Add Transaction',
                  style: TextStyle(color: Colors.deepOrange),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

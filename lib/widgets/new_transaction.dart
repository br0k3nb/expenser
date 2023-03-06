import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  @override

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  Function pushTransaction;

  NewTransaction(this.pushTransaction);

  void submitData() {
    final titleInput = titleController.text;
    final amountInput = double.parse(amountController.text);

    if(titleInput.isEmpty || amountInput <= 0) return;

    pushTransaction(
        titleInput,
        double.parse(amountController.text)
    );
  }

  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(),
        child: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Title",
              ),
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: "Amount",
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(
                    Colors.purple
                ),
              ),
              onPressed: submitData,
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
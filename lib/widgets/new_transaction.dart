import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  @override

  final  Function pushTransaction;
  NewTransaction(this.pushTransaction);

  State<StatefulWidget> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  @override

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime _selectedDate;

  void _submitData() {
    if(_amountController.text.isEmpty) return;

    if(_selectedDate == null) {
      showDialog(
        context: context,
        builder: (BuildContext _) {
          return AlertDialog(
            title: Text(
              'Failed to submit',
            ),
            content: Text(
              'Please, select a valid date before submitting a transaction',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            actions: [
              Container(
                width: double.infinity,
                child: TextButton(
                   onPressed: () => Navigator.of(context).pop(),
                   child: Text('Close')
               ),
              )
            ],
          );
        }
      );
    }

    final titleInput = _titleController.text;
    final amountInput = double.parse(_amountController.text);

    if(titleInput.isEmpty || amountInput <= 0 || _selectedDate == null) return;

    widget.pushTransaction(
        titleInput,
        double.parse(_amountController.text),
        _selectedDate
    );

    Navigator.of(context).pop();
  }

  void _toggleDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now()
    ).then((date) {
      if(date == null) {
        return;
      }

      setState(() {
        _selectedDate = date;
      });

      print(date);
    });
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
              controller: _titleController,
              decoration: InputDecoration(
                labelText: "Title",
              ),
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: "Amount",
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 70,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _selectedDate == null ? Text("No date chosen!")
                  : Text(
                    'Picked date: ${DateFormat.yMd().format(_selectedDate)}'
                  ),
                  TextButton(
                    onPressed: _toggleDatePicker,
                    child: Text(
                      "Choose a date",
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitData,
                child: Text(
                  "Submit",
                  style: TextStyle(
                      fontSize: 14
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
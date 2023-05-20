import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

//import './user_transaction.dart';

class NewTransaction extends StatefulWidget {
  //const NewTransaction({super.key});
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titlecontroller = TextEditingController();

  final amountcontroller = TextEditingController();

  late DateTime _datePicked = DateTime.now();

  void submitData() {
    widget.addTx(titlecontroller.text, double.parse(amountcontroller.text),_datePicked);
    Navigator.of(context).pop(); //clears the pop up after we click submit
  }

  void presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100))
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        (_datePicked = value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: InputDecoration(labelText: "TITLE"),
            controller: titlecontroller,
            onSubmitted: (value) {
              submitData();
            },
            /* onChanged: (value) {
                      titleInput = value;
                    } */
          ),
          TextField(
            decoration: InputDecoration(labelText: "AMOUNT"),
            controller: amountcontroller,
            keyboardType: TextInputType.number,
            onSubmitted: (value) {
              submitData();
            },

            /* onChanged: (value) {
                      amountInput = value;
                    }, */
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _datePicked == DateTime.now()
                    ? "NO DATE CHOSEN"
                    : DateFormat.yMMMMd().format(_datePicked),
                style: TextStyle(fontSize: 18, color: Colors.blueGrey),
              ),
              OutlinedButton(
                onPressed: () {
                  presentDatePicker();
                },
                child: Text(
                  'CHOOSE DATE',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(255, 33, 160, 214),
                      //backgroundColor: Colors.amber,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          ElevatedButton(
            onPressed: () {
              submitData();
            },
            child: Text("add transaction"),
          )
        ],
      ),
    );
  }
}

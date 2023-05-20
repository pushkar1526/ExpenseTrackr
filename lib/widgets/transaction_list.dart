import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class transactionList extends StatelessWidget {
  //const transactionList({super.key});
  final Function deleteTx;
  late final List<Transaction> transactions;
  transactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context,) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.6,
        child: transactions.isEmpty
            ? Column(
                children: [
                  Text(
                    "NO TRANSACTIONS ADDED YET",
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                      height: 200,
                      child: Image.asset(
                        'assets/image/waiting.png',
                        fit: BoxFit.cover,
                      ))
                ],
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 5,
                            color: Color.fromARGB(255, 29, 129, 109))),
                    child: Card(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 50,
                          //width: 70,
                          padding: EdgeInsets.all(0),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(width: 3, color: Colors.blue)),
                          child: Center(
                            child: Text(
                              "₹" +
                                  transactions[index].amount.toStringAsFixed(2),
                              style:
                                  TextStyle(fontSize: 25, color: Colors.purple),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Text(
                                transactions[index].title,
                                style: TextStyle(
                                    fontFamily: "Quicksand",
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                DateFormat.yMMMEd()
                                    .format(transactions[index].date),
                                style: TextStyle(color: Colors.blueGrey),
                              )
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () =>deleteTx(transactions[index].id),
                          icon: Icon(Icons.delete),
                          color: Colors.red,
                        )
                      ],
                    )),
                  );
                },
                itemCount: transactions.length,
              ));
  }
}

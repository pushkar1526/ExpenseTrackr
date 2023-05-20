//import 'dart:ffi';
//import 'dart:js_util';

import 'package:expense_app/widgets/new_transaction.dart';
import 'package:expense_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';


import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

import 'models/transaction.dart';

//import './widgets/user_transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal',
      theme: ThemeData(
          primarySwatch: Colors.amber,
          fontFamily: "Quicksand",
          textTheme: ThemeData.light().textTheme.copyWith(
                titleMedium: TextStyle(
                    fontFamily: "OpenSans", fontWeight: FontWeight.bold),
              ),
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: "Quicksand",
                  fontSize: 22,
                  fontWeight: FontWeight.bold))),
      home: const MyHomePage(title: 'Personal'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //late String titleInput;
  //late String amountInput;

  final titlecontroller = TextEditingController();
  final amountcontroller = TextEditingController();

  List<Transaction> usertransaction = [
    /* Transaction(id: "t1", title: "omlette", amount: 25, date: DateTime.now()),
    Transaction(id: "t2", title: "kurkure", amount: 10, date: DateTime.now()), */
  ];

  List<Transaction> get recentTransaction{
    return usertransaction.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: chosenDate);
    setState(() {
      usertransaction.add(newTx);
    });
  }
  void deleteTransaction(String id){
    setState(() {
      usertransaction.removeWhere((element) => element.id==id);
    });
  }

  void startNewAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return NewTransaction(addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Personal_Expenses",
          
        ),
        actions: [IconButton(onPressed: () => {}, icon: Icon(Icons.add))],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: double.maxFinite,
          child: Column(
            children: <Widget>[
              Chart(recentTransaction),
              transactionList(usertransaction, deleteTransaction)
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => {startNewAddTransaction(context)},
        child: Icon(Icons.add),
      ),
    );
  }
}

import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

main() {
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final _transactions = [
    Transaction(
        id: '1', title: 'Box Pokemon', value: 199.00, date: DateTime.now()),
    Transaction(
        id: '2', title: 'Conta de Luz', value: 100.50, date: DateTime.now()),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Despesas Pessoais"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: Card(
                child: Text("Gráfico"),
              ),
            ),
            Column(
              children: _transactions.map((tr) {
                return Card(
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          )
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text("R\$ ${tr.value}")
                      ),
                      Column(
                        children: [
                          Text("${tr.title}"),
                          Text("${tr.date.toString()}"),
                        ],
                      )
                    ],
                  )
                );
              }).toList(),
            )
          ],
        ));
  }
}

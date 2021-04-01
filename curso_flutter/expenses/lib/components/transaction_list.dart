import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onDeleteTransaction;

  TransactionList(this.transactions, this.onDeleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: transactions.isEmpty
      ? Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "Nenhuma Transação Cadastrada!",
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 200,
            child: Image.asset("assets/images/waiting.png",
                fit: BoxFit.cover),
          ),
        ],
      )
      : ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          final tr = transactions[index];
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 5,
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: FittedBox(
                      child: Text("R\$ ${tr.value.toStringAsFixed(2)}")
                    ),
                ),
              ),
              title: Text(
                tr.title,
                style: Theme.of(context).textTheme.headline6,
              ),
              subtitle:
                  Text(DateFormat("d MMM y", "pt-BR").format(tr.date)),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => onDeleteTransaction(transactions[index].id),
              ),
            ),
          );
        },
      ),
    );
  }
}

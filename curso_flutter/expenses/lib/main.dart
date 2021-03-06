import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:flutter/material.dart';
import 'components/chart.dart';
import 'models/transaction.dart';

main() {
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt', 'BR'),
      ],
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.blue,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                button: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
          )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
        id: '3',
        title: 'Conta Antiga',
        value: 199.00,
        date: DateTime.now().subtract(Duration(days: 33))),
    Transaction(
        id: '1',
        title: 'Box Pokemon',
        value: 199.00,
        date: DateTime.now().subtract(Duration(days: 3))),
    Transaction(
        id: '2',
        title: 'Conta de Luz',
        value: 100.55,
        date: DateTime.now().subtract(Duration(days: 6))),
    Transaction(
        id: '4',
        title: 'Conta de ??gua',
        value: 100.55,
        date: DateTime.now().subtract(Duration(days: 4))),
    Transaction(
        id: '5',
        title: 'Conta de Internet',
        value: 100.55,
        date: DateTime.now().subtract(Duration(days: 4))),
    Transaction(
        id: '6',
        title: 'Cart??o de cr??dito',
        value: 100.55,
        date: DateTime.now().subtract(Duration(days: 2))),
    Transaction(
        id: '7',
        title: 'Compra supermercado',
        value: 100.55,
        date: DateTime.now().subtract(Duration(days: 1))),
    Transaction(
        id: '8',
        title: 'Compra camisa',
        value: 100.55,
        date: DateTime.now().subtract(Duration(days: 1))),
  ];
  final isIOS = Platform.isIOS ? true : false;
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: date);

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionModalForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  _getIconButton(IconData icon, Function fn) {
    return isIOS
        ? GestureDetector(onTap: fn, child: Icon(icon))
        : IconButton(icon: Icon(icon), onPressed: fn);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final listIcon = isIOS ? CupertinoIcons.list_bullet : Icons.list;
    final charICon = isIOS ? CupertinoIcons.chart_bar_alt_fill : Icons.show_chart;

    final actions = <Widget>[
      if (isLandscape)
        _getIconButton(
          _showChart ? listIcon : charICon,
          () {
            setState(() {
              _showChart = !_showChart;
            });
          },
        ),
      _getIconButton(
        isIOS ? CupertinoIcons.add : Icons.add,
        () => _openTransactionModalForm(context),
      )
    ];

    final PreferredSizeWidget appBar = isIOS
        ? CupertinoNavigationBar(
            middle: Text("Despesas Pessoais"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          )
        : AppBar(
            title: Text(
              "Despesas Pessoais",
              style: TextStyle(
                fontSize:
                    20 * mediaQuery.textScaleFactor, //deixa o texto responsivo
              ),
            ),
            actions: actions,
          );

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_showChart || !isLandscape)
            Container(
              height: availableHeight * (isLandscape ? 0.7 : 0.25),
              child: Chart(_recentTransactions),
            ),
          if (!_showChart || !isLandscape)
            Container(
              height: availableHeight * (isLandscape ? 1 : 0.75),
              child: TransactionList(_transactions, _deleteTransaction),
            )
        ],
      ),
    ));

    return isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _openTransactionModalForm(context),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}

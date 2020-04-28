import 'package:expenseapp/transactions_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'new_transaction.dart';
import 'transaction.dart';
import 'chart.dart';
import 'package:flutter/services.dart';

void main(){/*SystemChrome.setPreferredOrientations([
  DeviceOrientation.portraitUp,
DeviceOrientation.portraitDown
]);
to prevent Landscape mode
    you can use MediaQuery to know about the device orientation
*/

  runApp(MyApp());}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Expense App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        fontFamily: 'Georgia',
        textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            button: TextStyle(color: Colors.white)),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>  with WidgetsBindingObserver{
  final List<Transaction> userTransaction = [];
  /* Transaction(
        id: 't1', title: 'new dress', date: DateTime.now(), amount: 150),
    (Transaction(id: 't2', title: 'Cheese', date: DateTime.now(), amount: 15))*/
@override
void initState(){
  WidgetsBinding.instance.addObserver(this);
  super.initState();
}
  @override
void didchangeApplifeCycleState(AppLifecycleState){
  print(State);
  }

@override
dispose(){
  // you use it to clear that listener to lifecycle changes when that
  //that state object is not required anymore.
  WidgetsBinding.instance.removeObserver(this);
  super.dispose();
}
  List<Transaction> get recentTransaction {
    return userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }


  void _addNewTransaction(String Title, double Amount, DateTime choosenDate) {
    final newtrans = Transaction(
        title: Title,
        amount: Amount,
        date: choosenDate,
        id: DateTime.now().toString());
    setState(() {
      userTransaction.add(newtrans);
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );

        //  With this setting, you catch the tap event and
        //avoid that it's handled by anyone else
      },
    );
  }

  void _deletnetransaction(String id) {
    setState(() {
      userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  Widget _buildlandScapeContent(){}
  Widget _buildlandPortraitContent(){}
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final appbar = AppBar(
      title: Text('Expense App'),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add,
          ),
          onPressed: () => startAddNewTransaction(context),
        )
      ],
    );
    return Scaffold(
      appBar: appbar,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startAddNewTransaction(context),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                height: (MediaQuery.of(context).size.height -
                        appbar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
                    0.23,
                child: Chart(recentTransaction)),
            Container(height: (MediaQuery.of(context).size.height -
                appbar.preferredSize.height-
            MediaQuery.of(context).padding.top) *
                0.77,
                child: TransactionList(userTransaction, _deletnetransaction))
          ],
        ),
      ),
    );
  }
}

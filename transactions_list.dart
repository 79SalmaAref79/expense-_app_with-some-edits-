 import 'package:expenseapp/transaction.dart';
import 'package:flutter/material.dart';
 import 'package:intl/intl.dart';
class TransactionList extends StatelessWidget {
  final List<Transaction>transaction;
final Function deletetx;
  TransactionList(this.transaction,this.deletetx);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      transaction.isEmpty?
      Column(
        children: <Widget>[
          Text(
            'No transaction added yet !',
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: 30
            ),

          ),
          Image.asset('assets/images/img1.jpg'),
        ],
      ):ListView.builder(
        itemBuilder: (context,index){
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 7
            ),
            child: ListTile(
               leading: CircleAvatar
                 /*
                we can use container to do a circle as follows
                Container(
                height:60,
                width:60,
                decoration:BoxDecoration(
                color:Theme.of(context).primarycolor,
                shape:BoxShape.circle,
                ))
                  */
                 ( radius: 30,
                 child: Padding(
                     padding:EdgeInsets.all(5)
                     ,child: FittedBox(child: Text('\$${transaction[index].amount}'))),
               ),
              title: Text(transaction[index].title,style: TextStyle(
                fontSize: 21,
              ),),
              subtitle: Text(DateFormat.yMMMd().format(transaction[index].date)),
              trailing: MediaQuery.of(context).size.width>430?
                  FlatButton.icon(onPressed: ()=> deletetx(transaction[index].id),
                      icon: Icon(Icons.delete),
                      label: Text('delete'),
                    textColor:Theme.of(context).errorColor ,)
              :IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed:()=> deletetx(transaction[index].id),
              ),
            ),
          );
        },
        itemCount: transaction.length,

      );

  }


}

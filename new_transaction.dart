import 'package:expenseapp/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
 class NewTransaction extends StatefulWidget{
   final Function addTx;
   NewTransaction(this.addTx){
     print('Constructor new trannsaction Widget');
   }

  @override
  _NewTransactionState createState() {
    print('Create state new trannsaction Widget');
     return _NewTransactionState();}
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController =TextEditingController();
  final amountController=TextEditingController();
  DateTime _selectedDate;
  _NewTransactionState(){
    print('Constructor NewTransactionState Widget');
  }
  @override
  void initState() {
    // you can use this method to fetch some initial data you need in you app
    print('initState()');
    super.initState();
  }
  @override
  void didUpdateWidget(NewTransaction oldWidget) {
    /*(you Can Use This Method If Your parent widget And You want to refetch data in your state simply
    it called whenever the widget configuration changes)
    So if you're fetching data from a database and you received a new ID in your widget which is attached
    to the state and for that ID, you want to fetch new data, you could do this here in didUpdateWidget
    with the information that you have and the new ID */
    print('didUpdatewidget()');
    super.didUpdateWidget(oldWidget);
  }
  @override
  void dispose() {
    //you can use this widget to clean up data
    print('dispose()');
    super.dispose();
  }
   void submitData(){
     if(amountController.text.isEmpty){
       return;
     }
     final enteredTitle=titleController.text;
     final enteredAmount= double.parse(amountController.text);

     if(enteredTitle.isEmpty || enteredAmount<=0 || _selectedDate==null){
       return;}
     widget.addTx( enteredTitle,
     enteredAmount,
     _selectedDate);

     Navigator.of(context).pop();
   }
void _presentDatePicker(){
     showDatePicker(context: context,
     initialDate: DateTime.now(),
     firstDate: DateTime(2020),
     lastDate: DateTime.now(),)
     .then((pickedDate){
       if(pickedDate==null){
         return;
       }
       setState(() {
         _selectedDate=pickedDate;
       });

     });
}


  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return  Card(elevation: 10,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted:(_)=> submitData,
              // value by default is String
            ),

            TextField(decoration: InputDecoration(labelText: 'Amount'),
              controller:amountController ,
              keyboardType: TextInputType.number,
              onSubmitted:(_)=> submitData,
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(_selectedDate==null?
                    'No Date Choosen' :
                    DateFormat.yMd().format(_selectedDate),),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColorDark,

                      child: Text('Choose Date',style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    onPressed: _presentDatePicker,
                  )
                ],
              ),
            ),
            FlatButton(
              child: Text('Add Transaction',style: TextStyle(color: Colors.purple),
              ),
              onPressed: submitData,
            )
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Bars extends StatelessWidget{
  final String label;
  final double spendingAmount;
  final spendingPctTotal;
  Bars(this.label,this.spendingAmount,this.spendingPctTotal  );
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      LayoutBuilder(builder:( ctx,constrains){
        return Column(
          children: <Widget>[
            Container(
                height:constrains.maxHeight *0.15,
                child: FittedBox(child: Text('\$${spendingAmount.toStringAsFixed(0)}'))),
            SizedBox(
              height: constrains.maxHeight*0.05,
            ),
            Container(
              height: constrains.maxHeight *0.6,
              width: 10,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey,width: 1),
                      color: Color.fromRGBO(220,220 , 220, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingPctTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorDark,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: constrains.maxHeight*0.05,
            ),
            Container(height:constrains.maxHeight*0.15
                ,child: FittedBox(child: Text(label))),
          ],
        );
      });
  }

}
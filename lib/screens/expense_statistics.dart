import 'package:expense_tracker/Data/expense_data.dart';
import 'package:expense_tracker/components/expense_summary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Statistis extends StatelessWidget {
  const Statistis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(builder: (context,value,child)=>Scaffold(
        backgroundColor: Colors.grey[300],
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: ExpenseSummary(startOfWeek: value.startOfWeekDate()),
        )
    )
    );
    //ExpenseSummary(startOfWeek: value.starOfWeekDate());
  }
}

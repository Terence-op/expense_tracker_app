import 'package:expense_tracker/screens/details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../Data/expense_data.dart';

class ExpenseTile extends StatelessWidget {
  final String category;
  final String amount;
  final String des;
  final String city;
  final DateTime dateTime;

  void Function(BuildContext)? deleteTapped;

  ExpenseTile({
    super.key,
    required this.category,
    required this.amount,
    required this.des,
    required this.dateTime,
    required this.deleteTapped,
  required this.city,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          //delete button
          SlidableAction(
            onPressed: deleteTapped,
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Details(
                amount: amount,
                category: category,
                dateTime: dateTime,
                des: des,
                cityName:city,

              ),
            ),
          );
        },
        title: Text(category),
        subtitle:
            Text('${dateTime.day} / ${dateTime.month} / ${dateTime.year}'),
        trailing: Text('${Provider.of<ExpenseData>(context,listen: false).setCurrency}' + amount),
      ),
    );
  }
}

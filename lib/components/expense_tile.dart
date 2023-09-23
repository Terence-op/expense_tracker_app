import 'package:expense_tracker/screens/details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
final String category;
final String amount;
final DateTime dateTime;

void Function(BuildContext)? deleteTapped;

 ExpenseTile({
  super.key,
  required this.category,
  required this.amount,
  required this.dateTime,
  required this.deleteTapped,

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
              builder: (context) => Details(),
            ),
          );
        },
        title: Text(category),
        subtitle:Text('${dateTime.day} / ${dateTime.month} / ${dateTime.year}'),
        trailing: Text('K'+ amount),
      ),
    );
  }
}



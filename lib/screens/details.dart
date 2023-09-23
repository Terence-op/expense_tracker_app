import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final String category;
  final String amount;
  final String des;
  final DateTime dateTime;
  const Details({
    Key? key,
    required this.amount,
    required this.category,
    required this.dateTime,
    required this.des,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Column(
        children: [
          Text(category),
          Text(amount),
          Text(des),
          Text(dateTime.toIso8601String()),
        ],
      ),
    );
  }
}

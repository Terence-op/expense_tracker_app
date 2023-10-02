import 'package:expense_tracker/Data/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class Details extends StatelessWidget {
  final String category;
  final String amount;
  final String des;
  final String cityName;
  final DateTime dateTime;
  const Details({
    Key? key,
    required this.amount,
    required this.category,
    required this.dateTime,
    required this.des,
    required this.cityName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String Message = category;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Center(
        child: Card(
          elevation: 10, // adds a shadow effect
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0), // adds rounded corners
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                 Text(
                  cityName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                    height: 10), // adds spacing between the text and image
                Text(
                  dateTime.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                    height: 10),
                Text(
                  category,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                    height: 10),
               // adds spacing between the image and button
                Text.rich(
                  TextSpan(
                    text: '${Provider.of<ExpenseData>(context,listen: false).setCurrency}', // default text style
                    children: <TextSpan>[
                      TextSpan(text: amount, style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(
                    height: 10),
                TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      enabled: false,
                      label: Text(des),
                    )),
                const SizedBox(
                    height: 10),
                ElevatedButton(
                  onPressed: ()async{
await Share.share('location: ${cityName}, expense on: ${category}, ${Provider.of<ExpenseData>(context,listen: false).setCurrency} ${amount} Time: ${dateTime},Description: ${des}');
                  },
                  child: const Text('Share'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

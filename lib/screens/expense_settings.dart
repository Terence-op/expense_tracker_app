import 'package:expense_tracker/Data/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MySettings extends StatefulWidget {
  const MySettings({Key? key}) : super(key: key);

  @override
  State<MySettings> createState() => _MySettingsState();
}

class _MySettingsState extends State<MySettings> {
  var currency = ['ZMK', 'USD', 'EUR', 'GPB', 'CAD', 'AUD', 'JPY', 'INR'];
  var selecteditem = 'ZMK';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Currency Settings'),
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
        const SizedBox(
            height: 10),
            Image(
               image: AssetImage("assets/images/clock.jpg"),
            ),
            const SizedBox(
                height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text('Currency',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Change currency',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300),)
                    ],
                  ),
                  const SizedBox(
                      width: 130),
                  DropdownButton<String>(

                    items: currency.map((String dropDownStringItem){
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    onChanged:(String? newValueSelected) {
                      setState(() {
                        this.selecteditem = newValueSelected!;
                        Provider.of<ExpenseData>(context,listen: false).changeCurrency(newValueSelected);

                      });
                    },
                    value: selecteditem,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

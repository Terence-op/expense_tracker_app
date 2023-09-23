import 'package:expense_tracker/Data/expense_data.dart';
import 'package:expense_tracker/components/expense_tile.dart';
import 'package:expense_tracker/models/expense_item.dart';
import 'package:expense_tracker/providers/geocoding.dart';
import 'package:expense_tracker/screens/expense_statistics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

import 'expense_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  var category = ['Food', 'Transport', 'Entertainment', 'Others'];
  var selecteditem = 'Food';
  final newExpenseAmount = TextEditingController();
  final expense_description = TextEditingController();
  String? city;
  int _currentIndex = 0;
  TabController? tabController;

  //get Current possiton
  void getCurrentPosition() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    String? cityName =
        await Geocoding.getCityName(position.latitude, position.longitude);

    city = cityName;
  }

  @override
  void initState() {
    super.initState();
    Provider.of<ExpenseData>(context, listen: false).prepareData();
    tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: 0,
      animationDuration: const Duration(milliseconds: 500),
    );
    super.initState();
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  //add new expense
  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add new Expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StatefulBuilder(
              builder: (context, setState) {
                return DropdownButton<String>(
                  items: category.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem),
                    );
                  }).toList(),
                  onChanged: (String? newValueSelected) {
                    setState(() {
                      this.selecteditem = newValueSelected!;
                    });
                  },
                  value: selecteditem,
                );
              },
            ),
            //amount
            TextField(
                keyboardType: TextInputType.number,
                controller: newExpenseAmount,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  label: Text('Amount in ZMK', style: TextStyle(fontSize: 18)),
                )),
            TextField(
                keyboardType: TextInputType.text,
                controller: expense_description,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Description',
                ))
          ],
        ),
        actions: [
          //save button
          MaterialButton(
            onPressed: save,
            child: Text('Save'),
          ),

          //cancile button
          MaterialButton(
            onPressed: cancil,
            child: Text('Cancel'),
          )
        ],
      ),
    );
  }

//delete Expense
  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteNewExpense(expense);
  }

//save

  void save() {
    //create Expense item
    if (selecteditem.isNotEmpty && newExpenseAmount.text.isNotEmpty) {
      ExpenseItem newExpense = ExpenseItem(
        category: selecteditem,
        amount: newExpenseAmount.text,
        dateTime: DateTime.now(),
        description: expense_description.text,
      );

      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newExpense);
    }
    Navigator.pop(context);
    clear();
  }

//cancil
  void cancil() {
    Navigator.pop(context);
    clear();
  }

  // clear the controllers
  void clear() {
    newExpenseAmount.clear();
    expense_description.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
        builder: (context, value, child) => Scaffold(
            backgroundColor: Colors.grey[300],
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                getCurrentPosition();
                //MyCustomFormState();
                addNewExpense();
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.black,
            ),
            body: TabBarView(
              controller: tabController,
              children: [
                // weekly summary

                // ExpenseSummary(startOfWeek: value.startOfWeekDate()),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: value.getAllExpenselist().length,
                  itemBuilder: (context, index) => ExpenseTile(
                    category: value.getAllExpenselist()[index].category,
                    amount: value.getAllExpenselist()[index].amount,
                    des: value.getAllExpenselist()[index].description,
                    dateTime: DateTime.now(),
                    deleteTapped: ((p0) =>
                        deleteExpense(value.getAllExpenselist()[index])),
                  ),
                ),
                Statistis(),

                Container(),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 15,
              backgroundColor: Colors.white,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                    backgroundColor: Colors.blue),
                BottomNavigationBarItem(
                    icon: Icon(Icons.auto_graph),
                    label: 'Statistics',
                    backgroundColor: Colors.blue),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'Settings',
                    backgroundColor: Colors.blue),
              ],
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                  tabController!.index = _currentIndex;
                });
              },
            )));
  }
}

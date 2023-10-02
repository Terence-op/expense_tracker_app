import 'package:expense_tracker/Data/hive_database.dart';
import 'package:expense_tracker/datetime/date_time_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/expense_item.dart';

class ExpenseData extends ChangeNotifier{
  String setCurrency = 'ZMK';
  void changeCurrency(String currency){
    setCurrency = currency;
    notifyListeners();
  }
  //list of all expenses
   List<ExpenseItem>overallExpenseList=[];
  //get expense list
List<ExpenseItem>getAllExpenselist(){
  return overallExpenseList;
}
   final db = HiveDataBase();
void prepareData(){

 // check if there is data then use it
if(db.readData().isNotEmpty){
  overallExpenseList = db.readData();
}
}

  //add new expense
void addNewExpense(ExpenseItem newExpense){
  overallExpenseList.add(newExpense);
  notifyListeners();
  db.saveData(overallExpenseList);
}
//delete new expense
void deleteNewExpense(ExpenseItem expense){
  overallExpenseList.remove(expense);
notifyListeners();
  db.saveData(overallExpenseList);
}
  //get weekday(mon,tue,etc) from a dateTime object
String? getDayName(DateTime dateTime){
  switch(dateTime.weekday){
    case 1:
      return 'Mon';
    case 2:
      return 'Tue';
    case 3:
      return 'Wed';
    case 4:
      return 'Thur';
    case 5:
      return 'Fri';
    case 6:
      return 'Sat';
    case 7:
      return 'Sun';
    default: '';

  }

}
  //get the date for the start of the week (sunday)
DateTime startOfWeekDate(){
  DateTime?  startOfWeek;

  // get todays date

  DateTime today = DateTime.now();


  // go backwards from today to find sunday
  for(int i =0 ; i < 7; i++){
     if(getDayName(today.subtract(Duration(days:i))) == 'Sun'){
       startOfWeek = today.subtract(Duration(days:i));
     }
  }

  print(startOfWeek);
  return startOfWeek!;

}
  /*
  convert overall list of expenses into a daily expense summary
  e.g
  overallexpenseList =
  [

  [food, 2023/01/30,k10],
  [hat, 2023/01/30,k10],
  [drinks, 2023/01/30,k10],
  [food, 2023/01/30,k10],
 ]

--->





   */


Map<String,double>calculateDailyExpenseSummary(){
 Map<String,double>dailyExpenseSummary ={
   //date (yyyymmdd) : amountTotalForDay
 };
 for(var expense in overallExpenseList){
   String date = convertDateTimeToString(expense.dateTime);
   double amount = double.parse(expense.amount);

   if(dailyExpenseSummary.containsKey(date)){
     double currentAmount = dailyExpenseSummary[date]!;
     currentAmount += amount;
     dailyExpenseSummary[date] = currentAmount;
   }else{
     dailyExpenseSummary.addAll({date:amount});
   }
 }
 return dailyExpenseSummary;
}


}

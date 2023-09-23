import 'package:hive_flutter/hive_flutter.dart';

import '../models/expense_item.dart';

Box? myBox;

class HiveDataBase {
  //write data
  void saveData(List<ExpenseItem> allExpense) async {
//convert expenseItem objects into types that can be stored in our DB

//lets create  a dynamic list
    List<List<dynamic>> allExpensesFormatted = [];

    for (var expense in allExpense) {
      //converting
      List<dynamic> expensesFormatted = [
        expense.category,
        expense.amount,
        expense.dateTime,
        expense.description,
      ];
      allExpensesFormatted.add(expensesFormatted);
    }
    //storing to our DB

    myBox!.put("ALL_EXPENSES", allExpensesFormatted);
  }

//read data
  List<ExpenseItem> readData() {
    List savedExpenses = myBox!.get("ALL_EXPENSES") ?? [];

    List<ExpenseItem> allExpenses = [];

    for (int i = 0; i < savedExpenses.length; i++) {
      //collect individual data
      String category = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];
      String Description = savedExpenses[i][3];

      ExpenseItem expense = ExpenseItem(
        category: category,
        amount: amount,
        dateTime: dateTime,
        description: Description,
      );

      //add expense to overall list of expenses
      allExpenses.add(expense);
    }
    return allExpenses;
  }
}

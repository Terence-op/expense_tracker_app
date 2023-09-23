import 'package:expense_tracker/Data/expense_data.dart';
import 'package:expense_tracker/screens/expense_statistics.dart';
import 'package:expense_tracker/screens/home_screen.dart';
import 'package:expense_tracker/screens/signin_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'Data/hive_database.dart';
import 'firebase_options.dart';


void main() async {
  //initialise Hive
  await Hive.initFlutter();

  //open a hive Box
   myBox = await Hive.openBox("expense_database2");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(

      create: (context)=>ExpenseData(),
      builder: (context,child)=> const MaterialApp(
        debugShowCheckedModeBanner: false,
        home:  HomeScreen(),
      )

    );

  }
}

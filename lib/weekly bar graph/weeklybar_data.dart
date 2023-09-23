
import 'package:expense_tracker/weekly%20bar%20graph/weeklyindividual_bar.dart';

class WeeklyBarData{

  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;


  WeeklyBarData({
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required  this.thurAmount,
    required  this.friAmount,
    required this.satAmount
});

  List<WeeklyIndividualBar>barData= [];

  //initialise bar Data
void InitialiseBarData(){
  barData = [
    //sun
    WeeklyIndividualBar(x: 0, y: sunAmount),
    //mon
    WeeklyIndividualBar(x: 1, y: monAmount),
    //tue
    WeeklyIndividualBar(x: 2, y: tueAmount),
    //wed
    WeeklyIndividualBar(x: 3, y: wedAmount),
    //thur
    WeeklyIndividualBar(x: 4, y: thurAmount),
    //fri
    WeeklyIndividualBar(x: 5, y: friAmount),
    //sat
    WeeklyIndividualBar(x: 6, y: satAmount)
  ];
}

}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:math';

final money = new NumberFormat.simpleCurrency();

class MortgageProvider extends ChangeNotifier {
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  int _numYears = 10;
  double _result = 0.0;

  String getResult() {
    return money.format(_result);
  }

  String getTotal() {
    final String res = money.format(_result * _numYears * 12);
    return res;
  }

  int getYears() {
    return _numYears;
  }

  void setYears(int numYears) {
    _numYears = numYears;
  }

  void calculateMortgage() {
    var price = double.tryParse(_priceController.text) ?? 0.0;
    var rate = (double.tryParse(_rateController.text) ?? 0.0) / 12 / 100;
    var numMonths = _numYears * 12;
    var monthlyPayment = (price  * rate * pow((1 + rate), numMonths)) / (pow((1 + rate), numMonths) - 1);
    _result = ((monthlyPayment * 100).truncate() / 100);
    notifyListeners();
  }
}



void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MortgageProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mortgage Calculator',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MortgageCalculator(),
    );
  }
}

// Basic state structure
class MortgageCalculator extends StatefulWidget {
  @override
  _MortgageCalculatorState createState() => _MortgageCalculatorState();
}

class _MortgageCalculatorState extends State<MortgageCalculator> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mortgage Calculator")),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Consumer<MortgageProvider>(
            builder: (context, mortgageProvider, child) {
              return Column(
                spacing: 5,
                children: [
                  Container(
                    width: .maxFinite,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      "Number of Years",
                      textAlign: TextAlign.left,
                    ),
                  ),
                  RadioGroup<int>(
                      groupValue: mortgageProvider.getYears(),
                      onChanged: (val) => mortgageProvider.setYears(val ?? 10),
                      child: Column(
                        children: <Widget>[
                          RadioListTile(title: Text("10"), value: 10, minTileHeight: 20,),
                          RadioListTile(title: Text("15"), value: 15, minTileHeight: 20,),
                          RadioListTile(title: Text("30"), value: 30, minTileHeight: 20,),
                        ],
                      )
                  ),

                  TextField(controller: mortgageProvider._priceController, decoration: InputDecoration(labelText: 'Home Price')),
                  TextField(controller: mortgageProvider._rateController, decoration: InputDecoration(labelText: 'Yearly Interest Rate %')),

                  ElevatedButton(onPressed: () => {
                    mortgageProvider.calculateMortgage(),
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ResultsScreen()
                    ))
                  }, child: Text("Calculate"))
                ],
              );
            }
        ),
      )
    );
  }
}



class ResultsScreen extends StatelessWidget {
  const ResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Mortgage Calculator")),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                children: [
                  Column(
                    spacing: 15,
                    crossAxisAlignment: .start,
                    children: [
                      Text("Amount"),
                      Text("Years"),
                      Text("Interest Rate"),
                      Text("Monthly Payment"),
                      Text("Total Payment")
                    ],
                  ),
                  Consumer<MortgageProvider>(
                    builder: (context, mortgageProvider, child) {
                      return Column(
                        spacing: 15,
                        crossAxisAlignment: .start,
                        children: [
                          Text("\$${mortgageProvider._priceController.text}"),
                          Text("${mortgageProvider.getYears()}"),
                          Text("${mortgageProvider._rateController.text}%"),
                          Text("${mortgageProvider.getResult()}"),
                          Text("${mortgageProvider.getTotal()}")
                        ],
                      );
                    },
                  )
                ],
              ),
              ElevatedButton(onPressed: () => {
                Navigator.of(context).pop()
              }, child: Text("Modify Data"))
            ],
          )
      )
    );
  }
}
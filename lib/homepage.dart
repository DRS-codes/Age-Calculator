import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AgeCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AgeCalculatorScreen(),
    );
  }
}

class AgeCalculatorScreen extends StatefulWidget {
  @override
  _AgeCalculatorScreenState createState() => _AgeCalculatorScreenState();
}

class _AgeCalculatorScreenState extends State<AgeCalculatorScreen> {
  DateTime? _selectedDate;
  Age? _calculatedAge;

  // Function to show the date picker
  void _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            dialogBackgroundColor: Colors.transparent,
            colorScheme: ColorScheme.light(
              primary: Colors.white,
              onPrimary: Colors.white,
              surface: const Color.fromARGB(69, 0, 0, 0),
              onSurface: Colors.white,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
            ),
          ),
          child: child ?? Container(),
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _calculatedAge = _calculateAge(_selectedDate!);
      });
    }
  }

  // Function to calculate the age in years, months, and days
  Age _calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();

    int years = today.year - birthDate.year;
    int months = today.month - birthDate.month;
    int days = today.day - birthDate.day;

    if (days < 0) {
      months -= 1;
      // Get the number of days in the previous month
      final prevMonth = DateTime(today.year, today.month, 0);
      days += prevMonth.day;
    }

    if (months < 0) {
      years -= 1;
      months += 12;
    }

    return Age(years: years, months: months, days: days);
  }

  @override
  Widget build(BuildContext context) {
    Color mycolor = Color.fromARGB(255, 94, 0, 122);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: mycolor,
        foregroundColor: Color.fromARGB(255, 255, 167, 195),
        title: Center(
          child: Text(
            'Age Calculator',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
        ),
        toolbarHeight: 100,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topRight, colors: [
          mycolor,
          const Color.fromARGB(255, 255, 167, 195),
        ])),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Select your date of birth:',
                style: TextStyle(
                    fontSize: 20, color: mycolor, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 16),
              Container(),
              GestureDetector(
                onTap: () => _pickDate(context),
                child: Container(
                  padding: EdgeInsets.all(5),
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    color: mycolor,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Center(
                    child: Text(
                      _selectedDate == null
                          ? 'Pick a Date'
                          : DateFormat.yMMMMd().format(_selectedDate!),
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 167, 195),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              if (_calculatedAge != null)
                Column(
                  children: [
                    Text(
                      'Your Age is:',
                      style: TextStyle(fontSize: 20, color: mycolor),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: mycolor),
                              color: Color.fromARGB(255, 255, 167, 195),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              '${_calculatedAge!.years}\nYears',
                              style: TextStyle(
                                  color: mycolor,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: mycolor),
                              color: Color.fromARGB(255, 255, 167, 195),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              '${_calculatedAge!.months}\nMonths',
                              style: TextStyle(
                                  color: mycolor,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: mycolor),
                              color: Color.fromARGB(255, 255, 167, 195),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              '${_calculatedAge!.days}\nDays',
                              style: TextStyle(
                                  color: mycolor,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class Age {
  final int years;
  final int months;
  final int days;

  Age({required this.years, required this.months, required this.days});
}

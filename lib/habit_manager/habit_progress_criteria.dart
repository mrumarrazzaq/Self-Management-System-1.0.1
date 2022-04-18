import 'package:flutter/material.dart';
import 'package:self_management_systam/project_constants/constants.dart';
import 'habit_detail.dart';
import 'add_habit.dart';
import 'habit_constants.dart';

class HabitProgressCriteria extends StatefulWidget {
  @override
  _HabitProgressCriteriaState createState() => _HabitProgressCriteriaState();
}

class _HabitProgressCriteriaState extends State<HabitProgressCriteria> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: selectedTheme == 'Light' ? ThemeData.light() : ThemeData.dark(),
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'How do you want to evaluate your\nprogress?',
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: deffaultUIElemetsColour, fontSize: 20.0),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: MaterialButton(
                  minWidth: 300.0,
                  child: const Text(
                    'WITH A YES OR NO',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: deffaultUIElemetsColour,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DefineYourHabit(),
                      ),
                    );
                  },
                ),
              ),
              const Text(
                'If you just want to record whether you succeed with the\nactivity or not',
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: MaterialButton(
                  minWidth: 300.0,
                  child: const Text(
                    'WITH A NUMERIC VALUE',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: deffaultUIElemetsColour,
                  onPressed: () {},
                ),
              ),
              const Text(
                'If you want to establish a value as a daily goal or limit for\nthe habit',
                textAlign: TextAlign.center,
              ),
              TextButton(
                child: Text(
                  'BACK',
                  style: TextStyle(
                    color: selectedTheme == 'Light' ? darkColour : lightColour,
                    height: 5.0,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

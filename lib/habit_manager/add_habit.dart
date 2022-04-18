import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:self_management_systam/project_constants/constants.dart';
import 'habit_detail.dart';

class DefineYourHabit extends StatefulWidget {
  const DefineYourHabit({Key? key}) : super(key: key);

  @override
  _DefineYourHabitState createState() => _DefineYourHabitState();
}

class _DefineYourHabitState extends State<DefineYourHabit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String habitName = '';
  String habitDescription = '';
  final habitNameController = TextEditingController();
  final habitDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: selectedTheme == 'Light' ? ThemeData.light() : ThemeData.dark(),
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
          child: Column(
            children: [
              Text(
                'Define your habit',
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: deffaultUIElemetsColour, fontSize: 20.0),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
                      child: TextFormField(
                        autofocus: true,
                        style: TextStyle(
                          color: selectedTheme == 'Light'
                              ? darkColour
                              : lightColour,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Habit Title',
                          labelStyle: TextStyle(
                            color: selectedTheme == 'Light'
                                ? darkColour
                                : lightColour,
                          ),
                          hintText: 'Habit Title',
                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.transparent,
                          focusColor: Colors.white,
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                                color: deffaultUIElemetsColour, width: 2.0),
                          ),
                        ),
                        controller: habitNameController,
                        onChanged: (value) {
                          habitName = value;
                        },
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return "The title is required.";
                          }
                        },
                      ),
                    ),
                    TextFormField(
                      style: TextStyle(
                        color:
                            selectedTheme == 'Light' ? darkColour : lightColour,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Habit Description',
                        labelStyle: TextStyle(
                          color: selectedTheme == 'Light'
                              ? darkColour
                              : lightColour,
                        ),
                        hintText: 'Habit Description [Optionl]',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.transparent,
                        focusColor: Colors.white,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color: deffaultUIElemetsColour, width: 2.0),
                        ),
                      ),
                      controller: habitDescriptionController,
                      onChanged: (value) {
                        habitDescription = value;
                      },
                      validator: (String? val) {
                        if (val!.isEmpty) {
                          return "The description is required.";
                        }
                      },
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    child: Text(
                      'BACK',
                      style: TextStyle(
                        color:
                            selectedTheme == 'Light' ? darkColour : lightColour,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    child: Text(
                      'NEXT',
                      style: TextStyle(color: deffaultUIElemetsColour),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
//                        habitNameController.clear();
//                        habitDescriptionController.clear();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HabitDetail(
                                habitTitle: habitNameController.text,
                                habitDescription:
                                    habitDescriptionController.text),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

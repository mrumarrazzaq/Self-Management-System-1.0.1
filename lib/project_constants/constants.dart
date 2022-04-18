import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Color deffaultUIElemetsColour = Color(0xff3B67A5);
//Color deffaultUIElemetsColour = Color(0xff0000F7);

bool isUserLogout = true;

const double kWidth = 25.0;
const double kHeight = 25.0;
const Color lightColour = Colors.white;
const Color darkColour = Colors.black;
String? selectedTheme = 'Light';
String? selectedCategory = '';
String homeCategory = 'Yes';
const double kIconSize = 0.0;
Color kButtonColor = Colors.white10;

String pin = '';
String confirmPin = '';

const Color Task = Color(0xff0f6bff);
const Color Habit = Color(0xffe30044);
const Color Study = Color(0xff00e308);
const Color Cost = Color(0xffffe600);
const Color Project = Color(0xff00f2ca);
const Color Meeting = Color(0xff00806f);
int totalTaskAdd = 0;
int totalHabitAdd = 0;
int totalStudyAdd = 0;
int totalCostAdd = 0;
int totalProjectAdd = 0;
int totalMeetingsAdd = 0;

final firstNameController = TextEditingController();
final lastNameController = TextEditingController();

int index = 0;
String? label;
List<Widget> projectList = [];

class ReuseableList extends StatelessWidget {
  ReuseableList(
      {required this.index,
      required this.taskName,
      required this.taskDetail,
      required this.colour});
  final index;
  final taskName;
  final taskDetail;
  final colour;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: ListTile(
          title: Text('$taskName'),
          minLeadingWidth: 2.0,
          subtitle: Text('$taskDetail'),
          leading: Image.asset(
            'icons/$label.png',
            color: colour,
            height: 35.0,
            width: 35.0,
          ),
          trailing: Text('$label'),
        ),
      ),
    );
  }
}

final userId = FirebaseAuth.instance.currentUser!.uid;
final userEmail = FirebaseAuth.instance.currentUser!.email;

DateTime Time = DateTime.now();

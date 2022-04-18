import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:self_management_systam/project_constants/constants.dart';
import 'habit_constants.dart';
import 'package:self_management_systam/main_section/home_screen.dart';

class HabitDetail extends StatefulWidget {
  HabitDetail(
      {required this.habitTitle, required this.habitDescription, Key? key})
      : super(key: key);
  final String habitTitle;
  final String habitDescription;

  @override
  _HabitDetailState createState() => _HabitDetailState();
}

class _HabitDetailState extends State<HabitDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _someTimesPerPeriodController =
      TextEditingController();
  final TextEditingController _repeatController = TextEditingController();

  int selectedValue = 0;
  bool isValidate = true;
  List<bool> isDaySeleted = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<bool> daysCheckBoxValue = [
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  bool isDaysVisible = false;
  bool isRepeatVisible = false;
  bool isSomePeriodOfTimeVisible = false;
  bool isSomeDaysOfMonthVisible = false;
  String selected = 'Week';

  //Add Events
  CollectionReference events =
      FirebaseFirestore.instance.collection('$userEmail');
  Future<void> addEvent() {
    print(widget.habitTitle);
    print(widget.habitDescription);
    return events
        .add({
          'creationTime': Time,
          'event': 'habit',
          'title': widget.habitTitle,
          'note': widget.habitDescription,
          'selectedDate': 'null',
          'startTime': 'null',
          'endTime': 'null',
          'category': 'null',
          'repeat': 'Daily',
          'remind': 0,
          'specificDaysOfWeek': 0,
          'specificDaysOfMonth': 0,
          'specificPeriod': 0,
          'isCompleted': 0,
          'total': 0
        })
        .then((value) => print('Event Added by email : $userEmail'))
        .catchError((error) => print('Faild to Add Event $error'));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: selectedTheme == 'Light' ? ThemeData.light() : ThemeData.dark(),
      home: Scaffold(
        key: _scaffoldKey,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
          child: ListView(
            children: [
              Text(
                'How often do you want to do it?',
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: deffaultUIElemetsColour, fontSize: 20.0),
              ),
              RadioListTile<int>(
                value: 0,
                title: Text('Every Day'),
                secondary: Text(''),
                groupValue: selectedValue,
                activeColor: deffaultUIElemetsColour,
                onChanged: (value) {
                  setState(() {
                    selectedValue = 0;
                    isDaysVisible = false;
                    isRepeatVisible = false;
                    isSomePeriodOfTimeVisible = false;
                  });
                },
              ),
              RadioListTile<int>(
                value: 1,
                title: Text('Specific days of week'),
                secondary: Text(''),
                groupValue: selectedValue,
                activeColor: deffaultUIElemetsColour,
                onChanged: (value) {
                  setState(() {
                    selectedValue = 1;
                    isDaysVisible = true;
                    isRepeatVisible = false;
                    isSomePeriodOfTimeVisible = false;
                    isSomeDaysOfMonthVisible = false;
                  });
                },
              ),
              //Days of week
              Visibility(
                visible: isDaysVisible,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: daysCheckBoxValue[0],
                            activeColor: deffaultUIElemetsColour,
                            onChanged: (value) {
                              setState(() {
                                daysCheckBoxValue[0] = value!;
                              });
                            },
                          ),
                          Text('Monday'),
                          Checkbox(
                            value: daysCheckBoxValue[1],
                            activeColor: deffaultUIElemetsColour,
                            onChanged: (value) {
                              setState(() {
                                daysCheckBoxValue[1] = value!;
                              });
                            },
                          ),
                          Text('Tuesday'),
                          Checkbox(
                            value: daysCheckBoxValue[2],
                            activeColor: deffaultUIElemetsColour,
                            onChanged: (value) {
                              setState(() {
                                daysCheckBoxValue[2] = value!;
                              });
                            },
                          ),
                          Text('Wednesday'),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: daysCheckBoxValue[3],
                            activeColor: deffaultUIElemetsColour,
                            onChanged: (value) {
                              setState(() {
                                daysCheckBoxValue[3] = value!;
                              });
                            },
                          ),
                          Text('Thursday'),
                          Checkbox(
                            value: daysCheckBoxValue[4],
                            activeColor: deffaultUIElemetsColour,
                            onChanged: (value) {
                              setState(() {
                                daysCheckBoxValue[4] = value!;
                              });
                            },
                          ),
                          Text('Friday'),
                          Checkbox(
                            value: daysCheckBoxValue[5],
                            activeColor: deffaultUIElemetsColour,
                            onChanged: (value) {
                              setState(() {
                                daysCheckBoxValue[5] = value!;
                              });
                            },
                          ),
                          Text('Saturday'),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: daysCheckBoxValue[6],
                            activeColor: deffaultUIElemetsColour,
                            onChanged: (value) {
                              setState(() {
                                daysCheckBoxValue[6] = value!;
                              });
                            },
                          ),
                          Text('Sunday'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              RadioListTile<int>(
                value: 2,
                title: Text('Specific Days of month'),
                secondary: Text(''),
                groupValue: selectedValue,
                activeColor: deffaultUIElemetsColour,
                onChanged: (value) {
                  setState(() {
                    selectedValue = 2;
                    isDaysVisible = false;
                    isRepeatVisible = false;
                    isSomePeriodOfTimeVisible = false;
                    isSomeDaysOfMonthVisible = true;
                  });
                },
              ),
              Visibility(
                visible: isSomeDaysOfMonthVisible,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomChoiceChip(
                          day: '1',
                          isSelected: isDaySeleted[1],
                        ),
                        CustomChoiceChip(
                          day: '2',
                          isSelected: isDaySeleted[2],
                        ),
                        CustomChoiceChip(
                          day: '3',
                          isSelected: isDaySeleted[3],
                        ),
                        CustomChoiceChip(
                          day: '4',
                          isSelected: isDaySeleted[4],
                        ),
                        CustomChoiceChip(
                          day: '5',
                          isSelected: isDaySeleted[5],
                        ),
                        CustomChoiceChip(
                          day: '6',
                          isSelected: isDaySeleted[6],
                        ),
                        CustomChoiceChip(
                          day: '7',
                          isSelected: isDaySeleted[7],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomChoiceChip(
                          day: '8',
                          isSelected: isDaySeleted[8],
                        ),
                        CustomChoiceChip(
                          day: '9',
                          isSelected: isDaySeleted[9],
                        ),
                        CustomChoiceChip(
                          day: '10',
                          isSelected: isDaySeleted[10],
                        ),
                        CustomChoiceChip(
                          day: '11',
                          isSelected: isDaySeleted[11],
                        ),
                        CustomChoiceChip(
                          day: '12',
                          isSelected: isDaySeleted[12],
                        ),
                        CustomChoiceChip(
                          day: '13',
                          isSelected: isDaySeleted[13],
                        ),
                        CustomChoiceChip(
                          day: '14',
                          isSelected: isDaySeleted[14],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomChoiceChip(
                          day: '15',
                          isSelected: isDaySeleted[15],
                        ),
                        CustomChoiceChip(
                          day: '16',
                          isSelected: isDaySeleted[16],
                        ),
                        CustomChoiceChip(
                          day: '17',
                          isSelected: isDaySeleted[17],
                        ),
                        CustomChoiceChip(
                          day: '18',
                          isSelected: isDaySeleted[18],
                        ),
                        CustomChoiceChip(
                          day: '19',
                          isSelected: isDaySeleted[19],
                        ),
                        CustomChoiceChip(
                          day: '20',
                          isSelected: isDaySeleted[20],
                        ),
                        CustomChoiceChip(
                          day: '21',
                          isSelected: isDaySeleted[21],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomChoiceChip(
                          day: '22',
                          isSelected: isDaySeleted[22],
                        ),
                        CustomChoiceChip(
                          day: '23',
                          isSelected: isDaySeleted[23],
                        ),
                        CustomChoiceChip(
                          day: '24',
                          isSelected: isDaySeleted[24],
                        ),
                        CustomChoiceChip(
                          day: '25',
                          isSelected: isDaySeleted[25],
                        ),
                        CustomChoiceChip(
                          day: '26',
                          isSelected: isDaySeleted[26],
                        ),
                        CustomChoiceChip(
                          day: '27',
                          isSelected: isDaySeleted[27],
                        ),
                        CustomChoiceChip(
                          day: '28',
                          isSelected: isDaySeleted[28],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomChoiceChip(
                          day: '29',
                          isSelected: isDaySeleted[29],
                        ),
                        CustomChoiceChip(
                          day: '30',
                          isSelected: isDaySeleted[30],
                        ),
                        CustomChoiceChip(
                          day: '31',
                          isSelected: isDaySeleted[31],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              RadioListTile<int>(
                value: 3,
                title: Text('SomeTimes per period'),
                secondary: Text(''),
                activeColor: deffaultUIElemetsColour,
                groupValue: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = 3;
                    isDaysVisible = false;
                    isRepeatVisible = false;
                    isSomeDaysOfMonthVisible = false;
                    isSomePeriodOfTimeVisible = true;
                  });
                },
              ),
              //Some period of the time
              Visibility(
                visible: isSomePeriodOfTimeVisible,
                child: Padding(
                  padding: const EdgeInsets.only(left: 80.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 1,
                        child: TextFormField(
                          showCursor: true,
                          autofocus: true,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller: _someTimesPerPeriodController,
                        ),
                      ),
                      Flexible(
                        flex: 4,
                        child: Row(
                          children: [
                            const Text('times per      '),
                            DropdownButton<String>(
                              value: selected,
                              items: const [
                                DropdownMenuItem(
                                  child: Text('Week'),
                                  value: 'Week',
                                ),
                                DropdownMenuItem(
                                  child: Text('Month'),
                                  value: 'Month',
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  selected = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              RadioListTile<int>(
                value: 4,
                title: Text('Repeat'),
                secondary: Text(''),
                activeColor: deffaultUIElemetsColour,
                groupValue: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = 4;
                    isDaysVisible = false;
                    isSomePeriodOfTimeVisible = false;
                    isSomeDaysOfMonthVisible = false;
                    isRepeatVisible = true;
                  });
                },
              ),
              Visibility(
                visible: isRepeatVisible,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 160.0),
                      child: TextFormField(
                        showCursor: true,
                        autofocus: true,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        controller: _repeatController,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Every'),
//                    TextFormField(),
                        Text('days.'),
                      ],
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
                      'Add',
                      style: TextStyle(color: deffaultUIElemetsColour),
                    ),
                    onPressed: () {
                      setState(() {
                        if (isDaysVisible == true &&
                            (daysCheckBoxValue[0] == false &&
                                daysCheckBoxValue[1] == false &&
                                daysCheckBoxValue[2] == false &&
                                daysCheckBoxValue[3] == false &&
                                daysCheckBoxValue[4] == false &&
                                daysCheckBoxValue[4] == false &&
                                daysCheckBoxValue[6] == false)) {
                          // ignore: deprecated_member_use
                          _scaffoldKey.currentState!.showSnackBar(SnackBar(
                            content: Row(
                              children: const [
                                Icon(
                                  Icons.warning_amber_outlined,
                                  color: Colors.white,
                                ),
                                Text('   Select at least one day '),
                              ],
                            ),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 1),
                          ));
                          isValidate = false;
                        } else {
                          isValidate = true;
                        }

                        if (isSomePeriodOfTimeVisible == true &&
                            _someTimesPerPeriodController.text.isEmpty) {
                          // ignore: deprecated_member_use
                          _scaffoldKey.currentState!.showSnackBar(SnackBar(
                            content: Row(
                              children: const [
                                Icon(
                                  Icons.warning_amber_outlined,
                                  color: Colors.white,
                                ),
                                Text('   Field is required !'),
                              ],
                            ),
                            backgroundColor: Colors.red,
                          ));
                          isValidate = false;
                        } else {
                          isValidate = true;
                        }

                        if (isRepeatVisible == true &&
                            _repeatController.text.isEmpty) {
                          // ignore: deprecated_member_use
                          _scaffoldKey.currentState!.showSnackBar(SnackBar(
                            content: Row(
                              children: const [
                                Icon(
                                  Icons.warning_amber_outlined,
                                  color: Colors.white,
                                ),
                                Text('   Field is required !'),
                              ],
                            ),
                            backgroundColor: Colors.red,
                          ));
                          isValidate = false;
                        } else {
                          isValidate = true;
                        }

                        if (isDaysVisible == true &&
                            (isDaySeleted[0] == false &&
                                isDaySeleted[1] == false &&
                                isDaySeleted[2] == false &&
                                isDaySeleted[3] == false &&
                                isDaySeleted[4] == false &&
                                isDaySeleted[5] == false &&
                                isDaySeleted[6] == false &&
                                isDaySeleted[7] == false &&
                                isDaySeleted[8] == false &&
                                isDaySeleted[9] == false &&
                                isDaySeleted[10] == false &&
                                isDaySeleted[11] == false &&
                                isDaySeleted[12] == false &&
                                isDaySeleted[13] == false &&
                                isDaySeleted[14] == false &&
                                isDaySeleted[15] == false &&
                                isDaySeleted[16] == false &&
                                isDaySeleted[17] == false &&
                                isDaySeleted[18] == false &&
                                isDaySeleted[19] == false &&
                                isDaySeleted[20] == false &&
                                isDaySeleted[21] == false &&
                                isDaySeleted[22] == false &&
                                isDaySeleted[23] == false &&
                                isDaySeleted[24] == false &&
                                isDaySeleted[25] == false &&
                                isDaySeleted[26] == false &&
                                isDaySeleted[27] == false &&
                                isDaySeleted[28] == false &&
                                isDaySeleted[29] == false &&
                                isDaySeleted[30] == false)) {
                          // ignore: deprecated_member_use
                          _scaffoldKey.currentState!.showSnackBar(SnackBar(
                            content: Row(
                              children: const [
                                Icon(
                                  Icons.warning_amber_outlined,
                                  color: Colors.white,
                                ),
                                Text('   Select at least one day '),
                              ],
                            ),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 1),
                          ));
                          isValidate = false;
                        } else {
                          isValidate = true;
                        }

                        if (isValidate) {
                          addEvent();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                              (route) => false);
                        }
                      });
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

class CustomChoiceChip extends StatefulWidget {
  CustomChoiceChip({required this.day, required this.isSelected});
  final String day;
  bool isSelected;

  @override
  State<CustomChoiceChip> createState() => _CustomChoiceChipState();
}

class _CustomChoiceChipState extends State<CustomChoiceChip> {
  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(
        widget.day,
        style: TextStyle(
            color: selectedTheme == 'Light' ? darkColour : lightColour),
      ),
      selectedColor: deffaultUIElemetsColour.withOpacity(0.5),
      elevation: 3.0,
      selected: widget.isSelected,
      onSelected: (newValue) {
        setState(() {
          widget.isSelected = newValue;
        });
      },
    );
  }
}

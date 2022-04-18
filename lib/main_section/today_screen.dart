// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_management_systam/task_manager/update_task.dart';
//import 'package:intl/intl.dart';
import 'package:self_management_systam/project_constants/constants.dart';
import 'package:self_management_systam/habit_manager/habit_section.dart';
import 'package:self_management_systam/task_manager/task_manager.dart';

//task icon : fact_check_outlined

//final registeredEmail = FirebaseAuth.instance.currentUser!.email;
//final storage = FlutterSecureStorage();
var deletedId;
var updateId;
int isCompleted = 0;
bool flag = false;
String managementName = '';
String? selectCategory;
Color? localColour;
DateTime dateTime = DateTime.now();
TimeOfDay? time = const TimeOfDay(hour: 12, minute: 12);

class TodayScreen extends StatefulWidget {
  static const String id = 'TodayPage';

  const TodayScreen({Key? key}) : super(key: key);

  @override
  _TodayScreenState createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  final Stream<QuerySnapshot> streamTask =
      FirebaseFirestore.instance.collection('$userEmail').snapshots();

//  /$email/$uid/
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  DateTime _resetDate = DateTime.now();

  String stringDateTime =
      "${DateTime.now().day.toString().padLeft(2, '0')}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().year.toString()}";

  String newStringDateTime =
      "${DateTime.now().day.toString().padLeft(2, '0')}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().year.toString()}";
  bool isValid = false;
  String taskName = '';
  String taskDescription = '';
  void validate() {
    if (formkey.currentState!.validate()) {
      print('validated');
      isValid = true;
    } else {
      print('Not validated');
    }
  }

  //For Deleting Events
  CollectionReference events =
      FirebaseFirestore.instance.collection('$userEmail');
  Future<void> deleteEvent(id) {
    return events
        .doc(id)
        .delete()
        .then((value) => print('Event deleted '))
        .catchError((error) => print('Faild to delet Evnet $error'));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("TodayScreen Bulid Run");
    return StreamBuilder<QuerySnapshot>(
        stream: streamTask,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: deffaultUIElemetsColour,
              strokeWidth: 2.0,
            ));
          }

          final List storeEvents = [];

          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storeEvents.add(a);
            print(storeEvents);
            print(document.id);
            a['id'] = document.id;
          }).toList();
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme:
                selectedTheme == 'Light' ? ThemeData.light() : ThemeData.dark(),
            home: Scaffold(
              body: ListView(
                children: [
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          stringDateTime == newStringDateTime ? 'Today' : '',
                          style: GoogleFonts.abel(
                            fontSize: 30,
                          ),
                        ),
                        IconButton(
                          splashRadius: 30.0,
                          onPressed: () {
                            _getDateFromUser();
                          },
                          icon: const Icon(Icons.calendar_month_outlined),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(newStringDateTime),
                        const Divider(),
                      ],
                    ),
                  ),
                  _datePicker(),
                  const Divider(),
                  for (int i = 0; i < storeEvents.length; i++) ...[
                    storeEvents[i]['selectedDate'] == newStringDateTime
                        ? Container(
                            height: 140,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              gradient: storeEvents[i]['event'] == 'task'
                                  ? const LinearGradient(colors: [
                                      Color(0xff00007C),
                                      Color(0xff0000F7),
                                    ])
                                  : const LinearGradient(colors: [
                                      Color(0xff940000),
                                      Color(0xffF70000),
                                    ]),
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                setState(() {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: buildBottomSheet);
//                                  deleteEvent(storeEvents[i]['id']);
                                  print(storeEvents[i]['id']);
                                  deletedId = storeEvents[i]['id'];
                                  updateId = storeEvents[i]['id'];
                                  isCompleted = storeEvents[i]['isCompleted'];
                                });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ' ${storeEvents[i]['title']}',
                                        style: GoogleFonts.ramaraja(
                                          fontSize: 22.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        ' ${storeEvents[i]['note']}',
                                        style: GoogleFonts.lato(
                                          fontSize: 15.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const Divider(color: Colors.white),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Icon(
                                            Icons.timer_outlined,
                                            color: Colors.white,
                                          ),
                                          Text(
                                              '  ${storeEvents[i]['startTime']} - ${storeEvents[i]['endTime']}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                              )),
                                        ],
                                      ),
                                      const SizedBox(height: 8.0),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.date_range,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            '    ${storeEvents[i]['selectedDate']}',
                                            style: GoogleFonts.lato(
                                              fontSize: 15.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  RotatedBox(
                                    quarterTurns: 1,
                                    child: Text(
                                      storeEvents[i]['isCompleted'] == 0
                                          ? 'TODO'
                                          : 'COMPLETED',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : storeEvents[i]['repeat'] == 'Daily'
                            ? Container(
                                height: 140,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
//                                  color: storeEvents[i]['event'] == 'task'
//                                      ? const Color(0xff0000ff)
//                                      : const Color(0xffff0000),
                                  gradient: storeEvents[i]['event'] == 'task'
                                      ? const LinearGradient(colors: [
                                          Color(0xff00007C),
                                          Color(0xff0000F7),
                                        ])
                                      : const LinearGradient(colors: [
                                          Color(0xff940000),
                                          Color(0xffF70000),
                                        ]),
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    setState(() {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: buildBottomSheet);
//                                  deleteEvent(storeEvents[i]['id']);
                                      print('id : ${storeEvents[i]['id']}');
                                      deletedId = storeEvents[i]['id'];
                                      updateId = storeEvents[i]['id'];
                                      isCompleted =
                                          storeEvents[i]['isCompleted'];
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            ' ${storeEvents[i]['title']}',
                                            style: GoogleFonts.ramaraja(
                                              fontSize: 22.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            ' ${storeEvents[i]['note']}',
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.lato(
                                              fontSize: 15.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const Divider(color: Colors.white),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.timer_outlined,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                  '  ${storeEvents[i]['startTime']} - ${storeEvents[i]['endTime']}',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  )),
                                            ],
                                          ),
                                          const SizedBox(height: 8.0),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.date_range,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                '    ${storeEvents[i]['selectedDate']}',
                                                style: GoogleFonts.lato(
                                                  fontSize: 15.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      RotatedBox(
                                        quarterTurns: 1,
                                        child: Text(
                                          storeEvents[i]['isCompleted'] == 0
                                              ? 'TODO'
                                              : 'COMPLETED',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container()
                  ],
                ],
              ),
              floatingActionButton: _speedDialAddButton(),
            ),
          );
        });
  }

  _getDateFromUser() async {
    DateTime? _pickDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(3000),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: deffaultUIElemetsColour, // header background color
              onPrimary: selectedTheme == 'Light'
                  ? Colors.black
                  : Colors.white, // header text color
              onSurface: selectedTheme == 'Light'
                  ? Colors.black
                  : Colors.white, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (_pickDate != null) {
      setState(() {
        _selectedDate = _pickDate;
      });
    }
  }

//  MaterialApp(
//  debugShowCheckedModeBanner: false,
//  theme: selectedTheme == 'Light' ? ThemeData.light() : ThemeData.dark(),
//  home: Scaffold(
//  body: ListView(
//  children: [
//  ListTile(
//  title: Text(
//  stringDateTime == newStringDateTime ? 'Today' : '',
//  style: GoogleFonts.abel(
//  fontSize: 30,
//  ),
//  ),
//  subtitle: Column(
//  crossAxisAlignment: CrossAxisAlignment.start,
//  children: [
//  Text(newStringDateTime),
//  const Divider(),
//  ],
//  ),
//  trailing: IconButton(
//  splashRadius: 20.0,
//  icon: Icon(Icons.refresh),
//  onPressed: () {
//  setState(() {
//  _selectedDate = _resetDate;
//  print(_selectedDate);
//  });
//  }),
//  ),
//  _datePicker(),
//  const Divider(),
//
////            _showTasks(),
//  ],
//  ),
//  floatingActionButton: _speedDialAddButton(),
//  ),
//  );

  _datePicker() {
    return Container(
      margin: const EdgeInsets.only(left: 10.0),
      child: DatePicker(
        DateTime.now(),
        height: 80.0,
        width: 50.0,
        initialSelectedDate: DateTime.now(),
        selectionColor: deffaultUIElemetsColour,
        selectedTextColor: lightColour,
        dateTextStyle: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
        dayTextStyle: const TextStyle(
            fontSize: 10, fontWeight: FontWeight.w600, color: Colors.grey),
        monthTextStyle: const TextStyle(
            fontSize: 10, fontWeight: FontWeight.w600, color: Colors.grey),
        onDateChange: (date) {
          _selectedDate = date;
          print(_selectedDate);
          setState(() {
            newStringDateTime =
                "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year.toString()}";
          });
        },
      ),
    );
  }

//  _showTasks() {
////    print('show tasks called');
//    return Expanded(
//      child: Obx(() {
////        print('task section called');
//        return ListView.builder(
//            itemCount: _taskController.taskList.length,
//            itemBuilder: (_, context) {
//              print("total task = ${_taskController.taskList.length}");
//              return Container(
//                width: 100,
//                height: 50,
//                color: Colors.green,
//              );
////              GestureDetector(
////                onTap: () {
////                  _taskController.deleteTasks(_taskController.taskList[index]);
////                  _taskController.getTasks();
////                },
////                child: Container(
////                  margin: EdgeInsets.only(bottom: 10.0),
////                  width: 100,
////                  height: 50.0,
////                  color: Colors.yellow,
////                  child: Text(_taskController.taskList[index].title.toString()),
////                ),
////              );
//            });
//      }),
//    );
//
////      Container(
////      color: Colors.red,
////      width: 200,
////      height: 50,
////    );
//  }

  _speedDialAddButton() {
    return SpeedDial(
      spacing: 8,
      icon: Icons.add,
      foregroundColor: Colors.white,
      backgroundColor: deffaultUIElemetsColour,
      children: [
        SpeedDialChild(
          child: Image.asset(
            'icons/Meeting.png',
            color: Meeting,
            height: 25.0,
            width: 25.0,
          ),
          label: 'Meeting',
          onTap: () {
            label = 'Meeting';
//                openPINDialog();
          },
        ),
        SpeedDialChild(
          child: Image.asset(
            'icons/Project.png',
            color: Project,
            height: 30.0,
            width: 30.0,
          ),
          label: 'Project',
          onTap: () {
            label = 'Project';
          },
        ),
        SpeedDialChild(
          child: Image.asset(
            'icons/Cost.png',
            color: Cost,
            height: 25.0,
            width: 25.0,
          ),
          label: 'Cost',
          onTap: () async {
            label = 'Cost';
          },
        ),
        SpeedDialChild(
          child: Image.asset(
            'icons/Study.png',
            color: Study,
            height: 35.0,
            width: 35.0,
          ),
          label: 'Study',
          onTap: () {
            label = 'Study';
          },
        ),
        SpeedDialChild(
          child: Image.asset(
            'icons/Habit.png',
            color: Habit,
            height: 25.0,
            width: 25.0,
          ),
          label: 'Habit',
          onTap: () {
            label = 'Habit';
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HabitSection(),
              ),
            );
          },
        ),
        SpeedDialChild(
          child: Image.asset(
            'icons/Task.png',
            color: Task,
            height: 25.0,
            width: 25.0,
          ),
          label: 'Task',
          onTap: () async {
            label = 'Task';
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TaskManager()),
            );
          },
        ),
      ],
    );
  }

  Widget buildBottomSheet(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Container(
        margin: const EdgeInsets.all(5.0),
        height: 250.0,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300.0,
              height: 50.0,
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: MaterialButton(
                  height: 50.0,
                  splashColor: Colors.transparent,
                  onPressed: () {
                    CollectionReference events =
                        FirebaseFirestore.instance.collection('$userEmail');
                    if (isCompleted == 0) {
                      events
                          .doc(updateId)
                          .update({
                            'isCompleted': 1,
                          })
                          .then((value) =>
                              print('isCompleted Update by email : $userEmail'))
                          .catchError((error) =>
                              print('Faild to Update isCompleted $error'));
                    } else if (isCompleted == 1) {
                      events
                          .doc(updateId)
                          .update({
                            'isCompleted': 0,
                          })
                          .then((value) =>
                              print('isCompleted Update by email : $userEmail'))
                          .catchError((error) =>
                              print('Faild to Update isCompleted $error'));
                    }
                    Navigator.pop(context);
                  },
                  child: Text(
                    isCompleted == 0
                        ? 'Mark Event Complete'
                        : 'Mark Event InComplete',
                    style: const TextStyle(color: Colors.white),
                  )),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  gradient: const LinearGradient(colors: [
                    Color(0xff00007C),
                    Color(0xff0000F7),
                  ])),
            ),
            Container(
              width: 300.0,
              height: 50.0,
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: MaterialButton(
                  height: 50.0,
                  splashColor: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ExampleUpdate(id: updateId)),
                      );
                    });
                  },
                  child: const Text(
                    'Edit Event',
                    style: TextStyle(color: Colors.white),
                  )),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  gradient: const LinearGradient(colors: [
                    Color(0xff006100),
                    Color(0xff00F701),
                  ])),
            ),
            Container(
              width: 300.0,
              height: 50.0,
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: MaterialButton(
                  height: 50.0,
                  splashColor: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      deleteEvent(deletedId);
                    });
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Delete Event',
                    style: TextStyle(color: Colors.white),
                  )),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  gradient: const LinearGradient(colors: [
                    Color(0xff940000),
                    Color(0xffF70000),
                  ])),
            ),
          ],
        )),
        decoration: BoxDecoration(
          color:
              selectedTheme == 'Light' ? Colors.white : const Color(0xff242424),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
      ),
    );
  }
//  Future openPINDialog() => showDialog(
//        context: context,
//        builder: (context) => StatefulBuilder(
//          builder: (context, setState) => ListView(
//            children: [
//              AlertDialog(
//                title: const Text('Manage Your Self'),
//                content: Container(
//                  height: 280.0,
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.stretch,
//                    children: [
//                      Padding(
//                        padding: const EdgeInsets.symmetric(vertical: 10.0),
//                        child: Form(
//                          key: formkey,
//                          child: TextFormField(
//                            style: TextStyle(
//                              color: selectedTheme == 'Light'
//                                  ? darkColour
//                                  : lightColour,
//                            ),
//                            decoration: InputDecoration(
//                              labelText: '$label Name',
//                              labelStyle: TextStyle(
//                                color: selectedTheme == 'Light'
//                                    ? darkColour
//                                    : lightColour,
//                              ),
//                              hintText: '$label Name',
//                              hintStyle: const TextStyle(color: Colors.grey),
//                              filled: true,
//                              fillColor: Colors.transparent,
//                              focusColor: Colors.white,
//                              border: const OutlineInputBorder(
//                                borderRadius: BorderRadius.all(
//                                  Radius.circular(10.0),
//                                ),
//                              ),
//                              focusedBorder: OutlineInputBorder(
//                                borderRadius: BorderRadius.circular(10.0),
//                                borderSide: BorderSide(
//                                    color: deffaultUIElemetsColour, width: 2.0),
//                              ),
//                            ),
//                            onChanged: (value) {
//                              taskName = value;
//                            },
//                            validator: (String? val) {
//                              if (val!.isEmpty) {
//                                return "required";
//                              }
//                            },
//                          ),
//                        ),
//                      ),
//                      Padding(
//                        padding: const EdgeInsets.symmetric(vertical: 10.0),
//                        child: TextFormField(
//                          style: TextStyle(
//                            color: selectedTheme == 'Light'
//                                ? darkColour
//                                : lightColour,
//                          ),
//                          decoration: InputDecoration(
//                            labelText: '$label Detail',
//                            labelStyle: TextStyle(
//                              color: selectedTheme == 'Light'
//                                  ? darkColour
//                                  : lightColour,
//                            ),
//                            hintText: '$label Detail [Optionl]',
//                            hintStyle: TextStyle(color: Colors.grey),
//                            filled: true,
//                            fillColor: Colors.transparent,
//                            focusColor: Colors.white,
//                            border: const OutlineInputBorder(
//                              borderRadius: BorderRadius.all(
//                                Radius.circular(10.0),
//                              ),
//                            ),
//                            focusedBorder: OutlineInputBorder(
//                              borderRadius: BorderRadius.circular(10.0),
//                              borderSide: BorderSide(
//                                  color: deffaultUIElemetsColour, width: 2.0),
//                            ),
//                          ),
//                          onChanged: (value) {
//                            taskDescription = value;
//                          },
//                        ),
//                      ),
//                      //Date Picker
//                      Row(
//                        children: [
//                          TextButton(
//                            child: Text('Get Date'),
//                            onPressed: () async {
//                              DateTime? newDate = await showDatePicker(
//                                context: context,
//                                initialDate: dateTime,
//                                firstDate: DateTime(1800),
//                                lastDate: DateTime(3000),
//                              );
//                              if (newDate != null) {
//                                setState(() {
//                                  dateTime = newDate;
//                                });
//                              }
//                            },
//                          ),
//                          Text(
//                              '${dateTime.day}-${dateTime.month}-${dateTime.year}'),
//                        ],
//                      ),
//                      //Time Picker
//                      Row(
//                        children: [
//                          TextButton(
//                            child: Text('Get Time'),
//                            onPressed: () async {
//                              TimeOfDay? newTime = await showTimePicker(
//                                context: context,
//                                initialTime: time!,
//                              );
//                              if (newTime != null) {
//                                setState(() {
//                                  time = newTime;
//                                });
//                              }
//                            },
//                          ),
//                          Text(
//                              '${time!.hour.toString()}:${time!.minute.toString()}'),
//                        ],
//                      ),
//                    ],
//                  ),
//                ),
//                actions: [
//                  TextButton(
//                    onPressed: () {
//                      Navigator.of(context, rootNavigator: true).pop('dialog');
//                    },
//                    child: const Text(
//                      'CANCEL',
//                      style: TextStyle(color: Colors.red),
//                    ),
//                  ),
//                  TextButton(
//                    onPressed: () {
//                      if (formkey.currentState!.validate()) {
//                        setState(() {
//                          if (label == 'Task') {
//                            totalTaskAdd++;
//                            index++;
//                            localColour = Task;
//                          }
//                          if (label == 'Habit') {
//                            totalHabitAdd++;
//                            index++;
//                            localColour = Habit;
//                          }
//                          if (label == 'Study') {
//                            totalStudyAdd++;
//                            index++;
//                            localColour = Study;
//                          }
//                          if (label == 'Cost') {
//                            totalCostAdd++;
//                            localColour = Cost;
//                          }
//                          if (label == 'Project') {
//                            totalProjectAdd++;
//                            index++;
//                            localColour = Project;
//                          }
//                          if (label == 'Meeting') {
//                            totalMeetingsAdd++;
//                            index++;
//                            localColour = Meeting;
//                          }
//
//                          projectList.add(
//                            ReuseableList(
//                              index: index,
//                              taskName: taskName,
//                              taskDetail: taskDescription,
//                              colour: localColour,
//                            ),
//                          );
//                        });
//                        Navigator.pushAndRemoveUntil(
//                            context,
//                            MaterialPageRoute(
//                              builder: (context) => HomePage(),
//                            ),
//                            (route) => false);
////                        Navigator.of(context, rootNavigator: true)
////                            .pop('dialog');
//                      }
//                    },
//                    child: Text(
//                      'ADD',
//                      style: TextStyle(
//                        color:
//                            selectedTheme == 'Light' ? darkColour : lightColour,
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//            ],
//          ),
//        ),
//      );
}

//
//Visibility(
//visible: false,
//child: Padding(
//padding: const EdgeInsets.symmetric(vertical: 100.0),
//child: Column(
//children: const [
//Text(
//'There is nothing scheduled',
//style: TextStyle(fontSize: 20.0),
//),
//Text(
//'Try Adding New activities',
//style: TextStyle(color: Colors.grey),
//),
//],
//),
//),
//),

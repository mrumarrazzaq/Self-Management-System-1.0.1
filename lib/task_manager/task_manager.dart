import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:self_management_systam/project_constants/constants.dart';

class TaskManager extends StatefulWidget {
  @override
  _TaskManagerState createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  String title = '';
  String description = '';

  DateTime _selectedDate = DateTime.now();
  String _selectedDateToString =
      "${DateTime.now().day.toString().padLeft(2, '0')}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().year.toString()}";

  DateTime _selectedTime = DateTime.now();
  String _startTime =
      " ${DateTime.now().hour.toString().padLeft(2, '0')} : ${DateTime.now().minute.toString().padLeft(2, '0')} AM";
  String _endTime = '12:00 AM';

  int _selectedReminder = 5;
  List<int> remindList = [5, 10, 15, 20, 25, 30];
  String _selectedRepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
  Color _selectedColor = Color(0xff0000ff);

  //Add Events
  CollectionReference events =
      FirebaseFirestore.instance.collection('$userEmail');
  Future<void> addEvent() {
    return events
        .add({
          'creationTime': _selectedTime,
          'event': 'task',
          'title': _titleController.text,
          'note': _noteController.text,
          'selectedDate': _selectedDateToString,
          'startTime': _startTime,
          'endTime': _endTime,
          'category': 'null',
          'repeat': _selectedRepeat,
          'remind': _selectedReminder.toString(),
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
        appBar: AppBar(
          backgroundColor:
              selectedTheme == 'Light' ? deffaultUIElemetsColour : null,
          title: const Text('Task Section'),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: selectedTheme == 'Light' ? null : deffaultUIElemetsColour,
              size: 20.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Add Task',
                  style: TextStyle(fontSize: 20.0),
                ),
                MyInputField(
                  title: 'Title',
                  hint: 'Enter your title',
                  controller: _titleController,
                ),
                MyInputField(
                  title: 'Note',
                  hint: 'Enter your note',
                  controller: _noteController,
                ),
                MyInputField(
                  title: 'Date',
                  hint: _selectedDateToString,
                  widget: IconButton(
                    icon: const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _getDateFromUser();
                      });
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: MyInputField(
                        title: 'Start Time',
                        hint: _startTime,
                        widget: IconButton(
                          icon: const Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _getTimeFromUser(isStartTime: true);
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Expanded(
                      child: MyInputField(
                        title: 'End Time',
                        hint: _endTime,
                        widget: IconButton(
                          icon: const Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            _getTimeFromUser(isStartTime: false);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                MyInputField(
                  title: 'Remind',
                  hint: '$_selectedReminder minutes early',
                  widget: DropdownButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    iconSize: 32,
                    elevation: 4,
                    underline: Container(
                      height: 0.0,
                    ),
                    items: remindList.map<DropdownMenuItem<String>>(
                      (int value) {
                        return DropdownMenuItem<String>(
                          value: value.toString(),
                          child: Text(value.toString()),
                        );
                      },
                    ).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedReminder = int.parse(newValue!);
                      });
                    },
                  ),
                ),
                MyInputField(
                  title: 'Repeat',
                  hint: _selectedRepeat,
                  widget: DropdownButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    iconSize: 32,
                    elevation: 4,
                    underline: Container(
                      height: 0.0,
                    ),
                    items: repeatList.map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRepeat = newValue!;
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  decoration: BoxDecoration(
                    color: deffaultUIElemetsColour,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: MaterialButton(
                    minWidth: 150.0,
                    onPressed: () {
                      _validateData();
                    },
                    child: const Text(
                      'Create Task',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
        _selectedDateToString =
            "${_selectedDate.day.toString().padLeft(2, '0')}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.year.toString()}";
      });
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print('Time Canceled');
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        //startTime --> 10:30 AM
        hour: _selectedTime.hour,
        minute: _selectedTime.minute,
//        hour: int.parse(_startTime.split(":")[0]),
//        minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
      ),
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
  }

  _validateData() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      addEvent();
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      Navigator.pop(context);
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      // ignore: deprecated_member_use
      _scaffoldKey.currentState!.showSnackBar(SnackBar(
        content: Row(
          children: const [
            Icon(
              Icons.warning_amber_outlined,
              color: Colors.white,
            ),
            Text('   All fields are Required'),
          ],
        ),
        backgroundColor: Colors.red,
      ));
    }
  }
}

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  MyInputField(
      {required this.title, required this.hint, this.controller, this.widget});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          Container(
            height: 52.0,
            margin: EdgeInsets.only(top: 8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      readOnly: widget == null ? false : true,
                      autofocus: false,
                      controller: controller,
                      decoration: InputDecoration(
                          hintText: hint,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: selectedTheme == 'Light'
                                  ? Colors.white
                                  : Colors.black26,
                              width: 0,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: selectedTheme == 'Light'
                                  ? Colors.white
                                  : Colors.black26,
                              width: 0,
                            ),
                          )),
                    ),
                  ),
                ),
                widget == null
                    ? Container()
                    : Container(
                        child: widget,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

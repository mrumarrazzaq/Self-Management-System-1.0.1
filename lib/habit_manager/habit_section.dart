import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:self_management_systam/project_constants/constants.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'habit_progress_criteria.dart';
import 'package:self_management_systam/habit_manager/habit_constants.dart';

List<Widget> customHabits = [];

var heightOfModalBottomSheet;

String customCategoryName = 'New Category';
Color customCategoryColor = deffaultUIElemetsColour;
IconData customCategoryIcon = Icons.more_horiz;

final categoryNameController = TextEditingController();

class HabitSection extends StatefulWidget {
  static const String id = 'HabitSection';

  @override
  State<HabitSection> createState() => _HabitSectionState();
}

class _HabitSectionState extends State<HabitSection> {
  int totalCustomHabits = 0;
  bool isDefaultVisible = false;
  bool isCustomVisible = false;
  bool isDefaultHabitsVisible = false;
  bool isCustomHabitsVisible = false;
  IconData iconData = Icons.arrow_drop_down;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: selectedTheme == 'Light' ? ThemeData.light() : ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            'Select a category for your habit',
            style: TextStyle(color: deffaultUIElemetsColour),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Card(
                    elevation: 2.0,
                    child: ListTile(
                      title: const Text(
                        'Default Category',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          iconData,
                          size: 25.0,
                        ),
                        color: deffaultUIElemetsColour,
                        onPressed: () {
                          setState(() {
                            isDefaultVisible = !isDefaultVisible;
                            isDefaultVisible
                                ? iconData = Icons.arrow_drop_up
                                : iconData = Icons.arrow_drop_down;
                            isDefaultHabitsVisible = !isDefaultHabitsVisible;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: isDefaultHabitsVisible,
                  child: Column(
                    children: [
                      HabitCategory(
                        title: defaultHabitsCategories[0],
                        image: Image.asset(
                          'defaultHabits/quit a bad habit.png',
                          height: 25.0,
                          width: 25.0,
                        ),
                      ),
                      HabitCategory(
                        title: defaultHabitsCategories[1],
                        image: Image.asset(
                          'defaultHabits/entertainment.png',
                          height: 25.0,
                          width: 25.0,
                        ),
                      ),
                      HabitCategory(
                        title: defaultHabitsCategories[2],
                        image: Image.asset(
                          'defaultHabits/health.png',
                          height: 25.0,
                          width: 25.0,
                        ),
                      ),
                      HabitCategory(
                        title: defaultHabitsCategories[3],
                        image: Image.asset(
                          'defaultHabits/home.png',
                          height: 25.0,
                          width: 25.0,
                        ),
                      ),
                      HabitCategory(
                        title: defaultHabitsCategories[4],
                        image: Image.asset(
                          'defaultHabits/art.png',
                          height: 25.0,
                          width: 25.0,
                        ),
                      ),
                      HabitCategory(
                        title: defaultHabitsCategories[5],
                        image: Image.asset(
                          'defaultHabits/sport.png',
                          height: 25.0,
                          width: 25.0,
                        ),
                      ),
                      HabitCategory(
                        title: defaultHabitsCategories[6],
                        image: Image.asset(
                          'defaultHabits/outdoor.png',
                          height: 25.0,
                          width: 25.0,
                        ),
                      ),
                      HabitCategory(
                        title: defaultHabitsCategories[7],
                        image: Image.asset(
                          'defaultHabits/meditation.png',
                          height: 25.0,
                          width: 25.0,
                        ),
                      ),
                      HabitCategory(
                        title: defaultHabitsCategories[8],
                        image: Image.asset(
                          'defaultHabits/social.png',
                          height: 25.0,
                          width: 25.0,
                        ),
                      ),
                      HabitCategory(
                        title: defaultHabitsCategories[9],
                        image: Image.asset(
                          'defaultHabits/work.png',
                          height: 25.0,
                          width: 25.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 2.0,
                  child: ListTile(
                    leading: Text(
                      '$totalCustomHabits',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    title: const Text(
                      'Custom Category',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        iconData,
                        size: 25.0,
                      ),
                      color: deffaultUIElemetsColour,
                      onPressed: () {
                        setState(() {
                          isCustomVisible = !isCustomVisible;
                          isCustomVisible
                              ? iconData = Icons.arrow_drop_up
                              : iconData = Icons.arrow_drop_down;
                          isCustomHabitsVisible = !isCustomHabitsVisible;
                        });
                      },
                    ),
                  ),
                ),
                Visibility(
                  visible: isCustomHabitsVisible,
                  child: Column(
                    children: customHabits,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 200.0, top: 5.0, left: 3.0),
                  child: ListTile(
                    tileColor: Color(0xffd4d4d4).withOpacity(0.1),
                    title: Text('Create Category'),
                    trailing: Icon(Icons.add_circle_outline),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Colors.white70.withOpacity(0.1), width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onTap: () {
                      setState(() {
                        showModalBottomSheet(
                            context: context, builder: buildBottomSheet);
                      });
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Center(
                child: TextButton(
                  child: Text(
                    'CANCEL',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBottomSheet(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Container(
      color: Colors.black54,
      child: Container(
        margin: EdgeInsets.all(5.0),
        height: 350.0,
        child: Column(
          children: [
            ListTile(
              leading: Text(
                '|',
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: customCategoryColor,
                    fontSize: 20.0),
              ),
              title: Text(customCategoryName),
              trailing: Container(
                  height: 30.0,
                  width: 30.0,
                  decoration: BoxDecoration(
                    color: customCategoryColor.withOpacity(0.3),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Icon(customCategoryIcon, color: customCategoryColor)),
            ),
            const Divider(),
            //Category Name
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Category Name'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => StatefulBuilder(
                    builder: (context, setState) => AlertDialog(
                      title: const Text('New Category'),
                      content: Container(
                        height: 200.0,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        child: Column(
                          children: [
                            Form(
                              key: _formKey,
                              child: TextFormField(
                                autofocus: true,
                                style: TextStyle(
                                  color: selectedTheme == 'Light'
                                      ? darkColour
                                      : lightColour,
                                ),
                                maxLines: 3,
                                decoration: InputDecoration(
                                  labelText: 'New Category',
                                  labelStyle: TextStyle(
                                    color: selectedTheme == 'Light'
                                        ? darkColour
                                        : lightColour,
                                  ),
                                  hintText: 'New Category',
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  focusColor: Colors.white,
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        color: deffaultUIElemetsColour,
                                        width: 2.0),
                                  ),
                                ),
                                controller: categoryNameController,
                                onChanged: (value) {
                                  customCategoryName = value;
                                },
                                validator: (String? val) {
                                  if (val!.isEmpty) {
                                    return "required";
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TextButton(
                                    child: Text(
                                      'CANCEL',
                                      style: TextStyle(
                                        color: selectedTheme == 'Light'
                                            ? darkColour
                                            : lightColour,
                                      ),
                                    ),
                                    onPressed: () {
                                      customCategoryName = 'New Category';
                                      Navigator.of(context, rootNavigator: true)
                                          .pop('dialog');
                                    },
                                  ),
                                  TextButton(
                                    child: Text(
                                      'OK',
                                      style: TextStyle(
                                          color: deffaultUIElemetsColour),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        customCategoryName = customCategoryName;
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop('dialog');
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const Divider(),
            //Category Icon
            ListTile(
              leading: Icon(Icons.image_outlined),
              title: Text('Category Icon'),
              onTap: () {
                setState(() {
                  _CustomCategories();
//                  Alert(
//                    context: context,
//                    type: AlertType.none,
//                    title: "Select Icon",
//                    desc: "",
//                    content: Column(
//                      children: [
//                        TextButton(
//                          child: Icon(
//                            Icons.opacity,
//                            color: selectedTheme == 'Light'
//                                ? darkColour
//                                : lightColour,
//                          ),
//                          onPressed: () {
//                            setState(() {
//                              customCategoryIcon = Icons.opacity;
//                            });
//                            Navigator.canPop(context);
//                          },
//                        ),
//                      ],
//                    ),
//                    buttons: [
//                      DialogButton(
//                        child: const Text(
//                          "Yes",
//                          style: TextStyle(color: Colors.white, fontSize: 20),
//                        ),
//                        onPressed: () {
//                          setState(() {});
//                          Navigator.pop(context);
//                        },
//                        width: 120,
//                      ),
//                    ],
//                  ).show();
                });
              },
            ),
            const Divider(),
            //Category Color
            ListTile(
              leading: Icon(Icons.opacity),
              title: Text('Category Color'),
              onTap: () {
                setState(() {
                  showDialog(
                    context: context,
                    builder: (context) => StatefulBuilder(
                      builder: (context, setState) => AlertDialog(
                        title: const Text('Category Color'),
                        content: Container(
                          height: 450.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: Column(
                            children: [
                              buildColorPicker(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    child: const Text(
                                      'CANCEL',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.red,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  const SizedBox(width: 20.0),
                                  TextButton(
                                    child: Text(
                                      'SELECT',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: selectedTheme == 'Light'
                                            ? darkColour
                                            : lightColour,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        customCategoryColor =
                                            customCategoryColor;
                                      });

                                      Navigator.of(context, rootNavigator: true)
                                          .pop('dialog');
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
              },
            ),
            const Divider(),
            TextButton(
              child: Text(
                'CREATE CATEGORY',
                style: TextStyle(
                  color: deffaultUIElemetsColour,
                ),
              ),
              onPressed: () {
                setState(() {
                  totalCustomHabits++;
                  customHabits.add(
                    ListTile(
                      title: Text(customCategoryName),
                      trailing: Icon(
                        customCategoryIcon,
                        color: customCategoryColor,
                      ),
                      onTap: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HabitProgressCriteria(),
                            ),
                          );
                        });
                      },
                    ),
                  );
                  categoryNameController.clear();
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: selectedTheme == 'Light' ? lightColour : Color(0xff242424),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
      ),
    );
  }

  _CustomCategories() {
    showDialog(
      context: context,
      builder: (context) {
        String contentText = "Content of Dialog";
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Icon(Icons.check),
              content: Text(contentText),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      customCategoryIcon = Icons.check;
                      contentText = "Changed Content of Dialog";
                    });
                  },
                  child: Text("Change"),
                ),
              ],
            );
          },
        );
      },
    );
//    setState(() {
//      showDialog(
//        context: context,
//        builder: (context) => StatefulBuilder(
//          builder: (context, setState) => AlertDialog(
//            title: const Text('Category Icon'),
//            content: Container(
//              height: 150.0,
//              decoration: const BoxDecoration(
//                borderRadius: BorderRadius.all(
//                  Radius.circular(10.0),
//                ),
//              ),
//              child: TextButton(
//                child: Icon(
//                  Icons.opacity,
//                  color: selectedTheme == 'Light' ? darkColour : lightColour,
//                ),
//                onPressed: () {
//                  customCategoryIcon = Icons.opacity;
//                  Navigator.of(context).pop();
//                },
//              ),

//                          Column(
//                            children: [
//                              Row(
//                                children: [
//                                  TextButton(
//                                    child: Icon(
//                                      Icons.opacity,
//                                      color: selectedTheme == 'Light'
//                                          ? darkColour
//                                          : lightColour,
//                                    ),
//                                    onPressed: () {
//                                      customCategoryIcon = Icons.opacity;
//                                      Navigator.of(context).pop();
//                                    },
//                                  ),
//                                  TextButton(
//                                    child: Icon(
//                                      Icons.assignment,
//                                      color: selectedTheme == 'Light'
//                                          ? darkColour
//                                          : lightColour,
//                                    ),
//                                    onPressed: () {
//                                      customCategoryIcon = Icons.assignment;
//                                      Navigator.of(context).pop();
//                                    },
//                                  ),
//                                  TextButton(
//                                    child: Icon(
//                                      Icons.panorama,
//                                      color: selectedTheme == 'Light'
//                                          ? darkColour
//                                          : lightColour,
//                                    ),
//                                    onPressed: () {
//                                      customCategoryIcon = Icons.panorama;
//                                      Navigator.of(context).pop();
//                                    },
//                                  ),
//                                  TextButton(
//                                    child: Icon(
//                                      Icons.home,
//                                      color: selectedTheme == 'Light'
//                                          ? darkColour
//                                          : lightColour,
//                                    ),
//                                    onPressed: () {
//                                      customCategoryIcon = Icons.home;
//                                      Navigator.of(context).pop();
//                                    },
//                                  ),
//                                ],
//                              ),
//                              Row(
//                                children: [
//                                  TextButton(
//                                    child: Icon(
//                                      Icons.accessibility_new,
//                                      color: selectedTheme == 'Light'
//                                          ? darkColour
//                                          : lightColour,
//                                    ),
//                                    onPressed: () {
//                                      customCategoryIcon =
//                                          Icons.accessibility_new;
//                                      Navigator.of(context).pop();
//                                    },
//                                  ),
//                                  TextButton(
//                                    child: Icon(
//                                      Icons.whatshot,
//                                      color: selectedTheme == 'Light'
//                                          ? darkColour
//                                          : lightColour,
//                                    ),
//                                    onPressed: () {
//                                      customCategoryIcon = Icons.whatshot;
//                                      Navigator.of(context).pop();
//                                    },
//                                  ),
//                                  TextButton(
//                                    child: Icon(
//                                      Icons.account_balance,
//                                      color: selectedTheme == 'Light'
//                                          ? darkColour
//                                          : lightColour,
//                                    ),
//                                    onPressed: () {
//                                      customCategoryIcon =
//                                          Icons.account_balance;
//                                      Navigator.of(context).pop();
//                                    },
//                                  ),
//                                  TextButton(
//                                    child: Icon(
//                                      Icons.wifi_tethering,
//                                      color: selectedTheme == 'Light'
//                                          ? darkColour
//                                          : lightColour,
//                                    ),
//                                    onPressed: () {
//                                      customCategoryIcon = Icons.wifi_tethering;
//                                      Navigator.of(context).pop();
//                                    },
//                                  ),
//                                ],
//                              ),
//                              TextButton(
//                                child: Text(
//                                  'CLOSED',
//                                  style: TextStyle(
//                                    color: selectedTheme == 'Light'
//                                        ? darkColour
//                                        : lightColour,
//                                  ),
//                                ),
//                                onPressed: () {
//                                  customCategoryIcon = customCategoryIcon;
//                                  Navigator.of(context, rootNavigator: true)
//                                      .pop('dialog');
//                                },
//                              ),
//                            ],
//                          ),
//            ),
//          ),
//        ),
//      );
//    });
  }
}

Widget buildColorPicker() => StatefulBuilder(
      builder: (context, setState) => BlockPicker(
          pickerColor: customCategoryColor,
          // ignore: deprecated_member_use
          availableColors: const [
            Colors.green,
            Colors.red,
            Colors.blue,
            Colors.purple,
            Colors.orange,
            Colors.tealAccent,
            Colors.teal,
            Colors.deepOrangeAccent,
            Colors.amberAccent,
            Colors.pink,
            Colors.cyan,
            Colors.pinkAccent,
            Colors.blueGrey,
            Colors.indigo,
            Colors.indigoAccent,
            Colors.brown,
            Colors.grey,
            Colors.lightGreen,
            Colors.lime,
          ],
          onColorChanged: (color) {
            setState(() {
              customCategoryColor = color;
              Navigator.pop(context);
            });
          }),
    );

class HabitCategory extends StatefulWidget {
  HabitCategory({required this.title, required this.image});
  final String title;
  final Image image;

  @override
  State<HabitCategory> createState() => _HabitCategoryState();
}

class _HabitCategoryState extends State<HabitCategory> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
        elevation: 1.0,
        child: ListTile(
          title: Text(widget.title),
          trailing: widget.image,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white70.withOpacity(0.1), width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          onTap: () {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HabitProgressCriteria(),
                ),
              );
            });
          },
        ),
      ),
    );
  }
}

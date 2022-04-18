// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:self_management_systam/project_constants/constants.dart';

List<bool> isVisible = [false, false, false, false, false, false];
List<Icon> dropdownIcon = [
  const Icon(Icons.arrow_drop_down),
  const Icon(Icons.arrow_drop_down),
  const Icon(Icons.arrow_drop_down),
  const Icon(Icons.arrow_drop_down),
  const Icon(Icons.arrow_drop_down),
  const Icon(Icons.arrow_drop_down),
];

// ignore: use_key_in_widget_constructors
class CategoriesSection extends StatefulWidget {
  static const String id = 'Categories';
  @override
  _CategoriesSectionState createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends State<CategoriesSection> {
  @override
  Widget build(BuildContext context) {
    print("CategoriesSection Bulid Run");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: selectedTheme == 'Light' ? ThemeData.light() : ThemeData.dark(),
      home: Scaffold(
        appBar: homeCategory == 'No'
            ? AppBar(
                backgroundColor:
                    selectedTheme == 'Light' ? deffaultUIElemetsColour : null,
                title: const Text('Categories'),
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_left,
                    color: selectedTheme == 'Light'
                        ? null
                        : deffaultUIElemetsColour,
                    size: 30.0,
                  ),
                  onPressed: () {
                    homeCategory = 'Yes';
                    Navigator.pop(context);
                  },
                ),
              )
            : null,
        body: ListView(
          children: [
            ProjectsManagers(
              onTextPressed: () {},
              image: Image.asset(
                'icons/Task.png',
                color: Task,
                height: 35.0,
                width: 35.0,
              ),
              categoryName: 'Task Manager',
              categoryDetail: 'Manage your tasks schedule',
              category: 'Tasks',
              count: totalTaskAdd,
              i: 0,
              onPressed: () {
                setState(() {
                  isVisible[0] = !isVisible[0];
                  isVisible[0]
                      ? dropdownIcon[0] = const Icon(Icons.arrow_drop_up)
                      : dropdownIcon[0] = const Icon(Icons.arrow_drop_down);
                });
              },
            ),
            ProjectsManagers(
              onTextPressed: () {},
              image: Image.asset(
                'icons/Habit.png',
                color: Habit,
                height: 35.0,
                width: 35.0,
              ),
              categoryName: 'Habit Manager',
              categoryDetail: 'Manage your habits schedule',
              category: 'Habits',
              count: totalHabitAdd,
              i: 1,
              onPressed: () {
                setState(() {
                  isVisible[1] = !isVisible[1];
                  isVisible[1]
                      ? dropdownIcon[1] = const Icon(Icons.arrow_drop_up)
                      : dropdownIcon[1] = const Icon(Icons.arrow_drop_down);
                });
              },
            ),
            ProjectsManagers(
              onTextPressed: () {},
              image: Image.asset(
                'icons/Study.png',
                color: Study,
                height: 40.0,
                width: 40.0,
              ),
              categoryName: 'Study Manager',
              categoryDetail: 'Manage your study schedule',
              category: 'Studies',
              count: totalStudyAdd,
              i: 2,
              onPressed: () {
                setState(() {
                  isVisible[2] = !isVisible[2];
                  isVisible[2]
                      ? dropdownIcon[2] = const Icon(Icons.arrow_drop_up)
                      : dropdownIcon[2] = const Icon(Icons.arrow_drop_down);
                });
              },
            ),
            ProjectsManagers(
              onTextPressed: () {},
              image: Image.asset(
                'icons/Cost.png',
                color: Cost,
                height: 35.0,
                width: 35.0,
              ),
              categoryName: 'Cost Manager',
              categoryDetail: 'Manage your cost schedule',
              category: 'Costs',
              count: totalCostAdd,
              i: 3,
              onPressed: () {
                setState(() {
                  isVisible[3] = !isVisible[3];
                  isVisible[3]
                      ? dropdownIcon[3] = const Icon(Icons.arrow_drop_up)
                      : dropdownIcon[3] = const Icon(Icons.arrow_drop_down);
                });
              },
            ),
            ProjectsManagers(
              onTextPressed: () {},
              image: Image.asset(
                'icons/Project.png',
                color: Project,
                height: 35.0,
                width: 35.0,
              ),
              categoryName: 'Project Manager',
              categoryDetail: 'Manage your project schedule',
              category: 'Projects',
              count: totalProjectAdd,
              i: 4,
              onPressed: () {
                setState(() {
                  isVisible[4] = !isVisible[4];
                  isVisible[4]
                      ? dropdownIcon[4] = const Icon(Icons.arrow_drop_up)
                      : dropdownIcon[4] = const Icon(Icons.arrow_drop_down);
                });
              },
            ),
            ProjectsManagers(
              onTextPressed: () {},
              image: Image.asset(
                'icons/Meeting.png',
                color: Meeting,
                height: 35.0,
                width: 35.0,
              ),
              categoryName: 'Meetings Manager',
              categoryDetail: 'Manage your meeting schedule',
              category: 'Meetings',
              count: totalMeetingsAdd,
              i: 5,
              onPressed: () {
                setState(() {
                  isVisible[5] = !isVisible[5];
                  isVisible[5]
                      ? dropdownIcon[5] = const Icon(Icons.arrow_drop_up)
                      : dropdownIcon[5] = const Icon(Icons.arrow_drop_down);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectsManagers extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ProjectsManagers(
      {required this.image,
      required this.categoryName,
      required this.categoryDetail,
      required this.category,
      required this.count,
      required this.i,
      required this.onPressed,
      required this.onTextPressed});

  final String categoryName;
  final String categoryDetail;
  final String category;
  final int i;
  final int count;
  final Image image;
  final Function() onPressed;
  final Function() onTextPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.only(
              top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
          elevation: 4.0,
          child: Center(
            child: TextButton(
              child: ListTile(
                title: Text(categoryName),
                subtitle: Text(
                  categoryDetail,
                  style: TextStyle(
                      fontFamily: 'SourceSansPro',
                      color: selectedTheme == 'Light'
                          ? Colors.black
                          : Colors.white),
                ),
                leading: image,
                trailing: IconButton(
                  icon: dropdownIcon[i],
                  splashRadius: 20.0,
                  splashColor: deffaultUIElemetsColour.withOpacity(0.5),
                  onPressed: onPressed,
                ),
              ),
              onPressed: onTextPressed,
            ),
          ),
        ),
        Visibility(
          visible: isVisible[i],
          child: Text('Total $category Managements : $count'),
        ),
      ],
    );
  }
}

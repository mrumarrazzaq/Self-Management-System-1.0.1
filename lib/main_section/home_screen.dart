// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_management_systam/project_constants/constants.dart';
import 'package:self_management_systam/main_section/categories_section.dart';
import 'package:self_management_systam/drawer_section/drawer_section.dart';
import 'package:self_management_systam/main_section/today_screen.dart';
import 'package:self_management_systam/main_section/completed_events.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'HomePage';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _currentIndex = 0;
  bool isAppBarVisible = true;
  final tabs = [
    const TodayScreen(),
    CategoriesSection(),
    const CompletedEvents(),
  ];

  @override
  void initState() {
    super.initState();
    const HomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    print("HomeScreen Bulid Run");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: selectedTheme == 'Light' ? ThemeData.light() : ThemeData.dark(),
      home: Scaffold(
        key: _scaffoldKey,
        drawer: const Drawer(
          elevation: 10,
          child: SafeArea(
            child: DrawerSection(),
          ),
        ),
        appBar: AppBar(
          backgroundColor:
              selectedTheme == 'Light' ? deffaultUIElemetsColour : null,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: isAppBarVisible,
                child: Text(
                  'Self Management System',
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                  ),
                ),
              ),
              Visibility(
                visible: isAppBarVisible,
                child: IconButton(
                  splashRadius: 20.0,
                  onPressed: () {
                    isAppBarVisible = !isAppBarVisible;
                  },
                  icon: const Icon(Icons.search),
                ),
              ),
            ],
          ),
        ),
        body: tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor:
              selectedTheme == 'Light' ? null : const Color(0xff4e4f4f),
          elevation: 10.0,
          currentIndex: _currentIndex,
          selectedLabelStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          selectedItemColor: deffaultUIElemetsColour,
          unselectedItemColor:
              selectedTheme == 'Light' ? darkColour : lightColour,
          unselectedLabelStyle: const TextStyle(fontFamily: 'SourceSansPro'),
          selectedFontSize: 10.0,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.today),
              label: 'Today',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.done),
              label: 'Completed',
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}

// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';

import 'package:self_management_systam/drawer_section/customize_section.dart';
import 'package:self_management_systam/main_section/today_screen.dart';
import 'package:self_management_systam/main_section/categories_section.dart';
import 'package:self_management_systam/drawer_section/settings_section.dart';
import 'package:self_management_systam/drawer_section/lock_pin.dart';
import 'package:self_management_systam/drawer_section/pin_section.dart';
import 'package:self_management_systam/project_constants/constants.dart';
import 'package:self_management_systam/drawer_section/user_profile.dart';

import 'package:self_management_systam/security_section/welcome_screen.dart';
import 'package:self_management_systam/security_section/register_screen.dart';
import 'package:self_management_systam/security_section/signin_screen.dart';
import 'package:self_management_systam/security_section/forgot_password.dart';
import 'package:self_management_systam/drawer_section/change_password.dart';
import 'package:self_management_systam/main_section/home_screen.dart';
import 'package:self_management_systam/habit_manager/habit_section.dart';
import 'package:self_management_systam/main_section/completed_events.dart';

import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'writeFile.dart';
import 'readFile.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

//
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("MyApp Bulid Run");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Self Management System',
      theme: selectedTheme == 'Light' ? ThemeData.light() : ThemeData.dark(),
//        initialRoute: isUserLogout ? WelcomeScreen.id : HomePage.id,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        SigninScreen.id: (context) => const SigninScreen(),
        RegisterScreen.id: (context) => const RegisterScreen(),
        ForgotPassword.id: (context) => const ForgotPassword(),
        ChangePassword.id: (context) => const ChangePassword(),
        HomeScreen.id: (context) => const HomeScreen(),
        TodayScreen.id: (context) => const TodayScreen(),
        HabitSection.id: (context) => HabitSection(),
        CategoriesSection.id: (context) => CategoriesSection(),
        Customize.id: (context) => Customize(),
        SettingsScreen.id: (context) => SettingsScreen(),
        LockPin.id: (context) => const LockPin(),
        Pin.id: (context) => const Pin(),
        UserProfile.id: (context) => const UserProfile(),
        WriteData.id: (context) => WriteData(),
        ReadData.id: (context) => ReadData(),
        CompletedEvents.id: (context) => const CompletedEvents(),
      },
    );
  }
}

//class MyApp extends StatelessWidget {
//  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
////  final storage = FlutterSecureStorage();
//
//  Future<bool> checkLoginStatus() async {
////    String? value = await storage.read(key: 'uid');
////    String? colorValue = await storage.read(key: 'color');
////    deffaultUIElemetsColour = Color(int.parse(colorValue!));
////    if (value == null) {
////      return false;
////    } else {
////      return true;
////    }
//    return true;
//  }
//
//  delete() async {
////    await storage.delete(key: 'uid');
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return FutureBuilder(
//        future: _initialization,
//        builder: (context, snapshot) {
//          //Check for errrors
//          if (snapshot.hasError) {
//            print('Something went wrong.');
//          }
//          if (snapshot.connectionState == ConnectionState.done) {
//            return ChangeNotifierProvider(
//              create: (context) => TaskOperations(),
//              child: MaterialApp(
//                debugShowCheckedModeBanner: false,
//                title: 'Self Management System',
//                theme: selectedTheme == 'Light'
//                    ? ThemeData.light()
//                    : ThemeData.dark(),
////        initialRoute: WelcomeScreen.id,
//                routes: {
//                  WelcomeScreen.id: (context) => WelcomeScreen(),
//                  SigninScreen.id: (context) => SigninScreen(),
//                  RegisterScreen.id: (context) => RegisterScreen(),
//                  ForgotPassword.id: (context) => ForgotPassword(),
//                  ChangePassword.id: (context) => ChangePassword(),
//                  HomePage.id: (context) => HomePage(),
//                  TodayPage.id: (context) => TodayPage(),
//                  HabitSection.id: (context) => HabitSection(),
//                  Categories.id: (context) => Categories(),
//                  Customize.id: (context) => Customize(),
//                  SettingsScreen.id: (context) => SettingsScreen(),
//                  LockPin.id: (context) => LockPin(),
//                  Pin.id: (context) => Pin(),
//                  UserProfile.id: (context) => UserProfile(),
//                  WriteData.id: (context) => WriteData(),
//                  ReadData.id: (context) => ReadData(),
//                  CompletedTodos.id: (context) => CompletedTodos(),
//                },
//                home: FutureBuilder(
//                  future: checkLoginStatus(),
//                  builder:
//                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
//                    if (snapshot.data == false) {
//                      print('Welcome Screen called');
//                      return WelcomeScreen();
//                    }
//                    if (snapshot.connectionState == ConnectionState.waiting) {
//                      return Scaffold(
//                          body: Center(
//                              child: CircularProgressIndicator(
//                        color: deffaultUIElemetsColour,
//                        strokeWidth: 2.0,
//                      )));
//                    }
////                    delete();
//                    print('future Builder called');
//                    return HomePage();
////                    HomePage
//                  },
//                ),
//              ),
//            );
//          }
//          return CircularProgressIndicator();
//        });
//  }
//}

//Old Code
//ChangeNotifierProvider(
//create: (context) => TaskOperations(),
//child: MaterialApp(
//debugShowCheckedModeBanner: false,
//theme: selectedTheme == 'Light' ? ThemeData.light() : ThemeData.dark(),
//        initialRoute: WelcomeScreen.id,
//routes: {
//WelcomeScreen.id: (context) => WelcomeScreen(),
//SigninScreen.id: (context) => SigninScreen(),
//RegisterScreen.id: (context) => RegisterScreen(),
//ForgotPassword.id: (context) => ForgotPassword(),
//ChangePassword.id: (context) => ChangePassword(),
//HomePage.id: (context) => HomePage(),
//TodayPage.id: (context) => TodayPage(),
//HabitSection.id: (context) => HabitSection(),
//Categories.id: (context) => Categories(),
//Customize.id: (context) => Customize(),
//SettingsScreen.id: (context) => SettingsScreen(),
//LockPin.id: (context) => LockPin(),
//Pin.id: (context) => Pin(),
//UserProfile.id: (context) => UserProfile(),
//WriteData.id: (context) => WriteData(),
//ReadData.id: (context) => ReadData(),
//CompletedTodos.id: (context) => CompletedTodos(),
//},
//home: FutureBuilder(
//future: checkLoginStatus(),
//builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
//if (snapshot.data == false) {
//return WelcomeScreen();
//}
//if (snapshot.connectionState == ConnectionState.waiting) {
//return CircularProgressIndicator();
//}
//return HomePage();
//},
//),
//),
//);

//class MyApp extends StatelessWidget {
//  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
//
//  final storage = new FlutterSecureStorage();
//
//  bool hasInternet = false;
//  ConnectivityResult result = ConnectivityResult.none;
//
//  checkInterent() async {
//    hasInternet = await InternetConnectionChecker().hasConnection;
//    final text = hasInternet ? 'Connected' : 'No Internet';
//    final color = hasInternet ? Colors.green : Colors.red;
//
//    result = await Connectivity().checkConnectivity();
//
//    if (result == ConnectivityResult.mobile) {
//      showSimpleNotification(
//        Text(
//          '$text to Mobile Data',
//          style: TextStyle(color: Colors.white, fontSize: 20),
//        ),
//        background: color,
//      );
//    } else if (result == ConnectivityResult.wifi) {
//      showSimpleNotification(
//        Text(
//          '$text to Wifi Network',
//          style: TextStyle(color: Colors.white, fontSize: 20),
//        ),
//        background: color,
//      );
//    } else {
//      showSimpleNotification(
//        Text(
//          '$text: Kindly Connect to Internet or Data',
//          style: TextStyle(color: Colors.white, fontSize: 20),
//        ),
//        background: color,
//      );
//    }
//  }
//
//  Future<bool> checkingLoginStatus() async {
//    checkInterent();
//    String? value = await storage.read(key: 'uid');
//    if (value == null) {
//      return false;
//    }
//    return true;
//  }
//
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return FutureBuilder(
//        future: _initialization,
//        builder: (context, snapshot) {
//          // checks for errors
//          if (snapshot.hasError) {
//            print("Somthing went wrong");
//          }
//          if (snapshot.connectionState == ConnectionState.waiting) {
//            return const Center(child: CircularProgressIndicator());
//          }
//          return OverlaySupport.global(
//            child: MaterialApp(
//              debugShowCheckedModeBanner: false,
//              title: 'Self Management System',
//              home: FutureBuilder(
//                  future: checkingLoginStatus(),
//                  builder:
//                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
//                    if (snapshot.data == false) {
////                      Navigator.push(
////                        context,
////                        MaterialPageRoute(
////                          builder: (context) => WelcomeScreen(),
////                        ),
////                      );
//                      return AnimatedSplashScreen(
//                          // duration: 10000,
//                          backgroundColor: Colors.white,
//                          // splashTransition: SplashTransition.slideTransition,
//                          splash: Lottie.asset('animations/splash_logo.json'),
//                          nextScreen: WelcomeScreen());
//                    }
//                    if (snapshot.connectionState == ConnectionState.waiting) {
//                      return Container(
//                        color: Colors.white,
//                        child: Center(
//                          child: CircularProgressIndicator(),
//                        ),
//                      );
//                    }
//                    return AnimatedSplashScreen(
//                        // duration: 10000,
//                        backgroundColor: Colors.white,
//                        // splashTransition: SplashTransition.slideTransition,
//                        splash: Lottie.asset('animations/splash_logo.json'),
//                        nextScreen: HomePage());
//                  }),
//              // home: ReadScreen(),
//            ),
//          );
//        });
//  }
//}

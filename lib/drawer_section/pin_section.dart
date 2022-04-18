// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:self_management_systam/main_section/home_screen.dart';
import 'package:self_management_systam/project_constants/constants.dart';

class Pin extends StatefulWidget {
  static const String id = 'Pin';

  const Pin({Key? key}) : super(key: key);
  @override
  _PinState createState() => _PinState();
}

class _PinState extends State<Pin> {
  bool isLength = false;
  bool isSameString = false;
  List<String> errorMassage = [];
  String matchMassage = '';
  String lengthMassage = '';
  void check() {
    if (pin == confirmPin) {
      isSameString = true;
    } else {
      setState(() {
        matchMassage = 'Pin not match';
      });
    }
    if (pin.length == 4 && confirmPin.length == 4) {
      isLength = true;
    } else {
      setState(() {
        lengthMassage = 'Pin Length is not match';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Pin Bulid Run");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: selectedTheme == 'Light' ? ThemeData.light() : ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor:
              selectedTheme == 'Light' ? deffaultUIElemetsColour : null,
          title: const Text('LockPIN'),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_left,
              size: 30.0,
            ),
            onPressed: () {
              Navigator.popAndPushNamed(context, HomeScreen.id);
            },
          ),
        ),
        body: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              matchMassage,
              style: const TextStyle(color: Colors.red),
            ),
            Text(
              lengthMassage,
              style: const TextStyle(color: Colors.red),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                style: const TextStyle(
                  color: Colors.black,
                ),
                maxLength: 4,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent,
                  hintText: 'Enter your Pin',
                  hintStyle: const TextStyle(color: Colors.grey),
                  icon: Icon(
                    Icons.vpn_key_outlined,
                    color: deffaultUIElemetsColour,
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
                onChanged: (value) {
                  pin = value;
                  print(value);
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                style: const TextStyle(
                  color: Colors.black,
                ),
                maxLength: 4,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent,
                  hintText: 'Re-enter your Pin',
                  hintStyle: const TextStyle(color: Colors.grey),
                  icon: Icon(
                    Icons.vpn_key_outlined,
                    color: deffaultUIElemetsColour,
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
                onChanged: (value) {
                  confirmPin = value;
                  print(value);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                    child: const Text('CANCEL'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    }),
                MaterialButton(
                    child: Text(
                      'CONFIRM',
                      style: TextStyle(color: deffaultUIElemetsColour),
                    ),
                    onPressed: () {
                      check();
                      if (isSameString && isLength) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      }
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

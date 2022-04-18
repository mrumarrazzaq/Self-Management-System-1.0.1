// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:self_management_systam/project_constants/constants.dart';
import 'package:self_management_systam/main_section/home_screen.dart';
import 'dart:io';

class LockPin extends StatefulWidget {
  static const String id = 'LockPin';

  const LockPin({Key? key}) : super(key: key);
  @override
  _LockPinState createState() => _LockPinState();
}

int buttonNumber = 1;

class _LockPinState extends State<LockPin> {
  List<Color> colour = [
    Colors.black54,
    Colors.black54,
    Colors.black54,
    Colors.black54
  ];
  List<String> password = [];
  List<bool> flag = [false, false, false, false];
  List<int> buttonPressed = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  // ignore: non_constant_identifier_names
  int NumberButtonPressed = 0;
  int currentState = 0;
  void check() {
    if (colour[0] == deffaultUIElemetsColour &&
        colour[1] == deffaultUIElemetsColour &&
        colour[2] == deffaultUIElemetsColour &&
        colour[3] == deffaultUIElemetsColour) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
  }

  void setDotColor() {
    if (buttonPressed[buttonNumber] < 4) {
      colour[buttonPressed[buttonNumber]] = deffaultUIElemetsColour;
      currentState = buttonPressed[buttonNumber];
      buttonPressed[buttonNumber]++;
      buttonPressed[0] = buttonPressed[buttonNumber];
      buttonPressed[1] = buttonPressed[buttonNumber];
      buttonPressed[2] = buttonPressed[buttonNumber];
      buttonPressed[3] = buttonPressed[buttonNumber];
      buttonPressed[4] = buttonPressed[buttonNumber];
      buttonPressed[5] = buttonPressed[buttonNumber];
      buttonPressed[6] = buttonPressed[buttonNumber];
      buttonPressed[7] = buttonPressed[buttonNumber];
      buttonPressed[8] = buttonPressed[buttonNumber];
      buttonPressed[9] = buttonPressed[buttonNumber];
    }
  }

  void removeDotColor() {
    colour[currentState] = Colors.black54;
    buttonPressed[buttonNumber]--;
    buttonPressed[0] = buttonPressed[buttonNumber];
    buttonPressed[1] = buttonPressed[buttonNumber];
    buttonPressed[2] = buttonPressed[buttonNumber];
    buttonPressed[3] = buttonPressed[buttonNumber];
    buttonPressed[4] = buttonPressed[buttonNumber];
    buttonPressed[5] = buttonPressed[buttonNumber];
    buttonPressed[6] = buttonPressed[buttonNumber];
    buttonPressed[7] = buttonPressed[buttonNumber];
    buttonPressed[8] = buttonPressed[buttonNumber];
    buttonPressed[9] = buttonPressed[buttonNumber];
  }

  @override
  Widget build(BuildContext context) {
    print("LockPin Bulid Run");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 150.0),
              const Icon(
                Icons.security,
                size: 100.0,
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SecretPassword(
                    colour: colour[0],
                  ),
                  SecretPassword(
                    colour: colour[1],
                  ),
                  SecretPassword(
                    colour: colour[2],
                  ),
                  SecretPassword(
                    colour: colour[3],
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              const Text(
                'Enter your Pin',
                style: TextStyle(fontSize: 20.0),
              ),
              const SizedBox(height: 100.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    color: kButtonColor,
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: const Text(
                      '1',
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        buttonNumber = 1;
                        setDotColor();
                        check();
                      });
                    },
                  ),
                  const SizedBox(width: 20.0),
                  MaterialButton(
                    color: kButtonColor,
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: const Text(
                      '2',
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        buttonNumber = 2;
                        setDotColor();
                        check();
                      });
                    },
                  ),
                  const SizedBox(width: 20.0),
                  MaterialButton(
                    color: kButtonColor,
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: const Text(
                      '3',
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        buttonNumber = 3;
                        setDotColor();
                        check();
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    color: kButtonColor,
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: const Text(
                      '4',
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        buttonNumber = 4;
                        setDotColor();
                        check();
                      });
                    },
                  ),
                  const SizedBox(width: 20.0),
                  MaterialButton(
                    color: kButtonColor,
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: const Text(
                      '5',
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        buttonNumber = 5;
                        setDotColor();
                        check();
                      });
                    },
                  ),
                  const SizedBox(width: 20.0),
                  MaterialButton(
                    color: kButtonColor,
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: const Text(
                      '6',
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        buttonNumber = 6;
                        setDotColor();
                        check();
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    color: kButtonColor,
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: const Text(
                      '7',
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        buttonNumber = 7;
                        setDotColor();
                        check();
                      });
                    },
                  ),
                  const SizedBox(width: 20.0),
                  MaterialButton(
                    color: kButtonColor,
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: const Text(
                      '8',
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        buttonNumber = 8;
                        setDotColor();
                        check();
                      });
                    },
                  ),
                  const SizedBox(width: 20.0),
                  MaterialButton(
                    color: kButtonColor,
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: const Text(
                      '9',
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        buttonNumber = 9;
                        setDotColor();
                        check();
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    color: kButtonColor,
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: const Icon(Icons.backspace),
                    onPressed: () {
                      setState(() {
                        removeDotColor();
                      });
                    },
                  ),
                  const SizedBox(width: 20.0),
                  MaterialButton(
                    color: kButtonColor,
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: const Text(
                      '0',
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        buttonNumber = 0;
                        setDotColor();
                        check();
                      });
                    },
                  ),
                  const SizedBox(width: 20.0),
                  MaterialButton(
                    color: kButtonColor,
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      setState(() {
                        exit(0);
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

class SecretPassword extends StatelessWidget {
  const SecretPassword({Key? key, this.colour = Colors.black54})
      : super(key: key);

  final Color colour;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
      height: 10.0,
      width: 10.0,
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: colour,
        borderRadius: BorderRadius.circular(50.0),
        border: Border.all(
            style: BorderStyle.solid, width: 1.0, color: Colors.white),
      ),
    );
  }
}

class ReuseableButton extends StatelessWidget {
  const ReuseableButton({Key? key, required this.text, this.bottom = 0.0})
      : super(key: key);
  final String text;
  final double bottom;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 30.0),
        ),
      ),
      margin: EdgeInsets.only(bottom: bottom),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }
}

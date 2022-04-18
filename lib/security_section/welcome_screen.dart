import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'package:self_management_systam/security_section/signin_screen.dart';
import 'package:self_management_systam/project_constants/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'WelcomeScreen';

  const WelcomeScreen({Key? key}) : super(key: key);
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    print("WelcomeScreen Bulid Run");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: selectedTheme == 'Light' ? ThemeData.light() : ThemeData.dark(),
      home: Scaffold(
        body: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: 'image',
                child: Image.asset(
                  'images/logo.png',
                  height: 80.0,
                  width: 80.0,
                  color: deffaultUIElemetsColour,
                ),
              ),
              Image.asset('images/welcometo.png',
                  width: 484.0 / 2, height: 119.0 / 2),
//              Center(
//                child:
//              ),
              Stack(
                clipBehavior: Clip.antiAlias,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Center(
                      child: Text(
                        'Self Management System',
                        style: GoogleFonts.ramaraja(fontSize: 30),
//                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      child: Lottie.asset(
                          'animations/person-working-creative.json'),
                      width: 350,
                      height: 350,
                    ),
                  ),
                ],
              ),
              Text(
                'Lets get started',
                style: GoogleFonts.varelaRound(fontSize: 30),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Welcomt to ',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    'Self Management System,',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0, top: 8.0),
                child: Center(
                  child: Text('Connect with us to become productive'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(5.0),
                      backgroundColor:
                          MaterialStateProperty.all(deffaultUIElemetsColour),
                      minimumSize:
                          MaterialStateProperty.all(const Size(150, 45)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
//                            side: BorderSide(color: Colors.red)
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterScreen.id);
                    },
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        color:
                            selectedTheme == 'Light' ? lightColour : darkColour,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(5.0),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[200]),
                      minimumSize:
                          MaterialStateProperty.all(const Size(150, 45)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(color: deffaultUIElemetsColour)),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, SigninScreen.id);
                    },
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color:
                            selectedTheme == 'Light' ? darkColour : lightColour,
                      ),
                    ),
                  ),
                ],
              ),
//              Padding(
//                padding: const EdgeInsets.symmetric(
//                    vertical: 16.0, horizontal: 35.0),
//                child: Material(
//                  color: deffaultUIElemetsColour,
//                  borderRadius: BorderRadius.circular(30.0),
//                  child: MaterialButton(
//                    onPressed: () {
//                      Navigator.pushNamed(context, SigninScreen.id);
//                    },
//                    minWidth: 280.0,
//                    height: 42.0,
//                    child: Text(
//                      'Sign In',
//                      style: TextStyle(
//                        color:
//                            selectedTheme == 'Light' ? lightColour : darkColour,
//                      ),
//                    ),
//                  ),
//                ),
//              ),
//              Padding(
//                padding: const EdgeInsets.symmetric(
//                    vertical: 16.0, horizontal: 35.0),
//                child: Material(
//                  color: deffaultUIElemetsColour,
//                  borderRadius: BorderRadius.circular(30.0),
//                  child: MaterialButton(
//                    onPressed: () {
//                      Navigator.pushNamed(context, RegisterScreen.id);
//                    },
//                    minWidth: 280.0,
//                    height: 42.0,
//                    child: Text(
//                      'Register',
//                      style: TextStyle(
//                        color:
//                            selectedTheme == 'Light' ? lightColour : darkColour,
//                      ),
//                    ),
//                  ),
//                ),
//              ),
            ],
          ),
        ),
      ),
    );
  }
}

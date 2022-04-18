// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:self_management_systam/project_constants/constants.dart';
import 'package:self_management_systam/main_section/home_screen.dart';
import 'forgot_password.dart';
import 'register_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class SigninScreen extends StatefulWidget {
  static const String id = 'SigninScreen';

  const SigninScreen({Key? key}) : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _obscureText = true;
  bool isValidEmail = false;
  bool isLoading = false;

  var email = "";
  var password = "";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
//  final storage = FlutterSecureStorage();

  String? validatePassword(value) {
    if (value.isEmpty) {
      return 'required*';
    } else if (value.length < 8) {
      return 'Should be at least 8 characters';
    } else if (value.length > 25) {
      return 'Should not be more than 25 characters';
    } else {
      return null;
    }
  }

  void showSnackBar(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Login Successfully'),
    );
    // ignore: deprecated_member_use
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  userSignin() async {
    try {
      isLoading = true;
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      //______________________________________________________________________//
      print('user credential email : ${userCredential.user?.email}');
      //STORE user id into the Local Database
//      await storage.write(key: 'uid', value: userCredential.user?.uid);
      //______________________________________________________________________//

      // ignore: deprecated_member_use
      _scaffoldKey.currentState!.showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Login Successfully",
            style: TextStyle(fontSize: 10.0, color: Colors.white),
          ),
          duration: Duration(seconds: 30),
        ),
      );
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      if (e.code == 'user-not-found') {
        // ignore: deprecated_member_use
        _scaffoldKey.currentState!.showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "No User Found for that Email",
              style: TextStyle(fontSize: 15.0, color: Colors.white),
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        setState(() {
          isLoading = false;
        });
        // ignore: deprecated_member_use
        _scaffoldKey.currentState!.showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Wrong Password Provided by User",
              style: TextStyle(fontSize: 15.0, color: Colors.white),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print("SigninScreen Bulid Run");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: selectedTheme == 'Light' ? ThemeData.light() : ThemeData.dark(),
      home: Scaffold(
        key: _scaffoldKey,
        body: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'image',
                      child: Image.asset(
                        'images/logo.png',
                        height: 100.0,
                        width: 100.0,
                        color: deffaultUIElemetsColour,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Self Management System',
                        style: GoogleFonts.ramaraja(
                          fontSize: 30,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, bottom: 20.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: const [AutofillHints.email],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(
                                color: deffaultUIElemetsColour, width: 2.0),
                          ),
                          hintText: 'Email',
                          labelText: 'Email',
                          labelStyle: TextStyle(color: deffaultUIElemetsColour),
                          prefixIcon: Icon(
                            Icons.email,
                            color: deffaultUIElemetsColour,
                          ),
                          prefixText: '  ',
                          suffixIcon: isValidEmail
                              ? const Icon(Icons.check,
                                  color: Colors.green, size: 20.0)
                              : null,
                        ),
                        controller: emailController,
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'required*'),
                          EmailValidator(errorText: 'Not a Valid Email'),
                        ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, bottom: 20.0),
                      child: TextFormField(
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          hintText: 'Password',
                          labelText: 'Password',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(
                                color: deffaultUIElemetsColour, width: 2.0),
                          ),
                          labelStyle: TextStyle(color: deffaultUIElemetsColour),
                          prefixIcon: Icon(
                            Icons.vpn_key,
                            color: deffaultUIElemetsColour,
                          ),
                          prefixText: '  ',
                          suffixIcon: GestureDetector(
                            child: _obscureText
                                ? Icon(
                                    Icons.visibility,
                                    size: 20.0,
                                    color: deffaultUIElemetsColour,
                                  )
                                : Icon(
                                    Icons.visibility_off,
                                    size: 20.0,
                                    color: deffaultUIElemetsColour,
                                  ),
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                        controller: passwordController,
                        validator: validatePassword,
                      ),
                    ),
                    // ignore: deprecated_member_use
                    Material(
                      color: deffaultUIElemetsColour,
                      borderRadius: BorderRadius.circular(30.0),
                      child: MaterialButton(
                        minWidth: 200.0,
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isValidEmail = true;
                              email = emailController.text;
                              password = passwordController.text;
                            });
                            userSignin();
                          }
                        },
                        child: isLoading
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.0,
                                  ),
                                  const SizedBox(
                                    width: 15.0,
                                  ),
                                  Text(
                                    'Please Wait...',
                                    style: TextStyle(
                                      color: selectedTheme == 'Light'
                                          ? lightColour
                                          : darkColour,
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                'Signin',
                                style: TextStyle(
                                  color: selectedTheme == 'Light'
                                      ? lightColour
                                      : darkColour,
                                ),
                              ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPassword(),
                          ),
                        )
                      },
                      child: const Text(
                        'Forgot Password ?',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have no Account? "),
                        TextButton(
                            onPressed: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterScreen(),
                                    ),
                                  )
                                },
                            child: const Text('Register'))
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

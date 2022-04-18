// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_management_systam/project_constants/constants.dart';
import 'package:self_management_systam/security_section/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final user = FirebaseFirestore.instance;

class RegisterScreen extends StatefulWidget {
  static const String id = 'RegisterScreen';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool isValidEmail = false;
  bool isLoading = false;

  var firstname = "";
  var lastname = "";
  var email = "";
  var password = "";
  var confirmPassword = "";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  registration() async {
    if (password == confirmPassword) {
      try {
        print(firstname);
        print(lastname);
        print(email);
        print(password);
        print(confirmPassword);

        isLoading = true;
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        print(userCredential);
        // ignore: deprecated_member_use
        _scaffoldKey.currentState!.showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              'Registered Successfully.. Now Login',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            duration: Duration(seconds: 3),
          ),
        );
        final registeredUser =
            // ignore: unnecessary_string_interpolations
            FirebaseFirestore.instance.collection('userData').doc('$email');

        final json = {
          'firstname': firstname,
          'lastname': lastname,
        };

//        user.collection('$email+userData').doc('$email').set(json);
        registeredUser.set(json);
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SigninScreen()),
        );
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false;
        });
        if (e.code == 'weak-password') {
          // ignore: deprecated_member_use
          _scaffoldKey.currentState!.showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                'Password Provided is too Weak!!',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
          );
        } else if (e.code == 'email-already-in-use') {
          setState(() {
            isLoading = false;
          });

          // ignore: deprecated_member_use
          _scaffoldKey.currentState!.showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                'Sorry! Account Already Exist !',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              duration: Duration(seconds: 1),
            ),
          );
        }
      }
    } else {
      setState(() {
        isLoading = false;
      });
      // ignore: deprecated_member_use
      _scaffoldKey.currentState!.showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Password and Confirm Password doesn\'t match!!',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
      );
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    print("RegisterScreen Bulid Run");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: selectedTheme == 'Light' ? ThemeData.light() : ThemeData.dark(),
      home: Scaffold(
        key: _scaffoldKey,
        body: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Form(
                key: _formKey,
                child: Column(
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
//                        TextStyle(
//                            color: deffaultUIElemetsColour, fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 20.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(
                                color: deffaultUIElemetsColour, width: 2.0),
                          ),
                          hintText: 'First Name',
                          labelText: 'First Name',
                          labelStyle: TextStyle(color: deffaultUIElemetsColour),
                          prefixIcon: Icon(
                            Icons.person,
                            color: deffaultUIElemetsColour,
                          ),
                          prefixText: '  ',
                        ),
                        controller: firstNameController,
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return "required*";
                          } else if (double.tryParse(val) != null) {
                            return 'numbers not allowed';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 20.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(
                                color: deffaultUIElemetsColour, width: 2.0),
                          ),
                          hintText: 'Last Name',
                          labelText: 'Last Name',
                          labelStyle: TextStyle(color: deffaultUIElemetsColour),
                          prefixIcon: Icon(
                            Icons.person,
                            color: deffaultUIElemetsColour,
                          ),
                          prefixText: '  ',
                        ),
                        controller: lastNameController,
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return "required*";
                          } else if (double.tryParse(val) != null) {
                            return 'numbers not allowed';
                          }
                          return null;
                        },
                      ),
                    ),
                    //Email Address
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 20.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
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
                        validator: MultiValidator(
                          [
                            RequiredValidator(errorText: 'required*'),
                            EmailValidator(errorText: 'Not a Valid Email'),
                          ],
                        ),
                      ),
                    ),
                    //Password
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 20.0),
                      child: TextFormField(
                        obscureText: _obscurePassword,
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
                            child: _obscurePassword
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
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        controller: passwordController,
                        validator: validatePassword,
                      ),
                    ),
                    //Confirm Password
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 20.0),
                      child: TextFormField(
                        obscureText: _obscureConfirmPassword,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          hintText: 'Confirm Password',
                          labelText: 'Confirm Password',
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
                            child: _obscureConfirmPassword
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
                                _obscureConfirmPassword =
                                    !_obscureConfirmPassword;
                              });
                            },
                          ),
                        ),
                        controller: confirmPasswordController,
                        validator: validatePassword,
                      ),
                    ),
                    //Register Button
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
                              firstname = firstNameController.text;
                              lastname = lastNameController.text;
                              email = emailController.text;
                              password = passwordController.text;
                              confirmPassword = confirmPasswordController.text;
                            });
                            registration();
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
                                'Register',
                                style: TextStyle(
                                  color: selectedTheme == 'Light'
                                      ? lightColour
                                      : darkColour,
                                ),
                              ),
                      ),
                    ),

                    //Other options
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an Account? "),
                        TextButton(
                            onPressed: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SigninScreen(),
                                    ),
                                  )
                                },
                            child: const Text('Signin'))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

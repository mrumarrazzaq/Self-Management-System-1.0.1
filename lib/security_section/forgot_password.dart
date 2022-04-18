// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:self_management_systam/security_section/signin_screen.dart';
import 'package:self_management_systam/security_section/register_screen.dart';
import 'package:self_management_systam/project_constants/constants.dart';

class ForgotPassword extends StatefulWidget {
  static const String id = 'ForgotPassword';
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  var email = "";

  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            'Password Reset Email has been sent !',
            style: TextStyle(fontSize: 10.0, color: Colors.white),
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'No user found for that email.',
              style: TextStyle(fontSize: 10.0, color: Colors.white),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print("ForgotPassword Bulid Run");
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            selectedTheme == 'Light' ? deffaultUIElemetsColour : null,
        title: const Text('Reset Password'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_left,
            color: selectedTheme == 'Light' ? null : deffaultUIElemetsColour,
            size: 30.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            child: const Text(
              'Reset Link will be sent to your email id !',
              style: TextStyle(fontSize: 15.0),
            ),
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        autofocus: false,
                        decoration: InputDecoration(
                          labelText: 'Email: ',
                          labelStyle: const TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: Colors.blueGrey, width: 2.0),
                          ),
                          errorStyle:
                              const TextStyle(color: Colors.red, fontSize: 15),
                        ),
                        controller: emailController,
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'Required*'),
                          EmailValidator(errorText: 'Not a Valid Email'),
                        ]),
                      ),
                    ),
                    Material(
                      color: deffaultUIElemetsColour,
                      borderRadius: BorderRadius.circular(10.0),
                      child: MaterialButton(
                        minWidth: 200.0,
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              email = emailController.text;
                            });
                            resetPassword();
                          }
                        },
                        child: const Text(
                          'Send Email',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have no Account? "),
                            TextButton(
                                onPressed: () => {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, a, b) =>
                                                const RegisterScreen(),
                                            transitionDuration:
                                                const Duration(seconds: 1),
                                          ),
                                          (route) => false)
                                    },
                                child: const Text('Register'))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have no Account? "),
                            TextButton(
                                onPressed: () => {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, a, b) =>
                                                const SigninScreen(),
                                            transitionDuration:
                                                const Duration(seconds: 1),
                                          ),
                                          (route) => false)
                                    },
                                child: const Text('Signin'))
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:self_management_systam/security_section/welcome_screen.dart';
import 'package:self_management_systam/project_constants/constants.dart';

class ChangePassword extends StatefulWidget {
  static const String id = 'ChangePassword';
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  var newPassword = "";
  final newPasswordController = TextEditingController();

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
    newPasswordController.dispose();
    super.dispose();
  }

  // final currentUser = FirebaseAuth.instance.currentUser;
  // changePassword() async {
  //   try {
  //     await currentUser!.updatePassword(newPassword);
  //     FirebaseAuth.instance.signOut();
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => Login()),
  //     );
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         backgroundColor: Colors.orangeAccent,
  //         content: Text(
  //           'Your Password has been Changed. Login again !',
  //           style: TextStyle(fontSize: 18.0),
  //         ),
  //       ),
  //     );
  //   } catch (e) {}
  // }

  final currentUser = FirebaseAuth.instance.currentUser;

  changePassword() async {
    try {
      await currentUser!.updatePassword(newPassword);
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            'Your Password has been Changed. Login again !',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      );
      // ignore: empty_catches
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: selectedTheme == 'Light' ? ThemeData.light() : ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor:
              selectedTheme == 'Light' ? deffaultUIElemetsColour : null,
          title: const Text('Change Password'),
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
        body: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, bottom: 20.0, top: 50.0),
                    child: TextFormField(
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: 'New Password',
                        labelText: 'New Password',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: Colors.blueGrey, width: 2.0),
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
                      controller: newPasswordController,
                      validator: validatePassword,
                    ),
                  ),
                  // ignore: deprecated_member_use
                  Material(
                    color: deffaultUIElemetsColour,
                    borderRadius: BorderRadius.circular(10.0),
                    child: MaterialButton(
                      minWidth: 200.0,
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            newPassword = newPasswordController.text;
                          });
                          changePassword();
                        }
                      },
                      child: const Text('Change Password'),
                    ),
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

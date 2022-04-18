import 'package:flutter/material.dart';
import 'package:self_management_systam/drawer_section/customize_section.dart';
import 'change_password.dart';
import 'package:self_management_systam/project_constants/constants.dart';

// ignore: use_key_in_widget_constructors
class SettingsScreen extends StatefulWidget {
  static const String id = 'Settings';
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool flag = false;
  String? pin;
  String? confirmpin;

  void validate() {
    if (formkey.currentState!.validate()) {
//      print('validated');
      if (confirmpin == pin) {
        flag = true;
      }
    } else {
//      print('Not validated');
    }
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
          title: const Text('Setting'),
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
        body: ListView(
          children: [
            // ignore: deprecated_member_use
            FlatButton(
              child: SettingCard(
                icon: Icon(
                  Icons.list,
                  color: deffaultUIElemetsColour,
                ),
                text: 'Manage List',
              ),
              onPressed: () {},
            ),
            const Divider(),
            // ignore: deprecated_member_use
            FlatButton(
              child: SettingCard(
                icon: Icon(
                  Icons.notifications,
                  color: deffaultUIElemetsColour,
                ),
                text: 'Notifications and Alarms',
              ),
              onPressed: () {},
            ),
            const Divider(),
            // ignore: deprecated_member_use
            FlatButton(
              child: SettingCard(
                icon: Icon(
                  Icons.color_lens,
                  color: deffaultUIElemetsColour,
                ),
                text: 'Customize',
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Customize(),
                  ),
                );
              },
            ),
            const Divider(),
            // ignore: deprecated_member_use
            FlatButton(
              child: SettingCard(
                icon: Icon(
                  Icons.lock,
                  color: deffaultUIElemetsColour,
                ),
                text: 'LockPin',
              ),
              onPressed: () {
                openPINDialog();
              },
            ),
            const Divider(),
            // ignore: deprecated_member_use
            FlatButton(
              child: SettingCard(
                icon: Icon(
                  Icons.vpn_key,
                  color: deffaultUIElemetsColour,
                ),
                text: 'Change Password',
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChangePassword(),
                  ),
                );
              },
            ),
            const Divider(),
            // ignore: deprecated_member_use
            FlatButton(
              child: SettingCard(
                icon: Icon(
                  Icons.backup,
                  color: deffaultUIElemetsColour,
                ),
                text: 'Backups',
              ),
              onPressed: () {},
            ),
            const Divider(),
            // ignore: deprecated_member_use
            FlatButton(
              child: SettingCard(
                icon: Icon(
                  Icons.info,
                  color: deffaultUIElemetsColour,
                ),
                text: 'Licenses',
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Future openPINDialog() => showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: const Text('Lock PIN'),
            content: SizedBox(
              height: 163.0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      style: TextStyle(
                        color:
                            selectedTheme == 'Light' ? darkColour : lightColour,
                      ),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Security PIN',
                        labelStyle: TextStyle(
                          color: selectedTheme == 'Light'
                              ? darkColour
                              : lightColour,
                        ),
                        hintText: 'Security PIN',
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.transparent,
                        focusColor: Colors.white,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color: deffaultUIElemetsColour, width: 2.0),
                        ),
                      ),
                      onChanged: (value) {
                        pin = value;
                      },
//                      validator: MultiValidator(
//                        [
//                          RequiredValidator(errorText: 'required*'),
//                          LengthRangeValidator(
//                              min: 4, max: 4, errorText: 'PIN of 4 Charachers')
//                        ],
//                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      style: TextStyle(
                        color:
                            selectedTheme == 'Light' ? darkColour : lightColour,
                      ),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Confirm Security PIN',
                        labelStyle: TextStyle(
                          color: selectedTheme == 'Light'
                              ? darkColour
                              : lightColour,
                        ),
                        hintText: 'Confirm Security PIN',
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.transparent,
                        focusColor: Colors.white,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color: deffaultUIElemetsColour, width: 2.0),
                        ),
                      ),
                      onChanged: (value) {
                        confirmpin = value;
                      },
//                      validator: MultiValidator(
//                        [
//                          RequiredValidator(errorText: 'required*'),
//                          LengthRangeValidator(
//                              min: 4, max: 4, errorText: 'PIN of 4 Charachers')
//                        ],
//                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                },
                child: const Text(
                  'CANCEL',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  {
                    Navigator.of(context, rootNavigator: true).pop('dialog');
                  }
                },
                child: const Text(
                  'CONFIRM',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
        ),
      );
}

class SettingCard extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const SettingCard({required this.icon, required this.text});
  final Icon icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(text),
    );
  }
}

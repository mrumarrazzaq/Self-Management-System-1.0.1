import 'package:flutter/material.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:self_management_systam/drawer_section/customize_section.dart';
import 'settings_section.dart';
import 'package:self_management_systam/main_section/categories_section.dart';
import 'package:self_management_systam/project_constants/constants.dart';
import 'package:self_management_systam/drawer_section/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'privacy_policy.dart';
import 'package:self_management_systam/security_section/signin_screen.dart';

final registeredEmail = FirebaseAuth.instance.currentUser!.email;

class DrawerSection extends StatefulWidget {
  const DrawerSection({Key? key}) : super(key: key);

//  Future<User?> readUser() async {
//    final docUser =
//        FirebaseFirestore.instance.collection('user').doc('$registeredEmail');
//    final snapshot = await docUser.get();
//    if (snapshot.exists) {
//      return User.fromJson(snapshot.data()!);
//    }
//  }

  @override
  State<DrawerSection> createState() => _DrawerSectionState();
}

class _DrawerSectionState extends State<DrawerSection> {
//  final Stream<QuerySnapshot> registeredUser =
//      FirebaseFirestore.instance.collection('$registeredEmail').snapshots();

//  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPictureSize: const Size.square(70.0),
            decoration: selectedTheme == 'Light'
                ? const BoxDecoration(color: Colors.white)
                : const BoxDecoration(color: Colors.transparent),
            currentAccountPicture: const CircleAvatar(
//              backgroundImage: ExactAssetImage('images/profile.jpg'),
                ),
            accountName: const Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: Text('Name'),
//                ReadData(registeredUser: registeredUser)
            ),
            accountEmail: Text(
              '$registeredEmail',
              style: selectedTheme == 'Light'
                  ? const TextStyle(color: Colors.black)
                  : null,
            ),
          ),
          // ignore: deprecated_member_use
          FlatButton(
            color: deffaultUIElemetsColour.withOpacity(0.2),
            child: ListTile(
              leading: Icon(
                Icons.home,
                color: deffaultUIElemetsColour,
              ),
              title: const Text('Home'),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          const Divider(
            indent: 10.0,
            endIndent: 10.0,
            thickness: 0.5,
          ),
          // ignore: deprecated_member_use
          FlatButton(
            child: const ListTile(
              leading: Icon(Icons.manage_accounts),
              title: Text('Profile'),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserProfile(),
                ),
              );
            },
          ),
          const Divider(
            indent: 10.0,
            endIndent: 10.0,
            thickness: 0.5,
          ),
          // ignore: deprecated_member_use
          FlatButton(
            child: const ListTile(
              leading: Icon(Icons.category),
              title: Text('Categories'),
            ),
            onPressed: () {
              homeCategory = 'No';
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoriesSection(),
                ),
              );
            },
          ),
          const Divider(
            indent: 10.0,
            endIndent: 10.0,
            thickness: 0.5,
          ),
          // ignore: deprecated_member_use
          FlatButton(
            child: const ListTile(
              leading: Icon(Icons.color_lens),
              title: Text('Customize'),
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
          const Divider(
            indent: 10.0,
            endIndent: 10.0,
            thickness: 0.5,
          ),
          // ignore: deprecated_member_use
          FlatButton(
            child: const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(),
                ),
              );
            },
          ),
          const Divider(
            indent: 10.0,
            endIndent: 10.0,
            thickness: 0.5,
          ),
          // ignore: deprecated_member_use
          FlatButton(
            child: const ListTile(
              leading: Icon(Icons.privacy_tip),
              title: Text('Privacy Policy'),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrivacyPolicy(),
                ),
              );
            },
          ),
          const Divider(
            indent: 10.0,
            endIndent: 10.0,
            thickness: 0.5,
          ),
          // ignore: deprecated_member_use
          FlatButton(
            child: const ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
            ),
            onPressed: () async => {
              await FirebaseAuth.instance.signOut(),
              isUserLogout = true,
//              await storage.delete(key: 'uid'),
              // ignore: avoid_print
              print('signout called'),
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SigninScreen(),
                  ),
                  (route) => false),
            },
          ),
        ],
      ),
    );
  }
}

class ReadData extends StatelessWidget {
  const ReadData({
    Key? key,
    required this.registeredUser,
  }) : super(key: key);

  final Stream<QuerySnapshot<Object?>> registeredUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: registeredUser,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Somthing went Wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(
            strokeWidth: 2.0,
            color: Colors.green,
          );
        }

        final data = snapshot.requireData;

        return Text(
          '${data.docs[index]['firstname']}  ${data.docs[index]['lastname']}',
          style: TextStyle(
            color: selectedTheme == 'Light' ? darkColour : lightColour,
          ),
        );
      },
    );
  }
}

//FutureBuilder<User?>(
//future: readUser(),
//builder: (context, snapshot) {
//if (snapshot.hasError) {
//return Text('Something went wrong');
//} else if (snapshot.hasData) {
//final user = snapshot.data;
//return user == null ? Text('No user') : buildUser(user);
//}
//},
//),
//class User {
//  final String firstname;
//  final String lastname;
//  User({required this.firstname, required this.lastname});
//  Map<String, dynamic> toJson() => {
//        'firstname': firstname,
//        'lastname': lastname,
//      };
//
//  static User fromJson(Map<String, dynamic> json) =>
//      User(firstname: json['firstname'], lastname: json['lastname']);
//}

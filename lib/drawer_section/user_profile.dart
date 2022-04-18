import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:self_management_systam/project_constants/constants.dart';

final registeredEmail = FirebaseAuth.instance.currentUser!.email;

class UserProfile extends StatefulWidget {
  static const String id = 'UserProfile';
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;
  User? user = FirebaseAuth.instance.currentUser;

  final Stream<QuerySnapshot> registeredUser =
      FirebaseFirestore.instance.collection('$registeredEmail').snapshots();

  verifyEmail() async {
    if (user != null && !user!.emailVerified) {
      await user!.sendEmailVerification();

      // ignore: deprecated_member_use
      _scaffoldKey.currentState!.showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            'Verification Email has been sent',
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: selectedTheme == 'Light' ? ThemeData.light() : ThemeData.dark(),
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor:
              selectedTheme == 'Light' ? deffaultUIElemetsColour : null,
          title: const Text('User Profile'),
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
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  'User ID: $uid',
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
              ListTile(
                title: Text(
                  'Email: $email',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              user!.emailVerified
                  ? const Text(
                      'verified',
                      style: TextStyle(fontSize: 10.0, color: Colors.blueGrey),
                    )
                  : TextButton(
                      onPressed: () => {verifyEmail()},
                      child: const Text('Verify Email'),
                    ),
//              ReadFireBaseData(registeredUser: registeredUser),
              ListTile(
                title: Text(
                  'Created: $creationTime',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReadFireBaseData extends StatelessWidget {
  const ReadFireBaseData({
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

        return ListView.builder(
          itemCount: data.size,
          itemBuilder: (context, index) {
            return Text(
              'First Name: ${data.docs[index]['firstname']} \n Last Name:   ${data.docs[index]['lastname']}',
              style: TextStyle(
                color: selectedTheme == 'Light' ? darkColour : lightColour,
              ),
            );
          },
        );
      },
    );
  }
}

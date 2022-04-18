import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:self_management_systam/project_constants/constants.dart';
import 'package:self_management_systam/main_section/home_screen.dart';

Color color = Colors.orange;

// ignore: use_key_in_widget_constructors
class Customize extends StatefulWidget {
  static const String id = 'Customize';
  @override
  _CustomizeState createState() => _CustomizeState();
}

class _CustomizeState extends State<Customize> {
  var hexColorCode = '#${deffaultUIElemetsColour.value.toRadixString(16)}';

//  final storage = FlutterSecureStorage();
//  userSettings() async {
//    await storage.write(key: 'color', value: hexColorCode);
//  }
//
//  resetUserSetting() async {
//    await storage.delete(key: 'color');
//  }

  int i = 4;
  bool isPressed = false;
  Icon defaultIcon = const Icon(Icons.panorama_fish_eye, size: kIconSize);

  List<Icon> freeIcon = [
    const Icon(Icons.panorama_fish_eye, size: kIconSize),
    const Icon(Icons.panorama_fish_eye, size: kIconSize),
    const Icon(Icons.panorama_fish_eye, size: kIconSize),
    const Icon(Icons.panorama_fish_eye, size: kIconSize),
    const Icon(Icons.star, size: 15.0),
  ];
  List<Icon> preminumIcon = [
    const Icon(Icons.panorama_fish_eye, size: kIconSize),
    const Icon(Icons.panorama_fish_eye, size: kIconSize),
    const Icon(Icons.panorama_fish_eye, size: kIconSize),
    const Icon(Icons.panorama_fish_eye, size: kIconSize),
    const Icon(Icons.panorama_fish_eye, size: kIconSize),
    const Icon(Icons.panorama_fish_eye, size: kIconSize),
    const Icon(Icons.panorama_fish_eye, size: kIconSize),
    const Icon(
      Icons.panorama_fish_eye,
      size: kIconSize,
      color: Colors.white,
    ),
  ];

  void setFreeIcons(int index) {
    for (int i = 0; i < 4; i++) {
      if (i == index) {
//        resetUserSetting();
        freeIcon[i] = const Icon(Icons.star, size: 15.0);
      } else {
        freeIcon[i] = defaultIcon;
      }
    }
  }

  void setPreminumIcons(int index) {
    for (int i = 0; i < 8; i++) {
      if (i == index) {
        if (i == 7) {
//          resetUserSetting();
          preminumIcon[i] = const Icon(
            Icons.star,
            size: 15.0,
            color: Colors.white,
          );
        } else {
          preminumIcon[i] = const Icon(Icons.star, size: 15.0);
        }
      } else {
        preminumIcon[i] = defaultIcon;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: selectedTheme == 'Light' ? ThemeData.light() : ThemeData.dark(),
        home: Scaffold(
          appBar: AppBar(
            backgroundColor:
                selectedTheme == 'Light' ? deffaultUIElemetsColour : null,
            title: const Text('Customize'),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color:
                    selectedTheme == 'Light' ? null : deffaultUIElemetsColour,
                size: 20.0,
              ),
              onPressed: () {
                setState(() {
                  if (isPressed) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                        (route) => false);
                  } else {
                    Navigator.pop(context);
                  }
                });
              },
            ),
          ),
          body: Align(
            alignment: Alignment.centerLeft,
            child: ListView(
              children: [
                ListTile(
                  title: const Text(
                    'Theme',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: DropdownButton<String>(
                    value: selectedTheme,
                    underline: Container(
                      height: 0.0,
                    ),
                    items: const [
                      DropdownMenuItem(
                        child: Text('Light'),
                        value: 'Light',
                      ),
                      DropdownMenuItem(
                        child: Text('Dark'),
                        value: 'Dark',
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedTheme = value;
                        isPressed = true;
                      });
                    },
                  ),
                ),
                const Divider(),
                Column(
                  children: [
                    const ListTile(
                      title: Text(
                        'Free accent colors',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    //Free color row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // ignore: deprecated_member_use
                        FlatButton(
                          child: FreeColorPicker(
                            icon: freeIcon[i],
                            colour: Colors.orange,
                          ),
                          onPressed: () {
                            setState(() {
                              isPressed = true;
                              deffaultUIElemetsColour = Colors.orange;
                              setFreeIcons(0);
                              setPreminumIcons(-1);
                            });
                          },
                        ),
                        // ignore: deprecated_member_use
                        FlatButton(
                          child: FreeColorPicker(
                            icon: freeIcon[1],
                            colour: const Color(0xffd40e00),
                          ),
                          onPressed: () {
                            setState(() {
                              i = 0;
                              isPressed = true;
                              deffaultUIElemetsColour = const Color(0xffd40e00);
                              setFreeIcons(1);
                              setPreminumIcons(-1);
                            });
                          },
                        ),
                        // ignore: deprecated_member_use
                        FlatButton(
                          child: FreeColorPicker(
                            icon: freeIcon[2],
                            colour: Colors.teal,
                          ),
                          onPressed: () {
                            setState(() {
                              i = 0;
                              isPressed = true;
                              deffaultUIElemetsColour = Colors.teal;
                              setFreeIcons(2);
                              setPreminumIcons(-1);
                            });
                          },
                        ),
                        // ignore: deprecated_member_use
                        FlatButton(
                          child: FreeColorPicker(
                            icon: freeIcon[3],
                            colour: Colors.blueGrey,
                          ),
                          onPressed: () {
                            setState(() {
                              i = 0;
                              isPressed = true;
                              deffaultUIElemetsColour = Colors.blueGrey;
                              setFreeIcons(3);
                              setPreminumIcons(-1);
                            });
                          },
                        ),
                      ],
                    ),
                    const Divider(),
                    const ListTile(
                      title: Text(
                        'Preminum accent colors',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    //Preminum Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // ignore: deprecated_member_use
                        FlatButton(
                          child: PreminumColorPicker(
                            icon: preminumIcon[0],
                            headerColour: Colors.green,
                          ),
                          onPressed: () {
                            setState(() {
                              i = 0;
                              isPressed = true;
                              deffaultUIElemetsColour = Colors.green;
                              setFreeIcons(-1);
                              setPreminumIcons(0);
                            });
                          },
                        ),
                        // ignore: deprecated_member_use
                        FlatButton(
                          child: PreminumColorPicker(
                            icon: preminumIcon[1],
                            headerColour: Colors.blue,
                          ),
                          onPressed: () {
                            setState(() {
                              isPressed = true;
                              deffaultUIElemetsColour = Colors.blue;
                              setFreeIcons(-1);
                              setPreminumIcons(1);
                            });
                          },
                        ),
                        // ignore: deprecated_member_use
                        FlatButton(
                          child: PreminumColorPicker(
                            icon: preminumIcon[2],
                            headerColour: Colors.amber,
                          ),
                          onPressed: () {
                            setState(() {
                              isPressed = true;
                              deffaultUIElemetsColour = Colors.amber;
                              setFreeIcons(-1);
                              setPreminumIcons(2);
                            });
                          },
                        ),
                        // ignore: deprecated_member_use
                        FlatButton(
                          child: PreminumColorPicker(
                            icon: preminumIcon[3],
                            headerColour: Colors.pink,
                          ),
                          onPressed: () {
                            setState(() {
                              isPressed = true;
                              deffaultUIElemetsColour = Colors.pink;
                              setFreeIcons(-1);
                              setPreminumIcons(3);
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // ignore: deprecated_member_use
                        FlatButton(
                          child: PreminumColorPicker(
                            icon: preminumIcon[4],
                            headerColour: Colors.indigo,
                          ),
                          onPressed: () {
                            setState(() {
                              isPressed = true;
                              deffaultUIElemetsColour = Colors.indigo;
                              setFreeIcons(-1);
                              setPreminumIcons(4);
                            });
                          },
                        ),
                        // ignore: deprecated_member_use
                        FlatButton(
                          child: PreminumColorPicker(
                            icon: preminumIcon[5],
                            headerColour: Colors.deepOrange,
                          ),
                          onPressed: () {
                            setState(() {
                              isPressed = true;
                              deffaultUIElemetsColour = Colors.deepOrange;
                              setFreeIcons(-1);
                              setPreminumIcons(5);
                            });
                          },
                        ),
                        // ignore: deprecated_member_use
                        FlatButton(
                          child: PreminumColorPicker(
                            icon: preminumIcon[6],
                            headerColour: Colors.tealAccent,
                          ),
                          onPressed: () {
                            setState(() {
                              isPressed = true;
                              deffaultUIElemetsColour = Colors.tealAccent;
                              setFreeIcons(-1);
                              setPreminumIcons(6);
                            });
                          },
                        ),
                        // ignore: deprecated_member_use
                        FlatButton(
                          child: PreminumColorPicker(
                            icon: preminumIcon[7],
                            headerColour: Colors.purple,
                          ),
                          onPressed: () {
                            setState(() {
                              isPressed = true;
                              deffaultUIElemetsColour = Colors.purple;
                              setFreeIcons(-1);
                              setPreminumIcons(7);
                            });
                          },
                        ),
                      ],
                    ),

                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      width: 100,
                      height: 100,
                    ),
                  ],
                ),
                MaterialButton(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: const Text('Pick more colors'),
                  onPressed: () {
                    pickColor(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}

class FreeColorPicker extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const FreeColorPicker({required this.icon, required this.colour});
  final Color colour;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: icon,
      width: kWidth,
      height: kHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: colour,
      ),
    );
  }
}

class PreminumColorPicker extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const PreminumColorPicker({required this.icon, required this.headerColour});

  final Color headerColour;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: icon,
      width: kWidth,
      height: kHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: headerColour,
      ),
    );
  }
}

Widget buildColorPicker() => StatefulBuilder(
      builder: (context, setState) => ColorPicker(
        paletteType: PaletteType.hueWheel,
        pickerColor: color,
        enableAlpha: false,
        // ignore: deprecated_member_use
        showLabel: false,

        onColorChanged: (color) => deffaultUIElemetsColour = color,
      ),
    );

void pickColor(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick Your Color'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildColorPicker(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text(
                    'CANCEL',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.red,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(width: 20.0),
                TextButton(
                  child: Text(
                    'SELECT',
                    style: TextStyle(
                      fontSize: 15,
                      color:
                          selectedTheme == 'Light' ? darkColour : lightColour,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                        (route) => false);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );

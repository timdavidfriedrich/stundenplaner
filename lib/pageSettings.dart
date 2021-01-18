import 'dart:ffi';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '.nicerStyle.dart';
import '.settings.dart';
import '.sharedprefs.dart';

/// Importiert eigenes Style-File
import 'main.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  //
  final prefs = SharedPrefs();
  var prefList = [
    "startNummer",
    "dark",
    "ichBin",
    "abWoche",
    "blockOnly",
    "meineKlasse",
    "meinName",
  ];

  bool neustartErforderlich = false;
  bool coronaExpand = false;

  bool xDark = false;
  bool xAbWoche = false;
  bool xBlockOnly = false;

  getPrefs() async {
    bool _xDark = await prefs.getBool("darkMode");
    bool _xAbWoche = await prefs.getBool("abWoche");
    bool _xBlockOnly = await prefs.getBool("blockOnly");
    setState(() {
      xDark = _xDark;
      xAbWoche = _xAbWoche;
      xBlockOnly = _xBlockOnly;
    });
  }

  setPrefs() async {
    await prefs.setBool("darkMode", xDark);
    await prefs.setBool("abWoche", xAbWoche);
    await prefs.setBool("blockOnly", xBlockOnly);
  }

  @override
  void initState() {
    super.initState();
    prefs.startCounter();
    getPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        elevation: 0,
        toolbarHeight: 200,
        bottom: AppBar(
          title: Text("Einstellungen", style: niceBigTitle()),
          centerTitle: true,
          leading: SizedBox(),
          elevation: 0,
          toolbarHeight: 100,
        ),
      ),
      body: Container(
        //color: Colors.red,
        padding: EdgeInsets.fromLTRB(25, 5, 25, 25),
        child: Center(
          child: Column(
            children: [
              ListTile(
                title: Text("Dunkler Modus", style: nice()),
                trailing: Switch(
                  inactiveTrackColor: t("switch_off"),
                  inactiveThumbColor: t("nice"),
                  value: xDark,
                  onChanged: (value) {
                    setState(() {
                      neustartErforderlich = true;
                      xDark = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: Row(
                  children: [
                    Text("Corona-Modus", style: nice()),
                    SizedBox(width: 10),
                    IconButton(
                        onPressed: () {
                          setState(() => coronaExpand = !coronaExpand);
                        },
                        icon:
                            Icon(Icons.help_outline_sharp, color: niceHint())),
                  ],
                ),
                subtitle: coronaExpand
                    ? Text("Einzelstunden, keine A/B-Woche.", style: niceHint())
                    : SizedBox(width: 0.01, height: 0.01),
                trailing: Switch(
                  inactiveTrackColor: t("switch_off"),
                  inactiveThumbColor: t("nice"),
                  value: xAbWoche,
                  onChanged: (value) {
                    setState(() {
                      neustartErforderlich = true;
                      xAbWoche = value;
                      xBlockOnly = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(0, 25, 0, 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: neustartErforderlich
                  ? Text("Eventuell Neustart erforderlich!", style: niceError())
                  : Text(""),
            ),
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Spacer(flex: 3),
                FlatButton(
                  height: 42,
                  minWidth: 20,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  color: t("back_button"),
                  child: Icon(Icons.arrow_back, color: t("on_back_button")),
                  onPressed: () {
                    Navigator.of(context).pop(); //popAndPushNamed();
                  },
                ),
                Spacer(flex: 1),
                FlatButton(
                  height: 42,
                  minWidth: 200,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  color: Colors.blueAccent,
                  child: Text("Speichern", style: wNice()),
                  onPressed: () {
                    print("DARK-MODE: " + xDark.toString());
                    setPrefs();
                    Navigator.of(context).pop();
                    neustartErforderlich ? main() : null;
                  },
                ),
                Spacer(flex: 3)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

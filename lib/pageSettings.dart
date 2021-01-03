import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import 'package:data_connection_checker/data_connection_checker.dart';

import '.nicerStyle.dart';

/// Importiert eigenes Style-File
import 'main.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
        child: Center(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(0, 25, 0, 25),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Spacer(flex: 3),
            FlatButton(
              height: 42,
              minWidth: 200,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              color: Colors.blueAccent,
              child: Text("Speichern", style: wNice()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Spacer(flex: 3)
          ],
        ),
      ),
    );
  }
}

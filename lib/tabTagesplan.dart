import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import 'dart:async';

import '.nicerStyle.dart';
import '.settings.dart';

tabTagesplanAppBarTitle() {
  return Text("Mein heutiger Tag", style: niceAppBarTitle());
}

tabTagesplanAppBarIcon() {
  return Colors.blueAccent;
}

class TabTagesplanBody extends StatefulWidget {
  @override
  _TabTagesplanBodyState createState() => _TabTagesplanBodyState();
}

class _TabTagesplanBodyState extends State<TabTagesplanBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      //color: t("body"),
      child: Center(
          /*
        child: FlatButton(
          height: 45,
          minWidth: 100,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: Text(
            "test",
            style: niceSwitch(Colors.white),
          ),
          color: Colors.black,
          onPressed: () {
            print("hi");
          },
        ),
        */
          ),
    ));
  }
}

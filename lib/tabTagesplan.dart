import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import 'dart:async';

import '.nicerStyle.dart';

tabTagesplanAppBarTitle() {
  return Text("Mein heutiger Tag", style: niceAppBarTitle());
  //return Text("Mein heutiger Tag", style: niceTitle(Colors.black));
}

tabTagesplanAppBarIcon() {
  return Colors.blueAccent;
}

tabTagesplanBody() {
  return Scaffold(
      body: Container(
    color: t("body"),
    child: Center(
      child: Text("Mein Tag", style: nice()),
    ),
  ));
}

tabTagesplanFab() {
  return null;
}

tabTagesplanFabLocation() {
  return null;
}

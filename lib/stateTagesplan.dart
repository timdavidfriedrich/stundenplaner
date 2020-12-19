import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import 'dart:async';

import 'nicerStyle.dart';

stateTagesplanBarTitle() {
  return Text("Mein heutiger Tag", style: niceTitle(Colors.blueAccent));
}

stateTagesplanBody() {
  return Scaffold(
      body: Container(
    color: Colors.blueAccent,
    child: Center(
      child: Text("Mein Tag", style: niceWhite),
    ),
  ));
}

stateTagesplanFab() {
  return null;
}

stateTagesplanFabLocation() {
  return null;
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import 'nicerStyle.dart';

stateTagesplanBarTitle() {
  return Text("Mein heutiger Tag", style: niceTitle);
}

stateTagesplanBody() {
  return Hero(
      tag: "body",
      child: Container(
        color: Colors.blueAccent,
        child: Center(
          child: Text("Mein Tag", style: niceWhite),
        ),
      ));
}

stateTagesplanBody2() {
  return Container(
    color: Colors.blueAccent,
    child: Center(
      child: Text("Mein Tag", style: niceWhite),
    ),
  );
}

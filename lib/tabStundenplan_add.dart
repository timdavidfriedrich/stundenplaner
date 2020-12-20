import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import '.nicerStyle.dart';

stundenplanAddOverlay() {
  return Stack(
    children: [
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
            child: Container(
          color: Color.fromRGBO(0, 0, 0, 0.2),
        )),
      )
    ],
  );
}

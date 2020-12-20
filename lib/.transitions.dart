import 'package:flutter/cupertino.dart'; //## iOS-Design-Language
import 'package:flutter/material.dart'; //## Farben, Icons, etc. (Design)
import 'package:flutter/painting.dart'; //## Schatten, Farben, etc. (spezifischer)
import 'package:flutter/rendering.dart'; //## Render-Zeug

slide(context, Offset offset, var ziel) {
  return Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 1000),
        transitionsBuilder: (context, animation, animationTime, child) {
          var curve = Curves.easeOutExpo;
          //var curveTween = CurveTween(curve: curve);
          var begin = offset;
          var end = Offset.zero;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        pageBuilder: (context, animation, animationTime) {
          return ziel;
        },
      ));
}

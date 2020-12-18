import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import 'dart:async';

import 'nicerStyle.dart';

stateTagesplanBarTitle() {
  return Text("Mein heutiger Tag", style: niceTitle);
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

class stateTagesplan extends StatefulWidget {
  @override
  _stateTagesplanState createState() => _stateTagesplanState();
}

class _stateTagesplanState extends State<stateTagesplan> {
  int currentIndex = 1; //## Legt den Start-Index fest (Start-Tab)
  var dragStopper = 0; //## Dient als Limit bei Swipe

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
            //## Gestensteuerung der BottomBar
            onPanUpdate: (details) {
              //## Erkennt Swipe (Bewegungsupdate)
              if (details.delta.dx > 0) {
                //## Positiver Wert (links nach rechts)
                setState(() {
                  //## Ändert State nach Bewegung
                  if (currentIndex > 0 && dragStopper < 1)
                    currentIndex--; //## Index-Begrenzung (Fehlervermeidung)
                  dragStopper++; //## dragStopper ist Key. Sorgt dafür, dass Befehl nur EINMAL ausgeführt wird.
                });
                print("SWIPE VON LINKS NACH RECHTS (--> Seite nach links)");
              } else if (details.delta.dx < 0) {
                //## Negativer Wert (rechts nach links)
                setState(() {
                  if (currentIndex < 2 && dragStopper < 1)
                    currentIndex++; //## erhöht Index -> Rechter State
                  dragStopper++;
                });
                print("SWIPE VON RECHTS NACH LINKS (--> Seite nach rechts)");
              }
            },
            onPanEnd: (details) {
              dragStopper =
                  0; //## Nach der Operation, Wert wieder auf 0 -> Kann erneut ausgeführt werden
            },
            child: Container(
              color: Colors.blueAccent,
              child: Center(
                child: Text("Mein Tag", style: niceWhite),
              ),
            )));
  }
}

import 'package:flutter/cupertino.dart'; //## iOS-Design-Language
import 'package:flutter/material.dart'; //## Farben, Icons, etc. (Design)
import 'package:flutter/painting.dart'; //## Schatten, Farben, etc. (spezifischer)
import 'package:flutter/rendering.dart'; //## Render-Zeug
import 'package:stundenplaner/stateStundenplan.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'dart:io';

import 'nicerStyle.dart'; //## Importiert eigenes Style-File
import 'state_Regulator.dart'; //## Importiert den State/Tab-Regulator
import 'report.dart';
import 'settings.dart';

import 'package:bottom_navy_bar/bottom_navy_bar.dart'; //## BottomBar

void main() => runApp(MaterialApp(
      //## Startet App, Setzt StartWidget
      home: AppHome(),
      //home: DefaultBottomBarController(child: Vertretungsplan()),
    ));

class AppHome extends StatelessWidget {
  //## StartWidget, Home = NavBar
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavBar(), //## NavBar
    );
  }
}

class NavBar extends StatefulWidget {
  //##
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentIndex = 1; //## Legt den Start-Index fest (Start-Tab)
  var dragStart;
  var dragUpdate;
  var dragStopper = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //## AppBar-Settings
          //leading: Icon(Icons.menu),
          title: barStates[currentIndex],
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.error_outline_sharp,
                          color: Colors.black, size: 25),
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Report()));
                      },
                    ),
                    //SizedBox(width: 15,),
                    IconButton(
                      icon: Icon(Icons.settings_outlined,
                          color: Colors.black, size: 25),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Settings()));
                      },
                    ),
                  ],
                ))
          ],
          backgroundColor: Colors.white,
          elevation: 0, //## Lässt den Schwebeeffekt/Schatten verschwinden
        ),
        body: bodyStates[
            currentIndex], //## Ruft jeweiligen State/Tag für den Body auf

        bottomNavigationBar: GestureDetector(
          onPanUpdate: (details) {
            if (details.delta.dx > 0) {
              setState(() {
                if (currentIndex > 0 && dragStopper < 1) currentIndex--;
                dragStopper++;
              });
              print("LINKS");
            } else if (details.delta.dx < 0) {
              setState(() {
                if (currentIndex < 2 && dragStopper < 1) currentIndex++;
                dragStopper++;
              });
              print("RECHTS");
            }
          },
          onPanEnd: (details) {
            dragStopper = 0;
          },
          child: BottomNavyBar(
            //## BottomBar-Settings
            showElevation: false,
            animationDuration: Duration(milliseconds: 420),
            curve: Curves.easeInOut,
            mainAxisAlignment:
                MainAxisAlignment.spaceAround, //## Rand um die Items
            selectedIndex:
                currentIndex, //## Erkennt den aktuellen Index (int, s.o.)
            onItemSelected: (index) {
              //## Ändert den aktuellen Index bei Knopfdruck
              setState(() {
                currentIndex = index;
              });
            },
            items: <BottomNavyBarItem>[
              //## Der Inhalt der BottomBar (Items)
              BottomNavyBarItem(
                  icon: Icon(Icons.date_range_sharp),
                  title: Text(
                    "Stundenplan",
                    style: niceBar,
                  ),
                  activeColor: Colors.redAccent,
                  inactiveColor: Colors.black,
                  textAlign: TextAlign.center),
              BottomNavyBarItem(
                  icon: Icon(Icons.home_outlined),
                  title: Text("Mein Tag", style: niceBar),
                  activeColor: Colors.blueAccent,
                  inactiveColor: Colors.black,
                  textAlign: TextAlign.center),
              BottomNavyBarItem(
                  icon: Icon(Icons.list_alt_sharp),
                  title: Text("Vertretung", style: niceBar),
                  activeColor: Colors.greenAccent[700],
                  inactiveColor: Colors.black,
                  textAlign: TextAlign.center),
            ],
          ),
        ));
  }
}

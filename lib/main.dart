import 'package:flutter/cupertino.dart'; //## iOS-Design-Language
import 'package:flutter/material.dart'; //## Farben, Icons, etc. (Design)
import 'package:flutter/painting.dart'; //## Schatten, Farben, etc. (spezifischer)
import 'package:flutter/rendering.dart'; //## Render-Zeug
import 'package:stundenplaner/stateStundenplan.dart';

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
  var dragStopper = 0; //## Dient als Limit bei Swipe
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
                    //## Die Icons in der AppBar (oben rechts)
                    IconButton(
                      //## Report-Button
                      icon: Icon(Icons.error_outline_sharp,
                          color: Colors.black, size: 25),
                      onPressed: () {
                        Navigator.of(context).push(//## Weiterleitung auf Seite
                            MaterialPageRoute(builder: (context) => Report()));
                      },
                    ),
                    //SizedBox(width: 15,),
                    IconButton(
                      //## Settings-Button
                      icon: Icon(Icons.settings_outlined,
                          color: Colors.black, size: 25),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            //## Weiterleitung auf Seite
                            builder: (context) => Settings()));
                      },
                    ),
                  ],
                ))
          ],
          backgroundColor: Colors.white,
          elevation: 0, //## Lässt den Schwebeeffekt/Schatten verschwinden
        ),
        body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 420),
            child: bodyStates[
                currentIndex]), //## Ruft jeweiligen State/Tag für den Body auf

        bottomNavigationBar: GestureDetector(
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
                currentIndex =
                    index; //## Der Index (currentIndex) wird erneuert
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

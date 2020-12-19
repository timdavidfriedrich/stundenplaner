import 'package:flutter/cupertino.dart'; //## iOS-Design-Language
import 'package:flutter/material.dart'; //## Farben, Icons, etc. (Design)
import 'package:flutter/painting.dart'; //## Schatten, Farben, etc. (spezifischer)
import 'package:flutter/rendering.dart'; //## Render-Zeug

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
      //debugShowCheckedModeBanner: false,
      home: NavBar(), //## NavBar
    );
  }
}

class NavBar extends StatefulWidget {
  //##
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with SingleTickerProviderStateMixin {
  TabController _stateController;
  int currentIndex = 1; //## Legt den Start-Index fest (Start-Tab)
  var dragStopper = 0; //## Dient als Limit bei Swipe

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _stateController =
        TabController(length: bodyStates.length, vsync: this, initialIndex: 1);
    _stateController.animation.addListener(() {
      setState(() {
        currentIndex = (_stateController.animation.value).round();
      });
      print("Aktueller Index: " + _stateController.index.toString());
    });
  }

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
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 1000),
                            transitionsBuilder:
                                (context, animation, animationTime, child) {
                              var curve = Curves.easeOutExpo;
                              //var curveTween = CurveTween(curve: curve);
                              var begin = Offset(0, -1);
                              var end = Offset.zero;
                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));
                              var offsetAnimation = animation.drive(tween);
                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                            pageBuilder: (context, animation, animationTime) {
                              return Settings();
                            },
                          ));
                      /*
                        Navigator.of(context).push(MaterialPageRoute(
                            //## Weiterleitung auf Seite
                            builder: (context) => Settings()));
                            */
                    },
                  ),
                ],
              ))
        ],
        backgroundColor: Colors.white,
        elevation: 0, //## Lässt den Schwebeeffekt/Schatten verschwinden
      ),
      body: TabBarView(
        controller: _stateController,
        children: [
          Center(
            child:
                //Text(currentIndex.toString())
                bodyStates[0],
          ),
          Center(
            child:
                //Text(currentIndex.toString())
                bodyStates[1],
          ),
          Center(
            child:
                //Text(currentIndex.toString())
                bodyStates[2],
          ),
        ],
      ),
      floatingActionButton: fabStates[currentIndex],
      floatingActionButtonLocation: fabLocationStates[currentIndex],
      bottomNavigationBar: BottomNavyBar(
        //## BottomBar-Settings
        showElevation: false,
        animationDuration: Duration(milliseconds: 420),
        curve: Curves.easeInOut,
        mainAxisAlignment: MainAxisAlignment.spaceAround, //## Rand um die Items
        selectedIndex:
            currentIndex, //## Erkennt den aktuellen Index (int, s.o.)
        onItemSelected: (index) {
          _stateController.animateTo((index));
          //## Ändert den aktuellen Index bei Knopfdruck
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
    );
  }
}

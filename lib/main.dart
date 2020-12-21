import 'package:flutter/cupertino.dart'; //## iOS-Design-Language
import 'package:flutter/material.dart'; //## Farben, Icons, etc. (Design)
import 'package:flutter/painting.dart'; //## Schatten, Farben, etc. (spezifischer)
import 'package:flutter/rendering.dart'; //## Render-Zeug

import '.nicerStyle.dart'; //## Importiert eigenes Style-File
import 'handleTabs.dart'; //## Importiert den State/Tab-Regulator
import 'pageReport.dart';
import 'pageSettings.dart';
import '.transitions.dart';
import '.settings.dart';

import 'package:bottom_navy_bar/bottom_navy_bar.dart'; //## BottomBar

void main() => runApp(MaterialApp(
      //## Startet App, Setzt StartWidget
      home: AppHome(),
    ));

class AppHome extends StatelessWidget {
  //## StartWidget, Home = NavBar
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale('de', 'DE'),
      theme: new ThemeData(
        scaffoldBackgroundColor: t("body"),
        primaryColor: t("body"),
      ),
      home: Main(), //## NavBar
    );
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> with SingleTickerProviderStateMixin {
  TabController _tabController;
  int currentIndex = 1; //## Legt den Start-Index fest (Start-Tab)
  var dragStopper = 0; //## Dient als Limit bei Swipe

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController =
        TabController(length: tabBody.length, vsync: this, initialIndex: 1);
    _tabController.animation.addListener(() {
      setState(() {
        currentIndex = (_tabController.animation.value).round();
      });
      print("Aktueller Index: " + _tabController.index.toString());
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        //## AppBar-Settings
        //leading: Icon(Icons.menu),
        title: tabAppBarTitle[currentIndex],
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //## Die Icons in der AppBar (oben rechts)
                  betaChecker(context, "appBarIcon", currentIndex),
                  IconButton(
                    //## Settings-Button
                    icon: Icon(Icons.settings_outlined,
                        color: t("icons"), size: 25),
                    onPressed: () {
                      slide(context, Offset(1, 0), Settings());
                    },
                  ),
                ],
              ))
        ],
        backgroundColor: t("appBar"),
        elevation: 0, //## Lässt den Schwebeeffekt/Schatten verschwinden
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child:
                //Text(currentIndex.toString())
                tabBody[0],
          ),
          Center(
            child:
                //Text(currentIndex.toString())
                tabBody[1],
          ),
          Center(
            child:
                //Text(currentIndex.toString())
                tabBody[2],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavyBar(
        //## BottomBar-Settings
        //containerHeight: 60,
        backgroundColor: t("bottomBar"),
        showElevation: false,
        animationDuration: Duration(milliseconds: 420),
        curve: Curves.easeInOut,
        mainAxisAlignment: MainAxisAlignment.spaceAround, //## Rand um die Items
        selectedIndex:
            currentIndex, //## Erkennt den aktuellen Index (int, s.o.)
        onItemSelected: (index) {
          _tabController.animateTo((index));
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
              inactiveColor: t("icons"),
              textAlign: TextAlign.center),
          BottomNavyBarItem(
              icon: Icon(Icons.home_outlined),
              title: Text("Mein Tag", style: niceBar),
              activeColor: Colors.blueAccent,
              inactiveColor: t("icons"),
              textAlign: TextAlign.center),
          BottomNavyBarItem(
              icon: Icon(Icons.list_alt_sharp),
              title: Text("Vertretung", style: niceBar),
              activeColor: Colors.greenAccent[700],
              inactiveColor: t("icons"),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

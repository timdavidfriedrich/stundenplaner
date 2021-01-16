import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '.nicerStyle.dart';

import 'handleTabs.dart';

import 'pageReport.dart'; //#### Wie wär's mit KABOOM bei Front?
import 'pageSettings.dart';
import '.transitions.dart';
import '.stundenplan.dart';
import '.settings.dart';
import '.sharedprefs.dart';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await getPrefs();
  await firebaseConnect();
  runApp(MaterialApp(
    /// Startet App, Setzt StartWidget
    home: AppHome(),
  ));
}

class AppHome extends StatelessWidget {
  final int startIndex;
  AppHome([this.startIndex]);

  /// StartWidget, Home = NavBar
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale('de'),
      supportedLocales: [const Locale('de')],
      theme: new ThemeData(
        scaffoldBackgroundColor: t("body"),
        primaryColor: t("body"),
      ),
      home: Main(startIndex),

      /// NavBar
    );
  }
}

class Main extends StatefulWidget {
  final int startIndex;
  Main([this.startIndex]);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> with SingleTickerProviderStateMixin {
  TabController _tabController;

  void getStartIndex() {
    widget.startIndex == null
        ? currentIndex = 1
        : currentIndex = widget.startIndex;
  }

  /// Legt den Start-Index fest (Start-Tab)
  int currentIndex;

  /// Dient als Limit bei Gesture-Detector
  var dragStopper = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStartIndex();
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
      /// AppBar-Settings
      appBar: AppBar(
        toolbarHeight: 60,
        title: Text(tabAppBarTitle[currentIndex], style: niceAppBarTitle()),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Die Icons in der AppBar (oben rechts)
                  betaChecker(context, "appBarIcon", currentIndex),
                  IconButton(
                    /// Settings-Button
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

        /// Lässt den Schwebeeffekt/Schatten verschwinden
        elevation: 0,
      ),
      body: TabBarView(
        physics: BouncingScrollPhysics(),
        controller: _tabController,
        children: [
          Center(
            child: tabBody[0],
          ),
          Center(
            child: tabBody[1],
          ),
          Center(
            child: tabBody[2],
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(0, 1, 0, 3),
        child: BottomNavyBar(
          /// BottomBar-Settings
          backgroundColor: t("bottomBar"),
          showElevation: false,
          animationDuration: Duration(milliseconds: 420),
          curve: Curves.easeInOut,

          /// Rand um die Items
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          /// Erkennt den aktuellen Index (int, s.o.)
          selectedIndex: currentIndex,

          /// Ändert den aktuellen Index bei Knopfdruck
          onItemSelected: (index) {
            _tabController.animateTo((index));
          },
          items: <BottomNavyBarItem>[
            /// Der Inhalt der BottomBar (Items)
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
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import '.nicerStyle.dart';

import 'tabStundenplan_add.dart';
import '.settings.dart';

wochenHandler() {
  if (abWoche == true) {
    return ListTile(
      /// Datums-Leiste
      //tileColor: Colors.black87,
      leading: Icon(Icons.arrow_left, color: t("icons")),
      title: Text(
        "A-Woche",
        style: niceSubtitle(),
        textAlign: TextAlign.center,
      ),
      trailing: Icon(Icons.arrow_right, color: t("icons")),
    );
  } else {
    return Container(height: 0, width: 0);
  }
}

tabStundenplanAppBarTitle() {
  return Text("Stundenplan", style: niceAppBarTitle());
  //return Text("Stundenplan", style: niceTitle(Colors.black));
}

tabStundenplanAppBarIcon() {
  return Colors.redAccent;
}

class TabStundenplanBody extends StatefulWidget {
  @override
  TabStundenplanBodyState createState() => TabStundenplanBodyState();
}

class TabStundenplanBodyState extends State<TabStundenplanBody>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    Timer(Duration(milliseconds: 200), () => _animationController.forward());
    super.initState();
  }

  @override
  void dispose() {
    _animationController.forward();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
          //color: t("body"),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //wochenHandler(),
              Container(
                /*
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
                */
                //padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Table(
                  children: [
                    TableRow(children: [
                      TableCell(
                          child: Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                              child: Center(
                                child: Text("MO", style: niceTableHead),
                              ))),
                      TableCell(
                          child: Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                              child: Center(
                                child: Text("DI", style: niceTableHead),
                              ))),
                      TableCell(
                          child: Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                              child: Center(
                                child: Text("MI", style: niceTableHead),
                              ))),
                      TableCell(
                          child: Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                              child: Center(
                                child: Text("DO", style: niceTableHead),
                              ))),
                      TableCell(
                          child: Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                              child: Center(
                                child: Text("FR", style: niceTableHead),
                              ))),
                    ]),
                    TableRow(children: [
                      TableCell(
                        child: Text(""),
                      ),
                      TableCell(
                        child: Text(""),
                      ),
                      TableCell(
                        child: Text(""),
                      ),
                      TableCell(
                        child: Text(""),
                      ),
                      TableCell(
                        child: Text(""),
                      ),
                    ]),
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          left: 10,
          bottom: 20,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0, 3),
              end: Offset.zero,
            )
                .chain(CurveTween(curve: Curves.elasticOut))
                .animate(_animationController),
            child: ButtonTheme(
              minWidth: 56,
              height: 56,
              child: RaisedButton(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                color: t("fabStundenplan"),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return stundenplanAddOverlay();
                      });
                },
                child: Icon(Icons.add, color: t("wNice")),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

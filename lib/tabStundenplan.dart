import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import 'package:animate_icons/animate_icons.dart';

import '.nicerStyle.dart';
import '.settings.dart';

import 'tabStundenplan_show.dart';

tabStundenplanAppBarTitle() {
  return "Stundenplan";
}

tabStundenplanAppBarIcon() {
  return Colors.redAccent;
}

class StundenplanItem {
  String bezeichung;
  Color farbe;
  String raum;
  String lehrer;
  StundenplanItem(this.bezeichung, this.farbe, this.raum, this.lehrer);
}

class TabStundenplanBody extends StatefulWidget {
  @override
  TabStundenplanBodyState createState() => TabStundenplanBodyState();
}

class TabStundenplanBodyState extends State<TabStundenplanBody>
    with SingleTickerProviderStateMixin {
  //
  AnimateIconController controller;
  AnimationController _animationController;

  bool aWoche = true;

  @override
  void initState() {
    super.initState();
    getPrefs();
    controller = AnimateIconController();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    Timer(Duration(milliseconds: 200), () => _animationController.forward());
  }

  @override
  void dispose() {
    _animationController.reverse();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          abWoche
              ? StundenplanShow("plan_C")
              : (aWoche
                  ? StundenplanShow("plan_A")
                  : StundenplanShow("plan_B")),
          !abWoche
              ? Positioned(
                  left: 20,
                  bottom: 25,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(0, 3),
                      end: Offset.zero,
                    )
                        .chain(CurveTween(curve: Curves.elasticOut))
                        .animate(_animationController),
                    child: ButtonTheme(
                      minWidth: 160,
                      height: 50,
                      child: RaisedButton(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                        color: t("fabStundenplan"),
                        onPressed: () {
                          setState(() => aWoche = !aWoche);
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.easeInOut,
                          child: aWoche
                              ? RichText(
                                  text: TextSpan(
                                      style: wNice(),
                                      children: <TextSpan>[
                                      TextSpan(
                                          text: 'Aktuell:  ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w100)),
                                      TextSpan(
                                          text: 'A-Woche',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900))
                                    ]))
                              : RichText(
                                  text: TextSpan(
                                      style: wNice(),
                                      children: <TextSpan>[
                                      TextSpan(
                                          text: 'Aktuell:  ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w100)),
                                      TextSpan(
                                          text: 'B-Woche',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900))
                                    ])),
                        ),
                        //child: Icon(Icons.edit_sharp, color: t("wNice")),
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}

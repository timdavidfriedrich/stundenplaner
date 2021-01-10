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
import 'tabStundenplan_edit.dart';

tabStundenplanAppBarTitle() {
  return "Stundenplan";
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
  //
  AnimateIconController controller;
  AnimationController _animationController;

  bool editMode = false;

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
    //setState(() => editMode = false);
    _animationController.reverse();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        editMode ? StundenplanEdit() : StundenplanShow(),
        Positioned(
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
              minWidth: 56,
              height: 56,
              child: RaisedButton(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                color: t("fabStundenplan"),
                onPressed: () {
                  setState(() => editMode = !editMode);
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 1000),
                  curve: Curves.easeInOut,
                  child: editMode
                      ? Icon(Icons.close_sharp, color: Colors.white)
                      : Icon(Icons.edit_sharp, color: Colors.white),
                ),
                //child: Icon(Icons.edit_sharp, color: t("wNice")),
              ),
            ),
          ),
        ),
        abWoche
            ? Positioned(
                right: 20,
                bottom: 30,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(0, 3),
                    end: Offset.zero,
                  )
                      .chain(CurveTween(curve: Curves.elasticOut))
                      .animate(_animationController),
                  child: ButtonTheme(
                    minWidth: 175,
                    height: 50,
                    child: RaisedButton(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      color: t("nice"),
                      onPressed: () {
                        //
                      },
                      child: RichText(
                          text: TextSpan(style: nice2(), children: <TextSpan>[
                        TextSpan(
                            text: 'Aktuell:  ',
                            style: TextStyle(fontWeight: FontWeight.w100)),
                        TextSpan(
                            text: 'A-Woche',
                            style: TextStyle(fontWeight: FontWeight.w900))
                      ])),
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    ));
  }
}

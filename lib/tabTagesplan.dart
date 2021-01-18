import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import 'dart:async';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '.nicerStyle.dart';
import '.settings.dart';
import '.stundenplan.dart';
import '.sharedprefs.dart';
import '.database.dart';
import 'tabStundenplan_new_edit.dart';

tabTagesplanAppBarTitle() {
  return "Mein heutiger Tag";
}

tabTagesplanAppBarIcon() {
  return Colors.blueAccent;
}

class TabTagesplanBody extends StatefulWidget {
  @override
  _TabTagesplanBodyState createState() => _TabTagesplanBodyState();
}

class _TabTagesplanBodyState extends State<TabTagesplanBody> {
  int _index = 0;
  var cardTitle = ["Gestern", "Heute", "Morgen"];
  var cardColor = [Colors.blue[100], Colors.blueAccent, Colors.blue[100]];

  bool testMode = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //color: t("body"),
        child: testMode
            ? Center()
            : Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: Center(
                  child: Swiper(
                    control: SwiperControl(
                        iconPrevious: Icons.arrow_back_ios,
                        iconNext: Icons.arrow_forward_ios,
                        size: 24,
                        padding: EdgeInsets.all(15),
                        color: t("body"),
                        disableColor: t("body")),
                    viewportFraction: 0.75,
                    scale: 0.85,
                    physics: BouncingScrollPhysics(),
                    loop: false,
                    scrollDirection: Axis.vertical,
                    index: 1,
                    itemCount: 3,
                    itemBuilder: (BuildContext context, index) {
                      return Card(
                        color: cardColor[index],
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            cardTitle[index],
                            style: wNice(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
      ),
    );
  }
}

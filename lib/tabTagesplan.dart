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

  bool ausblenden = true;

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
        child: ausblenden
            ? Center(
                child: FutureBuilder(

                    // Wait until [connectToFirebase] returns stream
                    future: firebaseConnect(),
                    builder:
                        (BuildContext context, AsyncSnapshot<void> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        // When stream exists, use Streambilder to wait for data
                        return StreamBuilder<DocumentSnapshot>(
                          stream: database.getStundenplan(),
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              // resolve stream... Stream<DocumentSnapshot> -> DocumentSnapshot -> Map<String, bool>
                              Map<String, dynamic> items = snapshot.data.data();
                              if (items.isEmpty) {
                                return Center(
                                    child: Text("Keine Fächer gefunden."));
                              } else {
                                return ListView.builder(
                                  itemCount: items["fachList"].length,
                                  itemBuilder: (context, i) {
                                    return ListTile(
                                        title: Text(items["fachList"]
                                            .values
                                            .elementAt(i)["bezeichnung"]
                                            .toString()));
                                  },
                                );
                              }
                            }
                          },
                        );
                      }
                    }),
              )
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

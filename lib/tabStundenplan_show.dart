import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import '.nicerStyle.dart';
import 'tabStundenplan.dart';
import '.database.dart';
import '.stundenplan.dart';
import '.settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StundenplanShow extends StatefulWidget {
  @override
  StundenplanShowState createState() => StundenplanShowState();
}

class StundenplanShowState extends State<StundenplanShow> {
  //

  gridBuilder(i, aItems) {
    List itemZahl = [0, 5, 10, 15, 20, 25, 30, 35, 40];
    for (int x = 0; x < itemZahl.length - 1; x++) {
      if (itemZahl[x] <= i && i < itemZahl[x + 1]) {
        return Text(
          aItems[i - itemZahl[x]][(x + 1).toString()],
          style: nice(),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
      child: FutureBuilder(
        future: firebaseConnect(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black)));
          } else {
            return StreamBuilder<DocumentSnapshot>(
              stream: Database(user.uid).getStundenplan(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.redAccent)));
                } else {
                  Map<String, dynamic> items = snapshot.data.data();
                  var fachItems = items["fachList"].values;
                  List aItems = items["plan_A"].values.toList();
                  List bItems = items["plan_B"].values.toList();
                  print("aItems: " + aItems.toString());

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 32,
                        child: GridView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: aItems.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5),
                          itemBuilder: (context, i) {
                            List head = ["MO", "DI", "MI", "DO", "FR"];
                            return Container(
                                padding: EdgeInsets.all(5),
                                child: Align(
                                    alignment: Alignment.topCenter,
                                    child:
                                        Text(head[i], style: niceTableHead)));
                          },
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: aItems.length * 8,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5),
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: FlatButton(
                                padding: EdgeInsets.zero,
                                height: !blockOnly ? 108 : 50,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                color: t("back_button"),
                                onPressed: () {},
                                child: gridBuilder(i, aItems),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}

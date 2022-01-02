import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import 'tabStundenplan.dart';
import 'tabStundenplan_add.dart';

import '.nicerStyle.dart';
import '.database.dart';
import '.settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StundenplanShow extends StatefulWidget {
  final String woche;
  StundenplanShow(this.woche);

  @override
  StundenplanShowState createState() => StundenplanShowState();
}

class StundenplanShowState extends State<StundenplanShow> {
  //

  @override
  void initState() {
    super.initState();
  }

  String neuesFach = "Leer";
  bool done = false;

  neuesFachDialog() async {
    Map<String, dynamic> callback = await showDialog<Map<String, dynamic>>(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StundenplanAdd();
        });
    setState(() {
      neuesFach = callback["fach"];
      done = callback["done"];
    });
  }

  getFachIndex(fachIdList, itemText) {
    int fachIndex;
    for (int f = 0; f < fachIdList.length; f++) {
      if (fachIdList[f] == itemText) {
        f != null ? fachIndex = f.toInt() : fachIndex = 99;
      }
    }
    print("fachIndex: " + fachIndex.toString());
    return fachIndex;
  }

  buttonPress() {}

  gridBuilder(i, abItems, fachItems) {
    bool longPressed = false;

    List itemZahl = [0, 5, 10, 15, 20, 25, 30, 35, 40];
    for (int x = 0; x < itemZahl.length - 1; x++) {
      if (itemZahl[x] <= i && i < itemZahl[x + 1]) {
        int _tag = i - itemZahl[x];
        int tag = i - itemZahl[x] + 1;
        String block = (x + 1).toString();

        String itemText = abItems[_tag][block];
        print("itemText: " + itemText);
        List fachIdList = [];
        fachItems.forEach((value) {
          fachIdList.add(value["a_id"]);
        });

        /// WENN EIN FACH GELÖSCHT WIRD, WERDEN AUCH SP-EINTRÄGE ENTFERNT
        for (int x = 0; x < fachIdList.length; x++) {
          if (!fachIdList.contains(itemText)) {
            print("tabStundenplan_show/gridBuilder/'delete' " +
                (x + 1).toString() +
                "/" +
                fachIdList.length.toString());
            /*
            Database(user.uid)
                .setStundenplanEintrag(widget.woche, tag.toString(), block, "");
                */
          }
        }

        print("fachIdList: " + fachIdList.toString());
        return FlatButton(
            padding: EdgeInsets.zero,
            height: !blockOnly ? 108 : 50,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: itemText == "" || !fachIdList.contains(itemText)
                ? t("back_button")
                : Color(fachItems[getFachIndex(fachIdList, itemText)]["farbe"]),
            onPressed: () async {
              print("tabStundenplan_show/gridBuilder/FlatButton/onPressed()");
              await neuesFachDialog();
              done
                  ? Database(user.uid).setStundenplanEintrag(
                      widget.woche, tag.toString(), block, neuesFach)
                  : null;
            },
            onLongPress: () {
              print("tabStundenplan_show/gridBuilder/FlatButton/onLongPress()");
              longPressed = true;
              Database(user.uid).setStundenplanEintrag(
                  widget.woche, tag.toString(), block, "");
            },
            child: Text(
              itemText,
              style: itemText == "" || !fachIdList.contains(itemText)
                  ? niceCustom(t("wNice").withOpacity(0.0))
                  : niceCustom(t("wNice"), 10),
            ));
      }
    }
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
                              AlwaysStoppedAnimation<Color>(Colors.black)));
                } else {
                  Map<String, dynamic> items = snapshot.data.data();
                  List fachItems = items["fachList"].values.toList();
                  List abItems = items[widget.woche].values.toList();
                  print("fachItems: " + fachItems.toString());
                  print("abItems: " + abItems.toString());

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 32,
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: abItems.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5),
                          itemBuilder: (context, i) {
                            List head = ["MO", "DI", "MI", "DO", "FR"];
                            return Container(
                                padding: EdgeInsets.all(5),
                                child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(head[i], style: tableHead())));
                          },
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount:
                              abWoche ? abItems.length * 8 : abItems.length * 4,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5,
                                  childAspectRatio: abWoche ? 1.2 : 0.7),
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.all(4),
                              child: gridBuilder(i, abItems, fachItems),
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

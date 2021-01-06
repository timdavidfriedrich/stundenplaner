import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pageReport.dart';
import '.nicerStyle.dart';
import '.settings.dart';

class ReportDev extends StatefulWidget {
  @override
  _ReportDevState createState() => _ReportDevState();
}

class _ReportDevState extends State<ReportDev> {
  @override
  void initState() {
    getReports();
    super.initState();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference reports =
      FirebaseFirestore.instance.collection('reports');

  List docList = [];
  List datumList = [];
  List nachrichtenList = [];

  Future getReports() async {
    QuerySnapshot snap = await reports.get();
    for (int i = 0; i < snap.docs.length; i++) {
      var a = snap.docs[i];
      setState(() {
        docList.add(a.id);
        datumList.add(a.data()["datum"]);
        nachrichtenList.add(a.data()["nachricht"]);
      });
    }
    print("FB GET: (DocList) " + docList.toString());
    print("FB GET: (datumList) " + datumList.toString());
    print("FB GET: (nachrichtenList) " + datumList.toString());
  }

  @override
  Widget build(BuildContext context) {
    return dev
        ? Scaffold(
            appBar: AppBar(
              leading: SizedBox(),
              elevation: 0,
              toolbarHeight: 200,
              bottom: AppBar(
                title: Text("Feedback", style: niceBigTitle()),
                centerTitle: true,
                leading: SizedBox(),
                elevation: 0,
                toolbarHeight: 100,
              ),
            ),
            body: Container(
              child: (docList.isEmpty)
                  ? Center(child: Text(docList.toString()))
                  : ListView.builder(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 100),
                      itemCount: docList.length,
                      itemBuilder: (context, i) {
                        /// Geht jede Zeile durch und schreibt den Eintrag
                        return Nachricht(
                          datumList.reversed.toList()[i],
                          nachrichtenList.reversed.toList()[i],
                        );
                      },
                    ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.fromLTRB(0, 25, 0, 25),
              child: Row(
                children: [
                  Spacer(flex: 3),
                  FlatButton(
                    height: 42,
                    minWidth: 20,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    color: t("back_button"),
                    child: Icon(Icons.arrow_back, color: t("on_back_button")),
                    onPressed: () {
                      setState(() => dev = false);
                    },
                  ),
                  Spacer(flex: 1),
                  FlatButton(
                    height: 42,
                    minWidth: 200,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    color: t("nice"),
                    child: Text("Neu laden", style: wNice()),
                    onPressed: () {
                      setState(() => docList.clear());
                      getReports();
                    },
                  ),
                  Spacer(flex: 3)
                ],
              ),
            ),
          )
        : Report();
  }
}

class Nachricht extends StatefulWidget {
  final Timestamp xDatum;
  final String xNachricht;

  const Nachricht(this.xDatum, this.xNachricht);

  @override
  _NachrichtState createState() => _NachrichtState();
}

class _NachrichtState extends State<Nachricht> {
  //
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        print("EYEYEY");
      },
      child: Card(
        color: t("eintragBackground"),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
        child: Container(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('dd.MM.yyyy')
                        .format(widget.xDatum.toDate())
                        .toString(),
                    style: GoogleFonts.montserrat(
                        color: t("eintragFont"),
                        fontSize: 18,
                        fontWeight: FontWeight.w800),
                  ),
                  Text(
                    DateFormat('hh:mm')
                            .format(widget.xDatum.toDate())
                            .toString() +
                        " Uhr",
                    style: GoogleFonts.montserrat(
                        color: t("eintragFont"),
                        fontSize: 18,
                        fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              Text(""),
              Text(
                widget.xNachricht,
                style: wNice(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

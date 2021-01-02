import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import 'package:data_connection_checker/data_connection_checker.dart';

import '.nicerStyle.dart';

/// Importiert eigenes Style-File
import 'main.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  bool onlineStatus;
  bool close = false;

  onlineChecker() async {
    bool online = await DataConnectionChecker().hasConnection;
    if (online == true) {
      setState(() {
        onlineStatus = true;
      });
    } else {
      setState(() {
        onlineStatus = false;
      });
    }
  }

  popper() {
    if (close == true) {
      return Navigator.of(context).pop();
    }
  }

  alertHandler() {
    if (onlineStatus == false) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            //return alertHandler();
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              contentTextStyle: bNice(),
              //titleTextStyle: bNice(),
              title: Text('Senden fehlgeschlagen'),
              content: Text(
                  'Bitte überprüfen Sie Ihre Internetverbindung und versuchen Sie es erneut.'),
              actions: <Widget>[
                FlatButton(
                  child: Text('ZURÜCK'),
                  onPressed: () {
                    return Navigator.of(context).pop();
                    //popper();
                  },
                )
              ],
            );
          });
    } else {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            //return alertHandler();
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              content: Text(
                  'Vielen Dank für das Feedback.\nIhre Nachricht wird weitergeleitet.'),
              actions: <Widget>[
                FlatButton(
                  child: Text('OKAY'),
                  onPressed: () {
                    setState(() {
                      close = true;
                    });
                    popper();
                    return Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }

  String nachricht;

  nachrichtRefresh(String text) {
    setState(() {
      nachricht = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          //color: Colors.white,
          child: ListView(
        physics: BouncingScrollPhysics(),
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            //color: Colors.red,
            padding: EdgeInsets.fromLTRB(25, 5, 25, 25),
            child: TextField(
              style: nice(),
              minLines: 10,
              maxLines: 100,
              maxLength: 420,
              maxLengthEnforced: false,
              onChanged: nachrichtRefresh,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      BorderSide(color: Colors.redAccent[400], width: 2),
                ),
                alignLabelWithHint: true,
                labelText: ' Nachricht',
                labelStyle: nice(),
                hintText: 'Lob, Kritik, Fehler gefunden, ...',
                hintStyle: nice(),
                prefixText: '  ',
                suffixText: '  ',
              ),
            ),
          ),
        ],
      )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(0, 25, 0, 25),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                Navigator.of(context).pop(); //popAndPushNamed();
              },
            ),
            Spacer(flex: 1),
            FlatButton(
              height: 42,
              minWidth: 200,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              color: Colors.blueAccent,
              child: Text("Nachricht senden", style: wNice()),
              onPressed: () async {
                await onlineChecker();
                return alertHandler();
              },
            ),
            Spacer(flex: 3)
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import 'package:expandable/expandable.dart';

import '.nicerStyle.dart';
import '.settings.dart';

/// Importiert eigenes Style-File
import 'main.dart';

class NeuesFach extends StatefulWidget {
  @override
  _NeuesFachState createState() => _NeuesFachState();
}

class _NeuesFachState extends State<NeuesFach> {
  Color selectedColor = Colors.redAccent;

  List<Color> colorList = [
    Colors.pink,
    Colors.red,
    Colors.deepOrange,
    Colors.orange,
    Colors.amber,
    Colors.yellow,
    Colors.lime,
    Colors.lightGreen,
    Colors.green,
    Colors.teal,
    Colors.cyan,
    Colors.lightBlue,
    Colors.blue,
    Colors.indigo,
    Colors.deepPurple,
  ];

  List<Color> colors = [];

  add2Colors() {
    for (int i = 0; i < 255; i++) {
      colors.add(Color.fromRGBO(255, i, 0, 1.0));
    }
    for (int i = 255; i > 0; i--) {
      colors.add(Color.fromRGBO(i, 255, 0, 1.0));
    }
    for (int i = 0; i < 255; i++) {
      colors.add(Color.fromRGBO(0, 255, i, 1.0));
    }
    for (int i = 255; i > 0; i--) {
      colors.add(Color.fromRGBO(0, i, 255, 1.0));
    }
    for (int i = 0; i < 255; i++) {
      colors.add(Color.fromRGBO(i, 0, 255, 1.0));
    }
    for (int i = 255; i > 0; i--) {
      colors.add(Color.fromRGBO(255, 0, i, 1.0));
    }
  }

  double sliderValue = 0;

  bool sliderRGB = true;

  @override
  void initState() {
    super.initState();
    add2Colors();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      backgroundColor: t("body3"),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      titleTextStyle: niceAppBarTitle(),
      title: Text('Neues Fach', style: TextStyle(fontSize: 24)),
      contentPadding: EdgeInsets.fromLTRB(0, 15, 0, 15),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(25, 0, 0, 0),
            leading: Icon(Icons.school_outlined, color: t("nice")),
            title: TextField(
              cursorColor: Colors.redAccent,
              style: nice(),
              decoration: InputDecoration.collapsed(
                hintText: "Bezeichnung",
                hintStyle: niceHint(),
              ),
            ),
          ),
          (sliderRGB != true)
              ? ExpandableNotifier(
                  child: ScrollOnExpand(
                    scrollOnExpand: true,
                    scrollOnCollapse: false,
                    child: ExpandablePanel(
                      hasIcon: false,
                      header: ListTile(
                        contentPadding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                        leading: Icon(Icons.circle,
                            color: colors[sliderValue.toInt()]),
                        title: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Farbe wählen", style: nice())),
                      ),
                      expanded: Container(
                        color: t("nice").withOpacity(0.03),
                        padding: EdgeInsets.fromLTRB(12, 5, 12, 5),
                        child: Slider(
                          value: sliderValue,
                          min: 0,
                          max: colors.length.toDouble() - 1,
                          activeColor: colors[sliderValue.toInt()],
                          inactiveColor: Colors.black,
                          onChanged: (double value) {
                            setState(() => sliderValue = value);
                          },
                        ),
                      ),
                    ),
                  ),
                )
              : ExpandableNotifier(
                  child: ScrollOnExpand(
                    scrollOnExpand: true,
                    scrollOnCollapse: false,
                    child: ExpandablePanel(
                      hasIcon: false,
                      header: ListTile(
                        contentPadding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                        leading: Icon(Icons.circle,
                            color: colors[sliderValue.toInt()]),
                        title: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Farbe wählen", style: nice())),
                      ),
                      expanded: Container(
                        color: t("nice").withOpacity(0.03),
                        padding: EdgeInsets.fromLTRB(12, 5, 12, 5),
                        child: SliderTheme(
                          data: SliderThemeData(
                            trackHeight: 6,
                            trackShape: GradientRectSliderTrackShape(
                                gradient: LinearGradient(colors: colors),
                                darkenInactive: false),
                          ),
                          child: Slider(
                            value: sliderValue,
                            min: 0,
                            max: colors.length.toDouble() - 1,
                            activeColor: colors[sliderValue.toInt()],
                            //inactiveColor: Colors.black,
                            onChanged: (double value) {
                              setState(() => sliderValue = value);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(25, 0, 0, 0),
            leading: Icon(Icons.location_on_outlined, color: t("nice")),
            title: TextField(
              cursorColor: Colors.redAccent,
              style: nice(),
              decoration: InputDecoration.collapsed(
                hintText: "Raum",
                hintStyle: niceHint(),
              ),
            ),
          ),
          (ichBin != "lehrer")
              ? ListTile(
                  contentPadding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                  leading: Icon(Icons.person_outline_sharp, color: t("nice")),
                  title: TextField(
                    cursorColor: Colors.redAccent,
                    style: nice(),
                    decoration: InputDecoration.collapsed(
                      hintText: "Lehrer",
                      hintStyle: niceHint(),
                    ),
                  ),
                )
              : null
        ],
      ),
      actionsPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: FlatButton(
            //height: 42,
            minWidth: 50,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            color: t("back_button2"),
            child: Icon(Icons.arrow_back, color: t("on_back_button")),
            onPressed: () {
              Navigator.of(context).pop(); //popAndPushNamed();
            },
          ),
        ),
        FlatButton(
          //height: 42,
          minWidth: 150,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          color: Colors.redAccent,
          child: Text("Hinzufügen", style: wNice()),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class NiceTextField extends StatefulWidget {
  final String label;
  final String hint;
  final Color color;
  final Icon icon;

  const NiceTextField(this.label, this.hint, this.color, this.icon);

  @override
  NiceTextFieldState createState() => NiceTextFieldState();
}

class NiceTextFieldState extends State<NiceTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        style: nice(),
        minLines: 1,
        maxLines: 1,
        //onChanged: null,
        decoration: InputDecoration(
          prefixIcon: widget.icon,
          //prefix: widget.icon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: widget.color, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: widget.color, width: 2),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.redAccent[400], width: 2),
          ),
          alignLabelWithHint: true,
          labelText: ' ' + widget.label,
          labelStyle: nice(),
          hintText: widget.hint,
          hintStyle: niceHint(),
          prefixText: '  ',
          suffixText: '  ',
        ),
      ),
    );
  }
}

class GradientRectSliderTrackShape extends SliderTrackShape
    with BaseSliderTrackShape {
  /// Based on https://www.youtube.com/watch?v=Wl4F5V6BoJw
  /// Create a slider track that draws two rectangles with rounded outer edges.
  final LinearGradient gradient;
  final bool darkenInactive;
  const GradientRectSliderTrackShape(
      {this.gradient:
          const LinearGradient(colors: [Colors.lightBlue, Colors.blue]),
      this.darkenInactive: true});

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    @required RenderBox parentBox,
    @required SliderThemeData sliderTheme,
    @required Animation<double> enableAnimation,
    @required TextDirection textDirection,
    @required Offset thumbCenter,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 0,
  }) {
    assert(context != null);
    assert(offset != null);
    assert(parentBox != null);
    assert(sliderTheme != null);
    assert(sliderTheme.disabledActiveTrackColor != null);
    assert(sliderTheme.disabledInactiveTrackColor != null);
    assert(sliderTheme.activeTrackColor != null);
    assert(sliderTheme.inactiveTrackColor != null);
    assert(sliderTheme.thumbShape != null);
    assert(enableAnimation != null);
    assert(textDirection != null);
    assert(thumbCenter != null);
    // If the slider [SliderThemeData.trackHeight] is less than or equal to 0,
    // then it makes no difference whether the track is painted or not,
    // therefore the painting  can be a no-op.
    if (sliderTheme.trackHeight <= 0) {
      return;
    }

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    // Assign the track segment paints, which are leading: active and
    // trailing: inactive.
    final ColorTween activeTrackColorTween = ColorTween(
        begin: sliderTheme.disabledActiveTrackColor,
        end: sliderTheme.activeTrackColor);
    final ColorTween inactiveTrackColorTween = darkenInactive
        ? ColorTween(
            begin: sliderTheme.disabledInactiveTrackColor,
            end: sliderTheme.inactiveTrackColor)
        : activeTrackColorTween;
    final Paint activePaint = Paint()
      ..shader = gradient.createShader(trackRect)
      ..color = activeTrackColorTween.evaluate(enableAnimation);
    final Paint inactivePaint = Paint()
      ..shader = gradient.createShader(trackRect)
      ..color = inactiveTrackColorTween.evaluate(enableAnimation);
    Paint leftTrackPaint;
    Paint rightTrackPaint;
    switch (textDirection) {
      case TextDirection.ltr:
        leftTrackPaint = activePaint;
        rightTrackPaint = inactivePaint;
        break;
      case TextDirection.rtl:
        leftTrackPaint = inactivePaint;
        rightTrackPaint = activePaint;
        break;
    }
    final Radius trackRadius = Radius.circular(trackRect.height / 2);
    final Radius activeTrackRadius = Radius.circular(trackRect.height / 2 + 1);

    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        trackRect.left,
        (textDirection == TextDirection.ltr)
            ? trackRect.top - (additionalActiveTrackHeight / 2)
            : trackRect.top,
        thumbCenter.dx,
        (textDirection == TextDirection.ltr)
            ? trackRect.bottom + (additionalActiveTrackHeight / 2)
            : trackRect.bottom,
        topLeft: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
        bottomLeft: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
      ),
      leftTrackPaint,
    );
    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        thumbCenter.dx,
        (textDirection == TextDirection.rtl)
            ? trackRect.top - (additionalActiveTrackHeight / 2)
            : trackRect.top,
        trackRect.right,
        (textDirection == TextDirection.rtl)
            ? trackRect.bottom + (additionalActiveTrackHeight / 2)
            : trackRect.bottom,
        topRight: (textDirection == TextDirection.rtl)
            ? activeTrackRadius
            : trackRadius,
        bottomRight: (textDirection == TextDirection.rtl)
            ? activeTrackRadius
            : trackRadius,
      ),
      rightTrackPaint,
    );
  }
}
import 'dart:math';
import 'package:flutter/material.dart';

rdm(min, max){
  var r = new Random();
  return min + r.nextInt(max-min);
}
rdmColor(){
  List farben = [
                Colors.greenAccent[700],
                Colors.yellow[700],
                Colors.deepOrangeAccent,
                Colors.redAccent,
                Colors.purpleAccent,
                Colors.blueAccent[400],
                ];
  var i = rdm(0,farben.length);
  return farben[i];
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'stateStundenplan.dart';
import 'stateTagesplan.dart';
import 'stateVertretungsplan.dart';

import 'nicerStyle.dart';

List barStates = [
  stateStundenplanBarTitle(),
  stateTagesplanBarTitle(),
  stateVertretungsplanBarTitle(),
];

List bodyStates = [
  stateStundenplanBody(),
  stateTagesplanBody(),
  stateVertretungsplanBody(),
];

//SWIPE-HANDLER:
swipeHandler(){
  
}
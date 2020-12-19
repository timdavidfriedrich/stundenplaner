import 'stateStundenplan.dart';
import 'stateTagesplan.dart';
import 'stateVertretungsplan.dart';

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

List fabStates = [
  stateStundenplanFab(),
  stateTagesplanFab(),
  stateVertretungsplanFab(),
];

List fabLocationStates = [
  stateStundenplanFabLocation(),
  stateTagesplanFabLocation(),
  stateVertretungsplanFabLocation(),
];

//SWIPE-HANDLER:
swipeHandler() {}

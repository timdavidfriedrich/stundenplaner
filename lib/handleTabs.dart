import 'tabStundenplan.dart';
import 'tabTagesplan.dart';
import 'tabVertretungsplan.dart';

List tabAppBarTitle = [
  tabStundenplanAppBarTitle(),
  tabTagesplanAppBarTitle(),
  tabVertretungsplanAppBarTitle(),
];

List tabAppBarIcon = [
  tabStundenplanAppBarIcon(),
  tabTagesplanAppBarIcon(),
  tabVertretungsplanAppBarIcon(),
];

List tabBody = [
  tabStundenplanBody(),
  tabTagesplanBody(),
  tabVertretungsplanBody(),
];

List tabFab = [
  tabStundenplanFab(),
  tabTagesplanFab(),
  tabVertretungsplanFab(),
];

List tabFabLocation = [
  tabStundenplanFabLocation(),
  tabTagesplanFabLocation(),
  tabVertretungsplanFabLocation(),
];

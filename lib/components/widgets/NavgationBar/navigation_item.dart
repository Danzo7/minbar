import 'package:flutter/material.dart';
import 'package:minbar_fl/components/screens/screens.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';

const List<NavigatonItem> navigationItems = const [
  const NavigatonItem(
      route: LiveBroadcastsScreen.route,
      beforeIcon: Icon(SodaIcons.broadcasts, color: DColors.white, size: 24),
      afterIcon:
          Icon(SodaIcons.broadcasts_outlined, color: DColors.white, size: 24)),
  NavigatonItem(
      route: HomeScreen.route,
      beforeIcon: Icon(SodaIcons.article, color: DColors.white, size: 24),
      afterIcon:
          Icon(SodaIcons.article_outlined, color: DColors.white, size: 24)),
  NavigatonItem(
      route: ProfileScreen.route,
      beforeIcon: Icon(SodaIcons.profile, color: DColors.white, size: 24),
      afterIcon:
          Icon(SodaIcons.profile_outlined, color: DColors.white, size: 24)),
  NavigatonItem(
      route: SettingsScreen.route,
      beforeIcon: Icon(SodaIcons.settings, color: DColors.white, size: 24),
      afterIcon:
          Icon(SodaIcons.settings_outlined, color: DColors.white, size: 24)),
];

class NavigatonItem {
  final String route;
  final Icon beforeIcon;
  final Icon afterIcon;
  const NavigatonItem(
      {required this.route, required this.beforeIcon, Icon? afterIcon})
      : afterIcon = afterIcon ?? beforeIcon;
}

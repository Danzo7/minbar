import 'package:flutter/material.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';

const List<SettingTree> kDefaultSetting = [
  SettingTree(name: "اعدادات الحساب", leafs: [
    const SettingLeaf("المعلومات الشخصية", Icons.person),
    const SettingLeaf("الحماية والخصوصية", SodaIcons.security),
  ]),
  SettingTree(name: "اعدادات التطبيق", leafs: [
    const SettingLeaf("المظهر", SodaIcons.appearance),
    const SettingLeaf("الاشعارات", SodaIcons.notification),
    const SettingLeaf("اللغة", SodaIcons.language),
  ])
];

class SettingTree {
  final String name;
  final List<SettingLeaf> leafs;

  const SettingTree({required this.name, required this.leafs});
}

class SettingLeaf {
  final String text;
  final IconData icon;
  final List<Param>? params;
  const SettingLeaf(this.text, this.icon, {this.params});
}

enum ParamType {
  datePicker,
  textField,
  toggle,
  secret,
  checkbox,
}

class Param {
  final ParamType type;
  final String text;

  const Param({required this.type, required this.text});
}

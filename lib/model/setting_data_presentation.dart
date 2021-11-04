import 'package:flutter/material.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';

List<SettingTree> kDefaultSetting = [
  SettingTree(name: "اعدادات الحساب", leafs: [
    const SettingLeaf("المعلومات الشخصية", Icons.person, paramGroups: const []),
    SettingLeaf("الحماية والخصوصية", SodaIcons.security, paramGroups: [
      ParamGroups([
        ParamOptions([
          CheckBoxParam(true, description: "الجميع."),
          CheckBoxParam(true, description: "الاصدقاء فقط."),
          CheckBoxParam(true, description: "لا احد.")
        ], description: ".اظهار الحساب الشخصي")
      ], title: "الاعدادات العامة"),
      ParamGroups([
        RadioGroupOptions([
          RadioParam(true, description: "الجميع."),
          RadioParam(false, description: "الاصدقاء فقط."),
          RadioParam(false, description: "لا احد.")
        ], description: ".لا احد")
      ], title: "الاعدادات العامة")
    ]),
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
  final List<ParamGroups>? paramGroups;
  const SettingLeaf(this.text, this.icon, {this.paramGroups});
}

enum ParamType {
  datePicker,
  textField,
  toggle,
  checkbox,
  radio,
}

class ParamOptions extends ParamOptionNural {
  List<Param> options;
  ParamOptions(this.options, {description}) : super(description: description);
}

abstract class ParamOptionNural {
  String? description;
  bool isRadioGroup;

  ParamOptionNural({this.description, this.isRadioGroup = false});
}

class RadioGroupOptions extends ParamOptionNural {
  void setCurrentSelectedItem(int index) {
    options.forEach((element) {
      element.isSelected = options.indexOf(element) == index;
    });
  }

  List<RadioParam> options;
  RadioGroupOptions(this.options, {description})
      : super(description: description, isRadioGroup: true);
}

class ParamGroups {
  List<ParamOptionNural> params;
  String? title;
  ParamGroups(this.params, {this.title});
}

abstract class Param {
  final ParamType type;
  final String? detail;
  final String? description;
  const Param({required this.type, this.description, this.detail});
}

class CheckBoxParam extends Param {
  bool userValue;
  CheckBoxParam(this.userValue, {required String description, String? detail})
      : super(
            type: ParamType.checkbox, description: description, detail: detail);
}

class ToggleParam extends Param {
  bool userValue;
  ToggleParam(this.userValue) : super(type: ParamType.checkbox);
}

class RadioParam extends Param {
  bool isSelected;
  RadioParam(this.isSelected, {required String description})
      : super(type: ParamType.radio, description: description);
}

class InputBoxParam extends Param {
  final TextFieldType fieldType;
  String userValue;
  InputBoxParam(this.userValue, this.fieldType)
      : super(type: ParamType.checkbox);
}

enum TextFieldType { password, date, text }

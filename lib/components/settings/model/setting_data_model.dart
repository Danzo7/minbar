import 'package:flutter/material.dart';

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

enum OptionType {
  datePicker,
  textField,
  toggle,
  checkbox,
  radio,
}

class CheckboxOptionGroup extends Options {
  List<CheckboxOption> options;
  CheckboxOptionGroup(this.options, {description})
      : super(type: OptionType.checkbox, description: description);
}

abstract class Options {
  String? description;
  final OptionType type;
  Options({required this.type, this.description});
}

class RadioOptionGroup extends Options {
  int selectedIndex;
  List<Option> options;
  RadioOptionGroup(this.selectedIndex, this.options, {description})
      : super(type: OptionType.radio, description: description);
}

class ParamGroups {
  List<Options> params;
  String? title;
  ParamGroups(this.params, {this.title});
}

class Option {
  final String? detail;
  final String? description;
  const Option({this.description, this.detail});
}

class CheckboxOption extends Option {
  bool userValue;
  CheckboxOption(this.userValue, {required String description, String? detail})
      : super(description: description, detail: detail);
}

class ToggleOption extends Option {
  bool userValue;
  ToggleOption(this.userValue) : super();
}

class InputOption extends Options {
  final TextFieldType fieldType;
  String userValue;
  InputOption(this.userValue, this.fieldType, {String? description})
      : super(type: OptionType.textField, description: description);
}

enum TextFieldType { password, date, username, email, other }

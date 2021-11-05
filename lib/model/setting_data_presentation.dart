import 'package:flutter/material.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';

List<SettingTree> kDefaultSetting = [
  SettingTree(name: "اعدادات الحساب", leafs: [
    const SettingLeaf("المعلومات الشخصية", Icons.person, paramGroups: const []),
    SettingLeaf("الحماية والخصوصية", SodaIcons.security, paramGroups: [
      ParamGroups([
        CheckboxOptionGroup([
          CheckboxOption(true,
              description: "الجميع.", detail: "يمكن للجميع متابعة تثبيتاتك"),
          CheckboxOption(true,
              description: "المرخصون فقط.",
              detail: "يمكن للمتابعين المرخصين من قبلك برؤية منشوراتك "),
          CheckboxOption(true,
              description: " تعطيل الصفحة الشخصية.",
              detail:
                  "ازالة خاصي التثبيتات بحيث لا يمكن لك تثبيت اي منشور ولا الحصول على صفحة شخصية.")
        ], description: "اظهار الحساب الشخصي"),
        RadioOptionGroup([
          RadioOption(true, description: "الجميع."),
          RadioOption(false, description: "الاصدقاء فقط."),
          RadioOption(false, description: "لا احد.")
        ], description: "اظهار الحساب الشخصي."),
        InputOption("المتنبي", TextFieldType.username,
            description: "اسم المستخدم")
      ])
    ])
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
  void setCurrentSelectedItem(int index) {
    options.forEach((element) {
      element.isSelected = options.indexOf(element) == index;
    });
  }

  List<RadioOption> options;
  RadioOptionGroup(this.options, {description})
      : super(type: OptionType.radio, description: description);
}

class ParamGroups {
  List<Options> params;
  String? title;
  ParamGroups(this.params, {this.title});
}

abstract class Option {
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

class RadioOption extends Option {
  bool isSelected;
  RadioOption(this.isSelected, {required String description, String? detail})
      : super(description: description, detail: detail);
}

class InputOption extends Options {
  final TextFieldType fieldType;
  String userValue;
  InputOption(this.userValue, this.fieldType, {String? description})
      : super(type: OptionType.textField, description: description);
}

enum TextFieldType { password, date, username, email, other }

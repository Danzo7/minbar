import 'package:minbar_fl/components/settings/model/setting_data_model.dart';
import 'package:minbar_fl/components/theme/soda_icons.dart';

class PrivacySettings {
  static SettingLeaf settings =
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
      RadioOptionGroup(
          0,
          [
            Option(description: "الجميع."),
            Option(description: "الاصدقاء فقط."),
            Option(description: "لا احد.")
          ],
          description: "اظهار الحساب الشخصي."),
      InputOption("المتنبي", TextFieldType.username,
          description: "اسم المستخدم")
    ])
  ]);
}

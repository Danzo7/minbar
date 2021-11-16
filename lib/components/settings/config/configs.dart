import 'package:minbar_fl/components/settings/config/account_settings/personal_settings.dart';
import 'package:minbar_fl/components/settings/config/account_settings/privacy_settings.dart';
import 'package:minbar_fl/components/settings/config/app_settings/apearance_settings.dart';
import 'package:minbar_fl/components/settings/config/app_settings/language_settings.dart';
import 'package:minbar_fl/components/settings/config/app_settings/notification_settings.dart';
import 'package:minbar_fl/components/settings/config/dev_settings/dev_settings.dart';
import 'package:minbar_fl/components/settings/model/setting_data_model.dart';

SettingTree accountSettingsTree = SettingTree(name: "اعدادات الحساب", leafs: [
  PersonalSettings.settings,
  PrivacySettings.settings,
]);

SettingTree appSettingsTree = SettingTree(name: "اعدادات التطبيق", leafs: [
  ApearanceSettings.settings,
  NotificationSettings.settings,
  LanguageSettings.settings
]);

SettingTree devSettingsTree = SettingTree(name: "", leafs: [
  DevSettings.settings,
]);

List<SettingTree> kDefaultSetting = [
  accountSettingsTree,
  appSettingsTree,
  devSettingsTree
];

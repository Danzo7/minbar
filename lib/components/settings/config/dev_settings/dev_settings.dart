import 'package:flutter/material.dart';
import 'package:minbar_fl/components/settings/model/setting_data_model.dart';

class DevSettings {
  static SettingLeaf settings =
      SettingLeaf("Development Options", Icons.developer_mode, paramGroups: [
    ParamGroups([
      CheckboxOptionGroup([showPerformance, playOfflineTrack]),
    ])
  ]);

  static CheckboxOption showPerformance =
      CheckboxOption(false, description: "Show performance diagram");
  static CheckboxOption playOfflineTrack = CheckboxOption(false,
      description: "play default playtack when no internet connection");
}

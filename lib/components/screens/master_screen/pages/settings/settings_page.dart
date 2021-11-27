import 'package:flutter/material.dart';
import 'package:minbar_fl/api/fake_data.dart';
import 'package:minbar_fl/components/screens/master_screen/pages/settings/widgets/settings_tree.dart';
import 'package:minbar_fl/components/screens/master_screen/pages/settings/widgets/tree_leaf.dart';
import 'package:minbar_fl/components/settings/config/configs.dart';
import 'package:minbar_fl/components/screens/generated_settings/generated_settings_screen.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/components/widgets/misc/minbar_scaffold.dart';
import 'package:minbar_fl/components/widgets/slivers/profile_header.dart';
import 'package:minbar_fl/core/services/service_locator.dart';
import 'package:minbar_fl/misc/navigation.dart';

class SettingsScreen extends StatelessWidget {
  static const String route = "settings_screen";
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MinbarScaffold(
      withSafeArea: true,
      selectedIndex: 3,
      body: SettingsLayout(),
    );
  }
}

class SettingsLayout extends StatelessWidget {
  const SettingsLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: DColors.white,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: CustomScrollView(slivers: [
          ProfileHeader(
              user: FakeData.currentUser,
              maxHeight: 250,
              shrink: false,
              hasPopularity: false),
          SliverToBoxAdapter(
            child: Wrap(children: [
              ...kDefaultSetting.map((setting) => Tree(
                    name: setting.name,
                    children: [
                      ...setting.leafs
                          .map((leaf) => TreeLeaf(
                                icon: leaf.icon,
                                text: leaf.text,
                                onPressed: () => {
                                  if (leaf.paramGroups != null)
                                    app<MinbarNavigator>()
                                        .pushToParameterScreen(
                                            GeneratedSettingsScreen.route,
                                            options: SettingArgs(leaf.text,
                                                parameters: leaf.paramGroups!))
                                },
                              ))
                          .toList()
                    ].toList(),
                  ))
            ]),
          ),
          SliverPadding(padding: EdgeInsets.only(bottom: 90))
        ]));
  }
}

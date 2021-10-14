import 'package:flutter/material.dart';
import 'package:minbar_fl/components/screens/parameters_screen/parameters_screen.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/components/widgets/misc/minbar_scaffold.dart';
import 'package:minbar_fl/components/widgets/slivers/profile_header.dart';
import 'package:minbar_fl/model/setting_data_presentation.dart';
import 'widgets/settings_tree.dart';
import 'widgets/tree_leaf.dart';

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
          ProfileHeader(maxHeight: 250, shrink: false, hasPopularity: false),
          SliverToBoxAdapter(
            child: Wrap(children: [
              ...kDefaultSetting.map((setting) => Tree(
                    name: setting.name,
                    children: [
                      ...setting.leafs
                          .map((leaf) => TreeLeaf(
                                icon: leaf.icon,
                                text: leaf.text,
                                onPressed: () => Navigator.pushNamed(
                                    context, ParametersScreen.route,
                                    arguments: {"settingParams": leaf.params}),
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

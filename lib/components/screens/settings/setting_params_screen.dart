import 'package:flutter/material.dart';
import 'package:minbar_fl/components/screens/settings/setting_data_presentation.dart';
import 'package:minbar_fl/components/widgets/misc/minbar_scaffold.dart';

class SettingParamsScreen extends StatelessWidget {
  static const String route = "params";

  final List<Param> arguments;
  const SettingParamsScreen({Key? key, required this.arguments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MinbarScaffold(
      hasBottomNavigationBar: false,
      body: Wrap(
        children: [...arguments.map((e) => Text(e.text)).toList()],
      ),
    );
  }
}

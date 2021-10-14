import 'package:flutter/material.dart';
import 'package:minbar_fl/components/widgets/misc/minbar_scaffold.dart';
import 'package:minbar_fl/model/setting_data_presentation.dart';

class ParametersScreen extends StatelessWidget {
  static const String route = "params";

  final List<Param> arguments;
  const ParametersScreen({Key? key, required this.arguments}) : super(key: key);

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

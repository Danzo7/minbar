import 'package:flutter/material.dart';
import 'package:minbar_fl/components/screens/broadcast/Broadcast_page.dart';
import 'package:minbar_fl/components/widgets/misc/minbar_scaffold.dart';

class BroadcastScreen extends StatefulWidget {
  BroadcastScreen({Key? key}) : super(key: key);
  static const String route = 'broadcast';

  @override
  _BroadcastScreenState createState() => _BroadcastScreenState();
}

class _BroadcastScreenState extends State<BroadcastScreen> {
  @override
  Widget build(BuildContext context) {
    return MinbarScaffold(
      hasBottomNavigationBar: false,
      body: BroadcastPage(MediaQuery.of(context).size.height),
    );
  }
}

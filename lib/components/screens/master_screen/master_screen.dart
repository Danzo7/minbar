import 'package:flutter/material.dart';
import 'package:minbar_fl/components/widgets/misc/minbar_scaffold.dart';
import 'minbar_page_view.dart';
import 'pages/pages.dart';
export 'pages/pages.dart';

class MasterScreen extends StatefulWidget {
  const MasterScreen({Key? key}) : super(key: key);

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  PageController _controller = new PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return MinbarScaffold(
      selectedIndex: 0,
      withSafeArea: true,
      hasBottomNavigationBar: true,
      pageController: _controller,
      body: MinbarPageView(controller: _controller, children: [
        BroadcastsPage(),
        HomePage(),
        ProfilePage(),
        SettingsScreen(),
      ]),
    );
  }
}

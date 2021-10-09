import 'package:flutter/material.dart';
import 'package:snap_scroll_physics/snap_scroll_physics.dart';

class RefreshContentPage extends StatelessWidget {
  final dynamic Function()? onLoading, onRefresh;
  final Widget? header;
  final List<Widget> beforeRefreshSlivers;
  final List<Widget> afterRefreshSlivers;
  final SnapScrollPhysics? physics;
  RefreshContentPage({
    Key? key,
    this.onLoading,
    this.onRefresh,
    this.header,
    this.beforeRefreshSlivers = const <Widget>[],
    this.afterRefreshSlivers = const <Widget>[],
    this.physics,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Container();
  }
}

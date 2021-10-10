import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:snap_scroll_physics/snap_scroll_physics.dart';

class RefreshContentPage extends StatelessWidget {
  final Function()? onLoading, onRefresh;
  final Widget? header;
  final List<Widget> beforeRefreshSlivers;
  final List<Widget> afterRefreshSlivers;
  final SnapScrollPhysics? physics;
  RefreshContentPage({
    Key? key,
    this.onLoading,
    this.onRefresh,
    this.header,
    required this.refreshController,
    this.beforeRefreshSlivers = const <Widget>[],
    this.afterRefreshSlivers = const <Widget>[],
    this.physics,
  }) : super(key: key);
  final refreshController;
  Widget _refreshIndicator() => ClassicHeader(
        failedText: "حدث خطأأثناءالتحميل",
        completeText: "تم التحميل",
        idleText: "اسحب للتأهيل",
        refreshingText: "جار التحميل",
        releaseText: "افلت للتحميل",
      );
  Widget _loadIndicator() => ClassicFooter(
        failedText: "حدث خطأأثناءالتحميل",
        noDataText: "نهاية الصفحة",
        idleText: "",
        loadingText: "جار التحميل",
        canLoadingText: "افلت للتحميل",
        loadStyle: LoadStyle.ShowWhenLoading,
      );
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      onRefresh: onRefresh,
      onLoading: onLoading,
      physics: physics,
      header: header ?? _refreshIndicator(),
      child: CustomScrollView(slivers: [
        ...beforeRefreshSlivers,
        if (header != null) _refreshIndicator(),
        ...afterRefreshSlivers,
        _loadIndicator(),
        SliverPadding(padding: EdgeInsets.only(bottom: 80))
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Timeline extends StatelessWidget {
  final Function()? onLoading, onRefresh;
  final Widget? header;
  final List<Widget> beforeRefreshSlivers;
  final List<Widget> afterRefreshSlivers;
  final ScrollPhysics? physics;
  final double bottomPadding;
  final RefreshController refreshController;
  final Widget content;
  Timeline({
    Key? key,
    this.onLoading,
    this.onRefresh,
    this.header,
    required this.refreshController,
    this.beforeRefreshSlivers = const <Widget>[],
    this.afterRefreshSlivers = const <Widget>[],
    this.physics,
    this.bottomPadding = 100,
    required this.content,
  }) : super(key: key);
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

  void _placeholder() async {
    await Future.delayed(Duration(milliseconds: 500), () {});
    refreshController.refreshCompleted();
    refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      onRefresh: onRefresh ?? _placeholder,
      onLoading: onLoading ?? _placeholder,
      physics: physics,
      header: header ?? _refreshIndicator(),
      child: CustomScrollView(key: key, slivers: [
        ...beforeRefreshSlivers,
        if (header != null) _refreshIndicator(),
        content,
        ...afterRefreshSlivers,
        _loadIndicator(),
        SliverPadding(padding: EdgeInsets.only(bottom: bottomPadding))
      ]),
    );
  }
}

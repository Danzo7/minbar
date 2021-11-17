import 'package:flutter/material.dart';
import 'package:minbar_fl/components/common/broadcast/broadcastBox/widgets/broadcast_box.dart';
import 'package:minbar_fl/model/cast.dart';

///only use as slivers.
class BroadcastList extends StatelessWidget {
  final List<Cast> broadcasts;

  const BroadcastList(this.broadcasts, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
                padding: const EdgeInsets.only(left: 33, bottom: 10, right: 33),
                child: BroadcastBox(broadcasts[index])),
            childCount: broadcasts.length));
  }
}

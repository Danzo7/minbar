import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minbar_fl/components/common/broadcast/broadcastBox/widgets/broadcast_box.dart';
import 'package:minbar_fl/components/common/timelines/broadcasts_timeline/bloc/casts_bloc.dart';
import 'package:minbar_fl/components/widgets/casts_placeholder.dart';
import 'package:minbar_fl/model/cast.dart';

///only use as slivers.
class BroadcastList extends StatelessWidget {
  const BroadcastList({Key? key}) : super(key: key);

  SliverList listBuilder(List<Cast> items) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
                padding: const EdgeInsets.only(left: 33, bottom: 10, right: 33),
                child: items.isNotEmpty
                    ? BroadcastBox(items[index])
                    : CastPlaceholder()),
            childCount: items.length + (items.isEmpty ? 30 : 0)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CastsBloc, CastsState>(
      builder: (context, state) {
        return listBuilder(context.read<CastsBloc>().repo.data);
      },
    );
  }
}

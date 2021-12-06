import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:minbar_fl/components/common/timelines/broadcasts_timeline/bloc/casts_repository.dart';
import 'package:minbar_fl/model/cast.dart';

part 'casts_event.dart';
part 'casts_state.dart';
part 'casts_bloc.freezed.dart';

class CastsBloc extends Bloc<CastsEvent, CastsState> {
  final CastsRepository repo = CastsRepository();
  CastsBloc() : super(_Initial()) {
    on<_Fetch>((event, emit) async {
      emit(CastsState.loading());
      await repo
          .fetchItems()
          .whenComplete(() => emit(CastsState.loaded(repo.data)));
    });
  }
}

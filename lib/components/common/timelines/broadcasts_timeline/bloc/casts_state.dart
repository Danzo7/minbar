part of 'casts_bloc.dart';

@freezed
class CastsState with _$CastsState {
  const factory CastsState.initial() = _Initial;
  const factory CastsState.failed() = _Failed;

  const factory CastsState.loaded(List<Cast> data) = _Loaded;

  const factory CastsState.loading() = _Fetching;
}

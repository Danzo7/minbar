part of 'casts_bloc.dart';

@freezed
class CastsEvent with _$CastsEvent {
  const factory CastsEvent.started() = _Started;
  const factory CastsEvent.fetch() = _Fetch;
}

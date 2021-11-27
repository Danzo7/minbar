part of 'postlist_bloc.dart';

@freezed
class PostlistEvent with _$PostlistEvent {
  const factory PostlistEvent.started() = _Started;
}
part of 'post_bloc.dart';

@freezed
class PostEvent with _$PostEvent {
  const factory PostEvent.hide() = _Hide;

  const factory PostEvent.like() = _Like;

  const factory PostEvent.pin() = _Pin;
}

part of 'posts_bloc.dart';

@freezed
class PostsEvent with _$PostsEvent {
  const factory PostsEvent.fetch() = _Fetch;

  const factory PostsEvent.hide(Publication pub) = _Hide;

  const factory PostsEvent.like(Publication pub, bool clicked) = _Like;

  const factory PostsEvent.pin(Publication pub) = _Pin;

  const factory PostsEvent.started() = _Started;
}

part of 'posts_bloc.dart';

@freezed
class PostsState with _$PostsState {
  const factory PostsState.failed() = _Failed;

  const factory PostsState.loaded(List<Publication> data) = _Loaded;

  const factory PostsState.loading() = _Fetching;

  const factory PostsState.started() = _Initial;

  // const factory PostsState.liked() = _Liked;

  // const factory PostsState.pinned() = _Pinned;
}

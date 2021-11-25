part of 'post_bloc.dart';

@freezed
class PostState with _$PostState {
  const factory PostState.initial(
    Publication postData, {
    required bool liked,
    required bool pinned,
    required bool hidden,
  }) = _Initial;
}

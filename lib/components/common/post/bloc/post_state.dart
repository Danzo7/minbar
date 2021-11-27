part of 'post_bloc.dart';

@freezed
class PostState with _$PostState {
  const factory PostState.initial(Publication postData) = _Initial;
  const factory PostState.inProgress() = _InProgress;
  const factory PostState.done(Publication postData) = _Done;
}

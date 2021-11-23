part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PinPost extends PostState {}

class UnpinPost extends PostState {}

class LikePost extends PostState {}

class DislikePost extends PostState {}

class HidePost extends PostState {}

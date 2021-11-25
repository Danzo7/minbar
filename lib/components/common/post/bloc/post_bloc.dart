import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:minbar_fl/model/publication.dart';

part 'post_event.dart';
part 'post_state.dart';
part 'post_bloc.freezed.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(Publication postData)
      : super(PostState.initial(postData,
            hidden: false, liked: postData.hasHeart, pinned: postData.hasPin)) {
    on<PostEvent>((event, emit) {
      event.when(deslike: () {
        //  Publication pp = state.postData.copyWith(hasHeart: true);

        //   FakeData.pub[FakeData.pub.indexOf(state.postData)] = pp;
        //    emit(state.copyWith(postData: pp, liked: false));
      }, hide: () {
        emit(state.copyWith(liked: false));
      }, like: () {
        emit(state.copyWith(liked: true));
      }, pin: () {
        emit(state.copyWith(liked: false));
      }, unpin: () {
        emit(state.copyWith(liked: false));
      });
    });
  }
}

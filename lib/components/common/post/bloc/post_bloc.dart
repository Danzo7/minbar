import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:minbar_fl/api/fake_data.dart';
import 'package:minbar_fl/model/publication.dart';

part 'post_event.dart';
part 'post_state.dart';
part 'post_bloc.freezed.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(Publication postData) : super(PostState.initial(postData)) {
    on<PostEvent>((event, emit) {
      event.when(
          hide: () {},
          like: () async {
            emit(PostState.inProgress());

            await FakeData.updatePublication(postData.copyWith(
                heartCount: postData.heartCount + 1,
                hasHeart: !postData.hasHeart));
          },
          pin: () {
            emit(state);
          });
    });
  }
}

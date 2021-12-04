import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:minbar_fl/components/common/timelines/posts_timeline/posts_repository.dart';
import 'package:minbar_fl/model/publication.dart';

part 'posts_event.dart';
part 'posts_state.dart';
part 'posts_bloc.freezed.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(_Initial()) {
    on<_Fetch>((event, emit) async {
      emit(PostsState.loading());
      await repo
          .fetchItems()
          .whenComplete(() => emit(PostsState.loaded(repo.data)));
    });
  }

  final PostsRepository repo = PostsRepository();
}

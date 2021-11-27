import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'postlist_event.dart';
part 'postlist_state.dart';
part 'postlist_bloc.freezed.dart';

class PostlistBloc extends Bloc<PostlistEvent, PostlistState> {
  PostlistBloc() : super(_Initial()) {
    on<PostlistEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

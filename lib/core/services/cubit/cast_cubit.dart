import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minbar_fl/core/services/AudioService.dart';
import 'package:minbar_fl/model/cast.dart';

part 'cast_state.dart';

class CastCubit extends Cubit<CastState> {
  final AudioService service;
  CastCubit(this.service) : super(IdleState(service));

  Future<void> playCast(Cast cast) async {
    await service.playCast(castId: cast.castId);
    emit(CastSelected(cast, service));
  }
}

enum CastStates {
  castSelected,
}
/*
Type event 
event Start {castSelected->loading->playing}
event Stop {if(castSelected)->stop->castUnselected}
data=cast
data->event->state


event.notify(castSelected(cast));
event.notify(loading)
...
event.eventListener(
  
  builder:(data,state)if(state ==state.loading && data=something)
  container(data);
)

*/
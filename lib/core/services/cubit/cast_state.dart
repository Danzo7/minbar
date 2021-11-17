part of 'cast_cubit.dart';

abstract class CastState extends Equatable {
  final service;
  const CastState(this.service);

  @override
  List<Object> get props => [];
}

class IdleState extends CastState {
  IdleState(service) : super(service);
}

class CastSelected extends CastState {
  final Cast cast;

  CastSelected(this.cast, service) : super(service);
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
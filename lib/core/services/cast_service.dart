import 'package:flutter/widgets.dart';
import 'package:minbar_fl/model/cast.dart';

import 'AudioService.dart';
import 'service_locator.dart';

class CastService extends ChangeNotifier {
  Cast? currentCast;
  bool setCast(Cast cast) {
    if (cast == currentCast)
      return false;
    else {
      currentCast = cast;
      notifyListeners();
    }
    return true;
  }

  playCast(Cast cast) {
    if (!setCast(cast)) {
      app<AudioService>().playerState.playing
          ? app<AudioService>().pause()
          : app<AudioService>().play();
    } else
      app<AudioService>().playCast(castId: currentCast?.castId);
  }
}

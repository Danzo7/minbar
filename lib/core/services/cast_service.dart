import 'package:flutter/widgets.dart';
import 'package:minbar_fl/core/services/audio_service.dart';
import 'package:minbar_fl/core/services/service_locator.dart';
import 'package:minbar_fl/model/cast.dart';

class CastService extends ChangeNotifier {
  Cast? currentCast;

  bool setCast(Cast cast) {
    if (cast == currentCast) {
      return false;
    } else {
      currentCast = cast;
      notifyListeners();
    }
    return true;
  }

  Future<bool> playCast(Cast cast) async {
    if (!setCast(cast)) {
      app<AudioService>().playerState.playing
          ? await app<AudioService>().pause()
          : await app<AudioService>().play();
    } else {
      await app<AudioService>().playCast(castId: cast.castId);
    }
    return true;
  }

  Future<bool> pauseOrStop() async {
    if (app<AudioService>().playing) {
      await app<AudioService>().pause();
      return false;
    } else {
      currentCast = null;
      notifyListeners();
      await app<AudioService>().stop();
      return true;
    }
  }

  Future<bool> stop() async {
    currentCast = null;
    notifyListeners();
    await app<AudioService>().stop();
    return true;
  }
}

import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:rxdart/rxdart.dart';

class AudioService extends AudioPlayer {
  Future<void> playCast({required String castId}) async {
    await setUrl(
        castId != "0" ? castId : "https://edge.mixlr.com/channel/rwumx");
    await play();
  }

  AudioService() : super() {
    initialize();
  }
  Future<void> initialize() async {
    // Inform the operating system of our app's audio attributes etc.
    // We pick a reasonable default for an app that plays speech.
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
  }

  Stream<BroadcastPositionData> get broadcastPositionData =>
      Rx.combineLatest2<Duration, Duration, BroadcastPositionData>(
          positionStream, bufferedPositionStream, (position, bufferedPosition) {
        return BroadcastPositionData(position, bufferedPosition);
      });
}

class BroadcastPositionData {
  final Duration position;
  final Duration bufferedPosition;

  BroadcastPositionData(this.position, this.bufferedPosition);
}

import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:rxdart/rxdart.dart';

class AudioService {
  late AudioPlayer player = AudioPlayer();
  Stream<PlayerState> get playerStateStream => player.playerStateStream;
  PlayerState get playerState => player.playerState;
  void playCast({String? castId}) async {
    await setUrl("https://edge.mixlr.com/channel/rwumx");
    player.play();
  }

  void pause() async {
    player.pause();
  }

  void play() async {
    player.play();
  }

  Future<void> initialize() async {
    // Inform the operating system of our app's audio attributes etc.
    // We pick a reasonable default for an app that plays speech.
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
  }

  Future<void> setUrl(url) async {
    try {
      await player.setUrl(url);
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  Stream<BroadcastPositionData> get broadcastPositionData =>
      Rx.combineLatest2<Duration, Duration, BroadcastPositionData>(
          player.positionStream, player.bufferedPositionStream,
          (position, bufferedPosition) {
        return BroadcastPositionData(position, bufferedPosition);
      });
}

class BroadcastPositionData {
  final Duration position;
  final Duration bufferedPosition;

  BroadcastPositionData(this.position, this.bufferedPosition);
}

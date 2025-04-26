// import 'package:audio_service/audio_service.dart';
// import 'package:audioplayers/audioplayers.dart';

// class AudioPlayerTask extends BackgroundAudioTask {
//   final AudioPlayer _player = AudioPlayer();
//   late final StreamController<PlaybackState> _playbackStateController;

//   AudioPlayerTask() {
//     _playbackStateController = StreamController<PlaybackState>();

//     _player.onPlayerStateChanged.listen((state) {
//       _playbackStateController.add(PlaybackState(
//         controls: [
//           MediaControl.playPause,
//           MediaControl.stop,
//         ],
//         playing: state == PlayerState.playing,
//         processingState: AudioProcessingState.ready,
//       ));
//     });

//     _player.onPositionChanged.listen((position) {
//       _playbackStateController.add(PlaybackState(
//         controls: [
//           MediaControl.playPause,
//           MediaControl.stop,
//         ],
//         updatePosition: position,
//         playing: _player.state == PlayerState.playing,
//         processingState: AudioProcessingState.ready,
//       ));
//     });

//     _player.onDurationChanged.listen((duration) {
//       mediaItem.add(MediaItem(
//         id: "1",
//         title: "الرقية الشرعية",
//         album: "الرقية الشرعية لعلاج السحر والحسد",
//         duration: duration,
//         artUri: Uri.parse("https://images.unsplash.com/photo-1542816417-0983c9c9ad53"),
//       ));
//     });
//   }

//   @override
//   Future<void> play() => _player.resume();

//   @override
//   Future<void> pause() => _player.pause();

//   @override
//   Future<void> stop() => _player.stop();

//   @override
//   Future<void> seek(Duration position) => _player.seek(position);

//   @override
//   Future<void> onStop() async {
//     await _player.stop();
//     super.onStop();
//   }

//   @override
//   Stream<PlaybackState> get playbackState => _playbackStateController.stream;
// }

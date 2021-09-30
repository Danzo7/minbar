import 'package:timeago/timeago.dart' as timeago;

class Publication {
  final String id;
  final String authorId;
  final String? _timestamp;
  final String authorName;
  final String authorAvatar;
  final String content;
  final String type;
  final DateTime date;
  final int likeCount;
  final int pinCount;
  final bool hasPodcast;
  final String? podcastId;

  const Publication(
      {this.authorId = "-1",
      this.id = "-1",
      this.podcastId,
      required this.authorName,
      required this.authorAvatar,
      required this.content,
      required this.type,
      required this.date,
      required this.likeCount,
      required this.pinCount,
      required this.hasPodcast,
      timestamp})
      : _timestamp = timestamp;
  String get timestamp {
    return _timestamp ?? timeago.format(date, locale: 'ar');
  }
}

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
  final int heartCount;
  final int pinCount;
  final String? castId;
  final bool hasHeart;
  final bool hasPin;

  const Publication(
      {this.authorId = "-1",
      this.id = "-1",
      this.castId,
      required this.authorName,
      required this.authorAvatar,
      required this.content,
      required this.type,
      required this.date,
      required this.heartCount,
      required this.pinCount,
      this.hasHeart = false,
      this.hasPin = false,
      timestamp})
      : _timestamp = timestamp;
  String get timestamp {
    return _timestamp ?? timeago.format(date, locale: 'ar');
  }

  bool get hasCast => castId != null;
}

import 'package:minbar_fl/model/user.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'cast.dart';

class Publication {
  final String id;
  final UserData author;
  final String? _timestamp;
  final String content;
  final String type;
  final DateTime date;
  final int heartCount;
  final int pinCount;
  final Cast? cast;
  final bool hasHeart;
  final bool hasPin;
  final bool hasMedia;

  const Publication(
      {required this.author,
      this.id = "-1",
      this.cast,
      required this.content,
      required this.type,
      required this.date,
      required this.heartCount,
      required this.pinCount,
      this.hasHeart = false,
      this.hasPin = false,
      timestamp,
      this.hasMedia = false})
      : _timestamp = timestamp;
  String get timestamp {
    return _timestamp ?? timeago.format(date, locale: 'ar');
  }

  bool get hasCast => cast != null;
}

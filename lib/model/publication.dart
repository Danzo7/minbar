import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:minbar_fl/model/cast.dart';
import 'package:minbar_fl/model/user.dart';
import 'package:timeago/timeago.dart' as timeago;

part 'publication.freezed.dart';

@freezed
class Publication with _$Publication {
  const Publication._();
  factory Publication({
    @Default('-1') String id,
    required UserData author,
    String? defTimestamp,
    required String content,
    required DateTime date,
    required int heartCount,
    required int pinCount,
    Cast? cast,
    @Default(false) bool hasHeart,
    @Default(false) bool hasPin,
    @Default(false) bool hasMedia,
  }) = _Publication;

  String get timestamp {
    return defTimestamp ?? timeago.format(date, locale: 'ar');
  }

  bool get hasCast => cast != null;
}

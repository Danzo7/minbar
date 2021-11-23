import 'package:equatable/equatable.dart';
import 'package:minbar_fl/model/user.dart';

class Cast extends Equatable {
  final String castId;
  final UserData host;
  final String field;
  final String subject;
  final int listeners;
  final String? duration;
  final Duration startDate;
  final Duration? endDate;
  final bool hasComments;
  const Cast(
      {this.castId = "0",
      this.endDate,
      this.hasComments = true,
      this.duration,
      this.startDate = Duration.zero,
      this.listeners = 0,
      required this.host,
      required this.field,
      required this.subject});

  bool get isLive => duration == null;
  @override
  List<Object?> get props =>
      [castId, host, field, subject, duration, listeners];
}
//host/userTOken?castID=id
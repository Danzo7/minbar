import 'package:equatable/equatable.dart';

class Cast extends Equatable {
  final String castId;
  final String hostId;
  final String hostUsername;
  final String field;
  final String subject;
  final int listeners;
  final String? duration;
  final Duration timeAgo;
  const Cast(
      {this.castId = "0",
      this.duration,
      this.timeAgo = Duration.zero,
      this.hostId = "0",
      this.listeners = 0,
      required this.hostUsername,
      required this.field,
      required this.subject});

  bool get isLive => duration == null;
  @override
  List<Object?> get props =>
      [castId, hostId, hostUsername, field, subject, duration, listeners];
}
//host/userTOken?castID=id
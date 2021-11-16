import 'package:equatable/equatable.dart';

class Cast extends Equatable {
  final String castId;
  final String hostId;
  final String hostUsername;
  final String field;
  final String subject;
  final int views;

  const Cast(
      {this.castId = "0",
      this.hostId = "0",
      this.views = 0,
      required this.hostUsername,
      required this.field,
      required this.subject});

  @override
  List<Object?> get props => [castId, hostId, hostUsername, field, subject];
}

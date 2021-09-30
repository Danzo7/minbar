class Cast {
  final String castId;
  final String hostId;
  final String hostUsername;
  final String field;
  final String subject;

  const Cast(
      {this.castId = "0",
      this.hostId = "0",
      required this.hostUsername,
      required this.field,
      required this.subject});
}

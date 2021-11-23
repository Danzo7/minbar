class UserData {
  final String userId;
  final String firstName, lastName;
  final String? email;
  final DateTime birthDate;
  final String? avatarUrl;
  final String? description;
  final bool streamable;
  String get fullName => "$firstName $lastName";

  UserData(
      {required this.userId,
      required this.firstName,
      required this.lastName,
      this.email,
      required this.birthDate,
      this.avatarUrl,
      this.description,
      this.streamable = false});
}

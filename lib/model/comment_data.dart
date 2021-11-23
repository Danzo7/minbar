import 'package:minbar_fl/model/user.dart';

class CommentData {
  final String content;
  final UserData user;
  final DateTime? date;
  const CommentData(this.content, this.user, {this.date});
}

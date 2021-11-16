class CommentData {
  final String content;
  final String userId;
  final String? date;
  const CommentData(this.content, {this.userId = "-1", this.date});
}

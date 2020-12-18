class BlogUser {
  final String profilePicture;
  final String name;
  final bool isAuthor;
  final bool isLoggedIn;

  bool get isAuthorLoggedIn => isAuthor && isLoggedIn;

  BlogUser({this.isAuthor, this.isLoggedIn, this.profilePicture, this.name});
}

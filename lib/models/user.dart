class User {
  final int id;
  final String? email;
  final String userName;
  final String? password;
  final String? confirmPassword;
  final String? accessToken;
  final String? refreshToken;
  final bool isActive;

  User(this.id, this.email, this.userName, this.password, this.confirmPassword,
      this.accessToken, this.refreshToken, this.isActive);
}

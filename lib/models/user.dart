class User {
  final int? id;
  final String? email;
  final String? userName;
  final String? password;
  final String? confirmPassword;
  final String? accessToken;
  final String? refreshToken;
  final bool? isActive;

  User(
      {this.id,
      this.email,
      this.userName,
      this.password,
      this.confirmPassword,
      this.accessToken,
      this.refreshToken,
      this.isActive});

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userName = json['userName'],
        email = json['email'],
        password = json['password'],
        confirmPassword = json['confirmPassword'],
        accessToken = json['accessToken'],
        refreshToken = json['refreshToken'],
        isActive = json['isActive'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'userName': userName,
        'password': password,
        'confirmPassword': confirmPassword,
        'accessToken': accessToken,
        'refreshToken': refreshToken,
        'isActive': isActive,
      };
}

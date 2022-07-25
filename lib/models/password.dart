class Password {
  int? id;
  String? contentName;
  String? password;
  int? categoryID;
  int? userID;

  Password(
      {this.id, this.contentName, this.password, this.categoryID, this.userID});

  Password.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        contentName = json['contentName'],
        password = json['password'],
        categoryID = json['categoryID'],
        userID = json['userID'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'contentName': contentName,
        'password': password,
        'categoryID': categoryID,
        'userID': userID,
      };
}

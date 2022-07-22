class Category {
  int? id;
  String? categoryName;
  int? userID;
  int? categoryTotal;

  Category({this.id, this.categoryName, this.userID, this.categoryTotal});

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        categoryName = json['categoryName'],
        userID = json['userID'],
        categoryTotal = json['categoryTotal'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'categoryName': categoryName,
        'userID': userID,
        'categoryTotal': categoryTotal,
      };
}

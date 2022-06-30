class Category {
  final int? id;
  final String? categoryName;
  final int? userID;
  final int? categoryTotal;

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

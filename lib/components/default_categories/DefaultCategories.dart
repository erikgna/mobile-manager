import 'package:flutter/material.dart';

import '../../models/Category.dart';

class DefaultCategories extends StatefulWidget {
  final List<Category> categories;
  const DefaultCategories({Key? key, required this.categories})
      : super(key: key);

  @override
  State<DefaultCategories> createState() => _DefaultCategoriesState();
}

class _DefaultCategoriesState extends State<DefaultCategories> {
  @override
  Widget build(BuildContext context) {
    final List listedCategories = [];

    for (Category category in widget.categories) {
      TextButton(child: Text(category.categoryName!), onPressed: () {});
    }

    return ListView(
      children: [...listedCategories],
    );
  }
}

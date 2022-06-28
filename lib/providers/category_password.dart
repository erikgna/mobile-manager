import 'package:flutter/cupertino.dart';
import 'package:passwords_client/models/category.dart';

enum CategoryProviderState { success, loading, error }

class CategoryProvider extends ChangeNotifier {
  final List<Category> categories = [];

  Future<void> getCategories() async {
    categories.add(Category(1, 'Amazon', 1, 1));
  }
}

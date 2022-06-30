import 'package:flutter/cupertino.dart';
import 'package:passwords_client/api/category_web.dart';
import 'package:passwords_client/models/category.dart';

enum CategoryProviderState { success, loading, error }

class CategoryProvider extends ChangeNotifier {
  final CategoryWebClient _categoryWeb = CategoryWebClient();
  final List<Category> categories = [];

  Future<Category?> getCategory(int id) async {
    try {
      return await _categoryWeb.getCategory(id);
    } catch (e) {
      return null;
    }
  }

  Future<void> getCategories(List<Category> catgs) async {
    try {
      categories.clear();

      if (catgs.isEmpty) {
        categories.addAll(await _categoryWeb.getCategories());

        notifyListeners();

        return;
      }

      categories.addAll(catgs);

      return;
    } catch (e) {
      return;
    }
  }

  Future<bool> createCategory(Category category) async {
    try {
      final Category categoryCreated =
          await _categoryWeb.createCategory(category);

      categories.add(categoryCreated);

      notifyListeners();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateCategory(Category category) async {
    try {
      await _categoryWeb.editCategory(category);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteCategory(int id) async {
    try {
      await _categoryWeb.deleteCategory(id);
      categories.removeWhere((category) => category.id == id);

      notifyListeners();

      return true;
    } catch (e) {
      return false;
    }
  }
}

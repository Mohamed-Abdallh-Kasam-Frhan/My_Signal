import 'package:flutter/material.dart';
import 'package:mysignal/models/category.dart';
import 'package:mysignal/models/signal.dart';
import 'package:mysignal/data/repositories/category_repository.dart';
import 'package:mysignal/data/datasources/supabase_helper.dart';

class AppProvider extends ChangeNotifier {
  final CategoryRepository _repository = CategoryRepository();
  final SupabaseHelper _supabaseHelper = SupabaseHelper();

  List<Category> _categories = [];
  Set<int> _favorites = {};

  List<Category> get categories => _categories;
  Set<int> get favorites => _favorites;

  AppProvider() {
    loadData();
  }

  Future<void> loadData() async {
    _categories = await _repository.getAllCategories();
    try {
      _favorites = await _supabaseHelper.getFavorites();
    } catch (e) {
      _favorites = {};
    }
    notifyListeners();
  }

  bool isFavorite(int id) {
    return _favorites.contains(id);
  }

  Future<void> toggleFavorite(int id) async {
    try {
      if (_favorites.contains(id)) {
        _favorites.remove(id);
        await _supabaseHelper.removeFavorite(id);
      } else {
        _favorites.add(id);
        await _supabaseHelper.addFavorite(id);
      }
    } catch (e) {
      if (_favorites.contains(id)) {
        _favorites.remove(id);
      } else {
        _favorites.add(id);
      }
    }
    notifyListeners();
  }

  Future<void> addCategory(String title, IconData icon, Color color) async {
    try {
      await _supabaseHelper.insertCategory(title, icon.codePoint, color.toARGB32());
    } catch (e) {
      final newId = _categories.length + 1;
      _categories.add(Category(
        id: newId,
        title: title,
        numberOf: 0,
        icon: icon,
        color: color,
        signals: [],
      ));
    }
    await loadData();
  }

  Future<void> addSignal({
    required int categoryId,
    required String title,
    required String urlImage,
    required String urlImageMean,
    required String description,
  }) async {
    try {
      await _supabaseHelper.insertSignal(
        categoryId: categoryId,
        title: title,
        urlImage: urlImage,
        urlImageMean: urlImageMean,
        description: description,
      );
    } catch (e) {
      final index = _categories.indexWhere((c) => c.id == categoryId);
      if (index != -1) {
        final category = _categories[index];
        final newId = 1000 + category.signals.length + 1;
        category.signals.add(Signal(
          id: newId,
          title: title,
          urlImage: urlImage,
          urlImageMean: urlImageMean,
          description: description,
        ));
      }
    }
    await loadData();
  }
}

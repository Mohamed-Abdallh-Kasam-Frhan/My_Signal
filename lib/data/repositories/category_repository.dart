import 'package:mysignal/models/category.dart';
import 'package:mysignal/data/datasources/category_data.dart';
import 'package:mysignal/data/datasources/supabase_helper.dart';

class CategoryRepository {
  final SupabaseHelper _supabaseHelper = SupabaseHelper();

  Future<List<Category>> getAllCategories() async {
    try {
      return await _supabaseHelper.getCategories();
    } catch (e) {
      return mainCategories;
    }
  }
}

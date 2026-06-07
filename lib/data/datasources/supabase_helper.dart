import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mysignal/models/category.dart';
import 'package:mysignal/models/signal.dart';
import 'package:mysignal/data/datasources/category_data.dart';
import 'package:flutter/material.dart';

class SupabaseHelper {
  static final SupabaseHelper _instance = SupabaseHelper._internal();
  factory SupabaseHelper() => _instance;
  SupabaseHelper._internal();

  final SupabaseClient _client = Supabase.instance.client;

  

  Future<List<Category>> getCategories() async {
    
    final List<dynamic> catData = await _client
        .from('categories')
        .select()
        .order('id', ascending: true);

    
    final List<dynamic> sigData = await _client
        .from('signals')
        .select()
        .order('id', ascending: true);

    if (catData.isEmpty) {
      await _seedDatabase();
      return getCategories(); 
    }

    
    final Map<int, List<Signal>> signalsByCategory = {};
    for (final sigMap in sigData) {
      final int catId = sigMap['category_id'] as int;
      final signal = Signal(
        id: sigMap['id'] as int,
        title: sigMap['title'] as String,
        urlImage: sigMap['url_image'] as String,
        urlImageMean: sigMap['url_image_mean'] as String,
        description: sigMap['description'] as String?,
      );
      signalsByCategory.putIfAbsent(catId, () => []).add(signal);
    }

    return catData.map<Category>((catMap) {
      final int catId = catMap['id'] as int;
      return Category(
        id: catId,
        title: catMap['title'] as String,
        numberOf: catMap['number_of'] as int? ?? 0,
        icon: IconData(catMap['icon_code'] as int, fontFamily: 'MaterialIcons'),
        color: Color(catMap['color_value'] as int),
        signals: signalsByCategory[catId] ?? [],
      );
    }).toList();
  }

  Future<void> _seedDatabase() async {
    
    for (final category in mainCategories) {
      final insertedCat = await _client.from('categories').insert({
        'id': category.id,
        'title': category.title,
        'icon_code': category.icon.codePoint,
        'color_value': category.color.toARGB32(),
        'number_of': category.numberOf,
      }).select().single();

      final int categoryId = insertedCat['id'] as int;

      for (final signal in category.signals) {
        await _client.from('signals').insert({
          'category_id': categoryId,
          'title': signal.title,
          'url_image': signal.urlImage,
          'url_image_mean': signal.urlImageMean,
          'description': signal.description ?? '',
        });
      }
    }
  }

  Future<void> insertCategory(String title, int iconCode, int colorValue) async {
    await _client.from('categories').insert({
      'title': title,
      'icon_code': iconCode,
      'color_value': colorValue,
      'number_of': 0,
    });
  }

  Future<void> insertSignal({
    required int categoryId,
    required String title,
    required String urlImage,
    required String urlImageMean,
    required String description,
  }) async {
    
    await _client.from('signals').insert({
      'category_id': categoryId,
      'title': title,
      'url_image': urlImage,
      'url_image_mean': urlImageMean,
      'description': description,
    });

    
    final List<dynamic> catData = await _client
        .from('categories')
        .select('number_of')
        .eq('id', categoryId);
    
    if (catData.isNotEmpty) {
      final currentNum = (catData.first['number_of'] as int? ?? 0);
      await _client
          .from('categories')
          .update({'number_of': currentNum + 1})
          .eq('id', categoryId);
    }
  }

  

  Future<Set<int>> getFavorites() async {
    final List<dynamic> favData = await _client.from('favorites').select('id');
    return favData.map<int>((fav) => fav['id'] as int).toSet();
  }

  Future<void> addFavorite(int id) async {
    await _client.from('favorites').upsert({'id': id});
  }

  Future<void> removeFavorite(int id) async {
    await _client.from('favorites').delete().eq('id', id);
  }
}

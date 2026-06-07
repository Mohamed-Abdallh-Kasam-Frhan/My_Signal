import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mysignal/providers/app_provider.dart';
import 'package:mysignal/widgets/common/sub_category_card.dart';
import 'package:mysignal/core/theme/colors.dart';
import 'package:mysignal/models/signal.dart';
import 'package:mysignal/screens/signal/detils_signal.dart';
import 'package:mysignal/models/category.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, child) {
        final favorites = provider.favorites;
        final allSubCategories = <Signal>[];

        for (final category in provider.categories) {
          allSubCategories.addAll(category.signals);
        }

        final favoriteSubCategories = allSubCategories
            .where((sub) => favorites.contains(sub.id))
            .toList();

        if (favoriteSubCategories.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_border,
                  size: 60,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(height: 16),
                Text(
                  'لا توجد عناصر في المفضلة',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'أضف بعض العناصر إلى المفضلة',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: favoriteSubCategories.length,
          itemBuilder: (context, index) {
            final item = favoriteSubCategories[index];

            Category? parent;
            for (final c in provider.categories) {
              if (c.signals.any((s) => s.id == item.id)) {
                parent = c;
                break;
              }
            }

            return SubCategoryCard(
              id: item.id,
              title: item.title,
              urlImage: item.urlImage,
              subTitle: parent?.title,
              onTap: () {
                if (parent != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailsSignalScreen(
                        signal: item,
                        category: parent!,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تعذر فتح التفاصيل')),
                  );
                }
              },
            );
          },
        );
      },
    );
  }
}

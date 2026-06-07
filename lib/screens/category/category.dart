import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mysignal/providers/app_provider.dart';
import 'package:mysignal/screens/category/category_card.dart';
import 'package:mysignal/screens/signal/signal.dart';
import 'package:mysignal/core/theme/colors.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, child) {
        final categories = provider.categories;
        return Container(
          color: AppColors.scaffoldBackground,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: GridView.builder(
              itemCount: categories.length,
              //انشاء شبكة بعدة اعمدة ثابتة
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                //childAspectRatio: 1.2,
              ),
              itemBuilder: (context, index) {
                final category = categories[index];

                return InkWell(
                  splashColor: Colors.amberAccent,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SignalScreen(categoryId: category.id),
                      ),
                    );
                  },
                  child: CategoryCard(element: category),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

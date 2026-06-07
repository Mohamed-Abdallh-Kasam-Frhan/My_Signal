import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mysignal/providers/app_provider.dart';
import 'package:mysignal/models/signal.dart';
import 'package:mysignal/screens/signal/detils_signal.dart';
import 'package:mysignal/widgets/common/custom_app_bar.dart';
import 'package:mysignal/core/theme/colors.dart';
import 'package:mysignal/widgets/common/sub_category_card.dart';

class SignalScreen extends StatelessWidget {
  const SignalScreen({super.key, required this.categoryId});

  final int categoryId;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, child) {
        final categoryIndex =
            provider.categories.indexWhere((c) => c.id == categoryId);
        if (categoryIndex == -1) {
          return const Scaffold(
            body: Center(
              child: Text('القسم غير موجود'),
            ),
          );
        }

        final category = provider.categories[categoryIndex];
        final List<Signal> filteredSignals = category.signals;

        return Scaffold(
          appBar: CustomAppBar(
            title: category.title,
            backgroundColor: AppColors.surface,
            titleColor: AppColors.textPrimary,
            automaticallyImplyLeading: true,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  category.icon,
                  color: category.color,
                  size: 30,
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
          body: ListView.builder(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 20,
            ),
            itemCount: filteredSignals.length,
            itemBuilder: (context, index) {
              final item = filteredSignals[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 2,
                ),
                child: SubCategoryCard(
                  id: item.id,
                  title: item.title,
                  urlImage: item.urlImageMean,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailsSignalScreen(
                          signal: item,
                          category: category,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mysignal/providers/app_provider.dart';
import 'package:mysignal/core/theme/colors.dart';

class SubCategoryCard extends StatelessWidget {
  final int id;
  final String title;
  final String? urlImage;
  final VoidCallback onTap;
  final String? subTitle;

  const SubCategoryCard({
    super.key,
    required this.id,
    required this.title,
    this.urlImage,
    this.subTitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, child) {
        final isFavorite = provider.isFavorite(id);
        return Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(30),
              ),
                    child: InkWell(
                      onTap: onTap,
                      borderRadius: BorderRadius.circular(12),
                      child: Row(
                        children: [
                          // Leading icon or image
                          Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: urlImage != null
                                ? ClipOval(
                                    child: urlImage!.startsWith('http')
                                        ? Image.network(
                                            urlImage!,
                                            width: 60,
                                            height: 60,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) => const Icon(
                                              Icons.image_not_supported,
                                              size: 24,
                                            ),
                                          )
                                        : Image.asset(
                                            urlImage!,
                                            width: 60,
                                            height: 60,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) => const Icon(
                                              Icons.image_not_supported,
                                              size: 24,
                                            ),
                                          ),
                                  )
                                : const Icon(
                                    Icons.category,
                                    size: 24,
                                  ),
                          ),
                          const SizedBox(width: 16),

                          // Title and optional subtitle
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                ),
                                if (subTitle != null) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    subTitle!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            fontSize: 13,
                                            color: AppColors.textSecondary),
                                  ),
                                ]
                              ],
                            ),
                          ),

                          // Favorite button
                          IconButton(
                            onPressed: () {
                              provider.toggleFavorite(id);
                            },
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  );
                  }
        );
  }
}

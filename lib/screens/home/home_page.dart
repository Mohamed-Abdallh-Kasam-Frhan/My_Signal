import 'package:flutter/material.dart';
import 'package:mysignal/screens/category/category.dart';

import 'package:mysignal/screens/favorites/favorites.dart';
import 'package:mysignal/widgets/common/custom_bottom_navigation.dart';
import 'package:mysignal/core/theme/colors.dart';
import 'package:mysignal/widgets/common/custom_app_bar.dart';

import 'package:mysignal/screens/admin/admin_dashboard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  static const List<String> pagesNames = [
    "التصنيفات",
    "المفضلات",
  ];

  static const List<Widget> pages = [
    CategoryPage(),
    FavoritesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: CustomAppBar(
        title: pagesNames[currentIndex],
        backgroundColor: AppColors.surface,
        titleColor: AppColors.textPrimary,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.admin_panel_settings_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AdminDashboardScreen(),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: pages[currentIndex],
      bottomNavigationBar: CustomBottomNavigation(
        selectElemnt: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mysignal/core/theme/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final Color? backgroundColor;
  final Color? titleColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color bg = backgroundColor ?? AppColors.primary;
    final Color leadingIconColor = titleColor ??
        (bg.computeLuminance() > 0.5 ? Colors.black : Colors.white);

    return AppBar(
      backgroundColor: bg,
      iconTheme: IconThemeData(color: leadingIconColor),
      actionsIconTheme: IconThemeData(color: leadingIconColor),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: titleColor ?? AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
      ),
      centerTitle: true,
      elevation: 2,
      actions: actions,
      automaticallyImplyLeading: automaticallyImplyLeading,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

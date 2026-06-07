import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mysignal/providers/app_provider.dart';
import 'package:mysignal/core/theme/colors.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen>
    with SingleTickerProviderStateMixin {
  final _categoryFormKey = GlobalKey<FormState>();
  final _categoryNameController = TextEditingController();

  final _signalFormKey = GlobalKey<FormState>();
  final _signalNameController = TextEditingController();
  final _signalImageUrlController = TextEditingController();
  final _signalMeanUrlController = TextEditingController();
  final _signalDescController = TextEditingController();

  IconData selectedIcon = Icons.directions_run;
  Color selectedColor = const Color(0xFFB0E0E6);

  int? selectedCategoryId;

  late TabController _tabController;

  final List<IconData> predefinedIcons = [
    Icons.directions_run,
    Icons.fastfood,
    Icons.family_restroom,
    Icons.emoji_emotions,
    Icons.sports_soccer,
    Icons.format_list_numbered,
    Icons.pets,
    Icons.school,
    Icons.work,
    Icons.home,
    Icons.medical_services,
    Icons.shopping_cart,
  ];

  final List<Color> predefinedColors = [
    const Color(0xFFB0E0E6),
    const Color(0xFFFFE8A3),
    const Color(0xFFB7E4C7),
    const Color(0xFFFFB6C1),
    const Color(0xFFFFB86B),
    const Color(0xFFD8B4FE),
    const Color(0xFFD7C4A5),
    const Color(0xFF3498DB),
    const Color(0xFFE74C3C),
    const Color(0xFF2ECC71),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _categoryNameController.dispose();
    _signalNameController.dispose();
    _signalImageUrlController.dispose();
    _signalMeanUrlController.dispose();
    _signalDescController.dispose();
    super.dispose();
  }

  void _saveCategory() async {
    if (_categoryFormKey.currentState!.validate()) {
      final name = _categoryNameController.text.trim();
      final provider = context.read<AppProvider>();

      try {
        await provider.addCategory(name, selectedIcon, selectedColor);
        _categoryNameController.clear();
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('تم إضافة القسم بنجاح!'),
            backgroundColor: Colors.green.shade700,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطأ: $e'),
            backgroundColor: Colors.red.shade700,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    }
  }

  void _saveSignal() async {
    if (_signalFormKey.currentState!.validate()) {
      if (selectedCategoryId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('الرجاء اختيار القسم أولاً'),
            backgroundColor: Colors.orange.shade700,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
        return;
      }

      final provider = context.read<AppProvider>();

      try {
        await provider.addSignal(
          categoryId: selectedCategoryId!,
          title: _signalNameController.text.trim(),
          urlImage: _signalImageUrlController.text.trim(),
          urlImageMean: _signalMeanUrlController.text.trim(),
          description: _signalDescController.text.trim(),
        );

        _signalNameController.clear();
        _signalImageUrlController.clear();
        _signalMeanUrlController.clear();
        _signalDescController.clear();
        setState(() => selectedCategoryId = null);

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('تم إضافة الإشارة بنجاح!'),
            backgroundColor: Colors.green.shade700,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطأ: $e'),
            backgroundColor: Colors.red.shade700,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          title: const Text(
            'لوحة تحكم المسؤول',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              letterSpacing: 0.5,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: AppColors.primary,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: AppColors.primary,
                unselectedLabelColor: Colors.grey.shade600,
                indicatorColor: AppColors.primary,
                indicatorWeight: 3,
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                tabs: const [
                  Tab(icon: Icon(Icons.category), text: 'قسم جديد'),
                  Tab(
                      icon: Icon(Icons.add_to_home_screen),
                      text: 'إشارة جديدة'),
                ],
              ),
            ),
          ),
        ),
        body: Consumer<AppProvider>(
          builder: (context, provider, child) {
            final categoriesList = provider.categories;

            return TabBarView(
              controller: _tabController,
              children: [
                // --- TAB 1: ADD CATEGORY (ELEGANT CARD) ---
                SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Card(
                    elevation: 2,
                    shadowColor: Colors.grey.shade100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Form(
                        key: _categoryFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.category_outlined,
                                    color: AppColors.primary, size: 28),
                                const SizedBox(width: 12),
                                const Text(
                                  'إنشاء قسم رئيسي جديد',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            TextFormField(
                              controller: _categoryNameController,
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                labelText: 'اسم القسم',
                                hintText: 'مثال: إشارات المرور',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade200),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                      color: AppColors.primary, width: 2),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 16),
                                prefixIcon:
                                    Icon(Icons.title, color: AppColors.primary),
                              ),
                              validator: (val) =>
                                  val == null || val.trim().isEmpty
                                      ? 'يرجى إدخال اسم القسم'
                                      : null,
                            ),
                            const SizedBox(height: 28),
                            const Text(
                              'اختر أيقونة القسم:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 16),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 6,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                              ),
                              itemCount: predefinedIcons.length,
                              itemBuilder: (context, index) {
                                final icon = predefinedIcons[index];
                                final isSelected = selectedIcon == icon;
                                return Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () =>
                                        setState(() => selectedIcon = icon),
                                    borderRadius: BorderRadius.circular(16),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? AppColors.primary
                                                .withValues(alpha: 0.1)
                                            : Colors.grey.shade50,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: isSelected
                                              ? AppColors.primary
                                              : Colors.grey.shade300,
                                          width: isSelected ? 2 : 1,
                                        ),
                                      ),
                                      child: Icon(icon,
                                          color: isSelected
                                              ? AppColors.primary
                                              : Colors.grey.shade700,
                                          size: 30),
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 28),
                            const Text(
                              'اختر لون القسم:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              height: 70,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: predefinedColors.length,
                                itemBuilder: (context, index) {
                                  final color = predefinedColors[index];
                                  final isSelected = selectedColor.toARGB32() ==
                                      color.toARGB32();
                                  return GestureDetector(
                                    onTap: () =>
                                        setState(() => selectedColor = color),
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      width: 54,
                                      height: 54,
                                      decoration: BoxDecoration(
                                        color: color,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black
                                                .withValues(alpha: 0.08),
                                            blurRadius: 6,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: isSelected
                                          ? Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 3),
                                              ),
                                              child: const Icon(Icons.check,
                                                  color: Colors.white,
                                                  size: 28),
                                            )
                                          : null,
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 36),
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                onPressed: _saveCategory,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                  elevation: 2,
                                  shadowColor:
                                      AppColors.primary.withValues(alpha: 0.4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                child: const Text('حفظ القسم الجديد'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // --- TAB 2: ADD SIGNAL (ELEGANT CARD) ---
                SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Card(
                    elevation: 2,
                    shadowColor: Colors.grey.shade100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Form(
                        key: _signalFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.add_circle_outline,
                                    color: AppColors.primary, size: 28),
                                const SizedBox(width: 12),
                                const Text(
                                  'إضافة إشارة جديدة للقسم',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            DropdownButtonFormField<int>(
                              value: selectedCategoryId,
                              decoration: InputDecoration(
                                labelText: 'اختر القسم التابع له الإشارة',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade200),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                      color: AppColors.primary, width: 2),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 16),
                                prefixIcon: Icon(Icons.category_outlined,
                                    color: AppColors.primary),
                              ),
                              items: categoriesList.map((cat) {
                                return DropdownMenuItem<int>(
                                  value: cat.id,
                                  child: Text(
                                    cat.title,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                );
                              }).toList(),
                              onChanged: (val) =>
                                  setState(() => selectedCategoryId = val),
                              validator: (val) =>
                                  val == null ? 'الرجاء اختيار القسم' : null,
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _signalNameController,
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                labelText: 'اسم الإشارة',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade200),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                      color: AppColors.primary, width: 2),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 16),
                                prefixIcon: Icon(Icons.text_fields,
                                    color: AppColors.primary),
                              ),
                              validator: (val) =>
                                  val == null || val.trim().isEmpty
                                      ? 'يرجى إدخال اسم الإشارة'
                                      : null,
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _signalImageUrlController,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                labelText: 'رابط صورة الإشارة (من الإنترنت)',
                                helperText:
                                    'مثال: https://example.com/image.jpg',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade200),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                      color: AppColors.primary, width: 2),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 16),
                                prefixIcon:
                                    Icon(Icons.image, color: AppColors.primary),
                              ),
                              validator: (val) {
                                if (val == null || val.trim().isEmpty)
                                  return 'يرجى إدخال رابط الصورة';
                                if (!val.startsWith('http'))
                                  return 'الرابط يجب أن يبدأ بـ http';
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _signalMeanUrlController,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                labelText:
                                    'رابط صورة المعنى التوضيحي (من الإنترنت)',
                                helperText:
                                    'مثال: https://example.com/mean.jpg',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade200),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                      color: AppColors.primary, width: 2),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 16),
                                prefixIcon: Icon(Icons.help_center_outlined,
                                    color: AppColors.primary),
                              ),
                              validator: (val) {
                                if (val == null || val.trim().isEmpty)
                                  return 'يرجى إدخال رابط صورة التوضيح';
                                if (!val.startsWith('http'))
                                  return 'الرابط يجب أن يبدأ بـ http';
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _signalDescController,
                              textAlign: TextAlign.right,
                              maxLines: 3,
                              decoration: InputDecoration(
                                labelText: 'الوصف / معلومات عن الإشارة',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade200),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                      color: AppColors.primary, width: 2),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 16),
                                prefixIcon: Icon(Icons.description,
                                    color: AppColors.primary),
                              ),
                              validator: (val) =>
                                  val == null || val.trim().isEmpty
                                      ? 'يرجى إدخال الوصف'
                                      : null,
                            ),
                            const SizedBox(height: 36),
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                onPressed: _saveSignal,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                  elevation: 2,
                                  shadowColor:
                                      AppColors.primary.withValues(alpha: 0.4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                child: const Text('حفظ الإشارة الجديدة'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

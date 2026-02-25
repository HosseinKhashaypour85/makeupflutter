import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makeupflutter/config/app_config/app_font_styles/app_font_styles.dart';
import 'package:makeupflutter/features/category_features/services/category_api_repository.dart';
import 'package:makeupflutter/features/public_features/widget/snack_bar.dart';

import '../model/popular_category_model.dart';
import 'category_card.dart';

class ShowPopCategories extends StatefulWidget {
  const ShowPopCategories({super.key});

  @override
  State<ShowPopCategories> createState() => _ShowPopCategoriesState();
}

class _ShowPopCategoriesState extends State<ShowPopCategories> {
  final CategoryApiRepository _categoryApiRepository = CategoryApiRepository();
  late Future<List<PopularCategoryModel>> _future;

  @override
  void initState() {
    super.initState();
    _future = _categoryApiRepository.callCategoriesApi();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PopularCategoryModel>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'خطا در دریافت لیست دسته بندی های محبوب',
              style: AppFontStyles().secondFontStyle(12.sp, Colors.red),
            ),
          );
        }

        final data = snapshot.data ?? [];

        if (data.isEmpty) {
          return Center(
            child: Text(
              'دسته بندی یافت نشد',
              style: TextStyle(fontSize: 12.sp, color: Colors.red),
            ),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.only(bottom: 16.h),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (_, __) => SizedBox(height: 16.h),
          itemCount: (data.length / 2).ceil(),
          itemBuilder: (context, index) {
            final firstItemIndex = index * 2;
            final secondItemIndex = index * 2 + 1;

            return Row(
              children: [
                Expanded(
                  child: buildPopCategoryCard(data[firstItemIndex], context),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: secondItemIndex < data.length
                      ? buildPopCategoryCard(data[secondItemIndex], context)
                      : const SizedBox(),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

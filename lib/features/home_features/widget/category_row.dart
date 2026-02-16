import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makeupflutter/features/category_features/screen/category_screen.dart';
import 'package:makeupflutter/features/home_features/widget/shimmer_loading.dart';

import '../../../config/app_config/app_color/colors.dart';
import '../../../config/app_config/app_font_styles/app_font_styles.dart';
import '../../../config/app_config/app_shapes/media_query.dart';
import '../../../config/app_config/app_urls/app_assets_url.dart';
import '../model/category_model.dart';
import '../services/home_api_repository.dart';

class ShowCategoriesRow extends StatefulWidget {
  const ShowCategoriesRow({super.key});

  @override
  State<ShowCategoriesRow> createState() => _ShowCategoriesRowState();
}

class _ShowCategoriesRowState extends State<ShowCategoriesRow> {
  final HomeApiRepository _repo = HomeApiRepository();
  late Future<CategoryModel> _futureCategories;

  @override
  void initState() {
    super.initState();
    _futureCategories = _repo.callCategoriesRowApi();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getHeight(context, 0.1.sp),
      child: FutureBuilder<CategoryModel>(
        future: _futureCategories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CategoriesShimmer();
          }

          if (snapshot.hasError) {
            return const Center(child: Text("خطا در دریافت دسته‌بندی‌ها"));
          }

          final data = snapshot.data;
          final categories = data?.categories ?? [];

          if (categories.isEmpty) {
            return const Center(child: Text("دسته‌بندی‌ای یافت نشد"));
          }

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            itemBuilder: (context, index) {
              final item = categories[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (index == 0) {
                        Navigator.pushNamed(
                          context,
                          CategoryScreen.screenId,
                          arguments: 'skin',
                        );
                      }
                      if (index == 1) {
                        Navigator.pushNamed(
                          context,
                          CategoryScreen.screenId,
                          arguments: 'lip',
                        );
                      }
                      if (index == 2) {
                        Navigator.pushNamed(
                          context,
                          CategoryScreen.screenId,
                          arguments: 'eye',
                        );
                      }
                      if (index == 3) {
                        Navigator.pushNamed(
                          context,
                          CategoryScreen.screenId,
                          arguments: 'perfume',
                        );
                      }
                    },
                    child: Container(
                      width: getWidth(context, 0.2.sp),
                      height: getHeight(context, 0.06.sp),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryColor.withOpacity(0.1),
                        border: Border.all(
                          color: primaryColor.withOpacity(0.4),
                        ),
                      ),
                      child: Image.asset(
                        _getCategoryIcon(item.categoryName),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  SizedBox(height: 8.h),
                  SizedBox(
                    width: 70.w,
                    child: Text(
                      item.categoryName ?? '',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppFontStyles().secondFontStyle(
                        12.sp,
                        Colors.black,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

String _getCategoryIcon(String? categoryName) {
  switch (categoryName) {
    case 'پوست':
      return AppAssetsUrl.skinIconUrl;
    case 'لب':
      return AppAssetsUrl.lipIconUrl;
    case 'چشم':
      return AppAssetsUrl.eyeIconUrl;
    case 'عطر':
      return AppAssetsUrl.skinIconUrl;
    default:
      return AppAssetsUrl.logoUrl;
  }
}

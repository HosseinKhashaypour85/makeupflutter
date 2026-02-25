import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makeupflutter/features/category_features/logic/category_bloc.dart';
import 'package:makeupflutter/features/category_features/services/category_api_repository.dart';

import '../../../config/app_config/app_color/colors.dart';
import '../../../config/app_config/app_font_styles/app_font_styles.dart';
import '../../home_features/widget/app_bar_widget.dart';
import '../widget/collection_widget.dart';
import '../widget/pop_category_widget.dart';
import '../widget/search_bar_widget.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});
  static const String screenId = 'category';

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryBloc(CategoryApiRepository())
        ..add(CallCategoryEvent()), 
      child: Scaffold(
        appBar: customAppBar(),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SearchBarWidget(),
                ),
                CollectionWidget(),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      const Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Text(
                          'دسته بندی های محبوب',
                          style: AppFontStyles().secondFontStyle(14.sp, primaryColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                 Padding(
                   padding: EdgeInsets.symmetric(horizontal: 16),
                   child: ShowPopCategories(),
                 ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
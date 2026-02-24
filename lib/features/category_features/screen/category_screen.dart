import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makeupflutter/config/app_config/app_color/colors.dart';
import 'package:makeupflutter/config/app_config/app_urls/app_assets_url.dart';
import 'package:makeupflutter/features/category_features/logic/category_bloc.dart';
import 'package:makeupflutter/features/category_features/services/category_api_repository.dart';
import 'package:makeupflutter/features/category_features/widget/collection_widget.dart';
import 'package:makeupflutter/features/home_features/widget/app_bar_widget.dart';

import '../../../config/app_config/app_button/app_glass_button.dart';
import '../../../config/app_config/app_font_styles/app_font_styles.dart';
import '../../../config/app_config/app_shapes/border_radius.dart';
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
      create: (context) => CategoryBloc(CategoryApiRepository()),
      child: Scaffold(
        appBar: customAppBar(),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: SearchBarWidget(),
              ),
              CollectionWidget(),
              SizedBox(height: 10.sp),
              Row(
                children: [
                  Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                  Text(
                    'دسته بندی ها محبوب',
                    style: AppFontStyles().secondFontStyle(14.sp, primaryColor),
                    textAlign: TextAlign.center,
                  ),
                  Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makeupflutter/config/app_config/app_color/colors.dart';
import 'package:makeupflutter/config/app_config/app_font_styles/app_font_styles.dart';
import 'package:makeupflutter/config/app_config/app_shapes/border_radius.dart';
import 'package:makeupflutter/config/app_config/app_shapes/media_query.dart';
import 'package:makeupflutter/config/app_config/app_urls/app_assets_url.dart';
import 'package:makeupflutter/features/home_features/model/category_model.dart';
import 'package:makeupflutter/features/home_features/services/home_api_repository.dart';
import 'package:makeupflutter/features/home_features/widget/app_bar_widget.dart';
import 'package:makeupflutter/features/home_features/widget/hero_section_banner_shimmer.dart';
import 'package:makeupflutter/features/home_features/widget/popular_products_row_widget.dart';

import '../widget/category_row.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String screenId = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final double bannerHeight = getHeight(context, 0.4);

    return Scaffold(
      appBar: customAppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: Stack(
                children: [
                  SizedBox(
                    width: getAllWidth(context),
                    height: bannerHeight,
                    child: Image.network(
                      AppAssetsUrl.modelPortraitUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return const BannerShimmer();
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          AppAssetsUrl.logoUrl,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: getAllWidth(context),
                    height: bannerHeight,
                    child: const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black45,
                            Colors.black87,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 15.w,
                    bottom: 20.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'زیبایی اصیل و بدون مرز',
                          style: AppFontStyles().firstFontStyle(
                            18.sp,
                            Colors.white,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          'با رزا بیوتی به بهترین کالکشن ها دسترسی داشته باش',
                          style: AppFontStyles().firstFontStyle(
                            16.sp,
                            buttonBgColor,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary2Color,
                            shape: RoundedRectangleBorder(
                              borderRadius: getBorderRadiusFunc(7.sp),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 10.h,
                            ),
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'مشاهده محصولات',
                                style: AppFontStyles().firstFontStyle(
                                  15.sp,
                                  Colors.white,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // بخش دسته‌بندی‌ها
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'دسته بندی ها',
                        style: AppFontStyles().secondFontStyle(
                          18.sp,
                          primaryColor,
                        ),
                      ),
                      const Spacer(),
                      // TextButton(
                      //   onPressed: () {},
                      //   child: Text(
                      //     'مشاهده همه',
                      //     style: AppFontStyles().firstFontStyle(
                      //       14.sp,
                      //       primary2Color,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  const ShowCategoriesRow(),
                ],
              ),
            ),

            // بخش محصولات پرطرفدار
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'پرطرفدارترین ها',
                        style: AppFontStyles().secondFontStyle(
                          18.sp,
                          primaryColor,
                        ),
                      ),
                      const Spacer(),
                      // TextButton(
                      //   onPressed: () {},
                      //   child: Text(
                      //     'مشاهده همه',
                      //     style: AppFontStyles().firstFontStyle(
                      //       14.sp,
                      //       primary2Color,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  const PopularProductsRowWidget(),
                ],
              ),
            ),

            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
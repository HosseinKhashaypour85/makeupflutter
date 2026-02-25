import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makeupflutter/config/app_config/app_color/colors.dart';
import 'package:makeupflutter/config/app_config/app_font_styles/app_font_styles.dart';
import 'package:makeupflutter/config/app_config/app_shapes/media_query.dart';

Widget buildPopCategoryCard(dynamic category , BuildContext context) {
  final String image = (category is Map)
      ? (category['image'] ?? '')
      : (category.image ?? '');

  final String name = (category is Map)
      ? (category['name'] ?? '')
      : (category.name ?? '');

  final int productsCount = (category is Map)
      ? (category['productsCount'] ?? 0)
      : (category.productsCount ?? 0);

  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.r),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Padding(
      padding: EdgeInsets.all(12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: image.isNotEmpty
                ? Image.network(
              image,
              height: 170.h,
              width: getAllWidth(context),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return _imageFallback();
              },
            )
                : _imageFallback(),
          ),
          SizedBox(height: 8.h),
          Text(
            name,
            style: AppFontStyles().secondFontStyle(15.sp, primaryColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Icon(Icons.inventory_2_outlined, size: 12.sp, color: Colors.grey),
              SizedBox(width: 4.w),
              Text(
                '$productsCount محصول',
                style: AppFontStyles().secondFontStyle(12.sp, Colors.grey)
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _imageFallback() {
  return Container(
    height: 100.h,
    width: double.infinity,
    color: Colors.grey[300],
    child: Center(
      child: Icon(
        Icons.image_not_supported,
        size: 30.sp,
        color: Colors.grey[600],
      ),
    ),
  );
}
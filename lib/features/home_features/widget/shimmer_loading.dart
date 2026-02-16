import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CategoriesShimmer extends StatelessWidget {
  const CategoriesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    const int itemCount = 4;
    final double itemWidth = 60.w;
    final double itemSpacing = 16.w;
    final double textWidth = 45.w;

    final double totalWidth =
        (itemCount * itemWidth) +
            ((itemCount - 1) * itemSpacing);

    final double screenWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding =
        (screenWidth - totalWidth) / 2;

    return SizedBox(
      height: 115.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding > 0 ? horizontalPadding : 16.w,
        ),
        itemCount: itemCount,
        separatorBuilder: (_, __) => SizedBox(width: itemSpacing),
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: itemWidth,
                  height: itemWidth,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: textWidth,
                  height: 10.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

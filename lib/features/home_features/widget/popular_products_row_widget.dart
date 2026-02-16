import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makeupflutter/config/app_config/app_color/colors.dart';
import 'package:makeupflutter/config/app_config/app_font_styles/app_font_styles.dart';
import 'package:makeupflutter/config/app_config/app_shapes/media_query.dart';
import 'package:makeupflutter/features/home_features/model/popular_products_model.dart';
import 'package:makeupflutter/features/home_features/services/home_api_repository.dart';
import 'package:makeupflutter/features/home_features/widget/popular_products_loading.dart';
import 'package:makeupflutter/features/public_features/widget/snack_bar.dart';

import '../../public_features/functions/number_to_three.dart';

class PopularProductsRowWidget extends StatefulWidget {
  const PopularProductsRowWidget({super.key});

  @override
  State<PopularProductsRowWidget> createState() =>
      _PopularProductsRowWidgetState();
}

class _PopularProductsRowWidgetState extends State<PopularProductsRowWidget> {
  final HomeApiRepository _repository = HomeApiRepository();
  late Future<PopularProductsModel> _futurePopularProducts;

  @override
  void initState() {
    super.initState();
    _futurePopularProducts = _repository.callPopularProductsApi();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getHeight(context, 0.33),
      width: double.infinity,
      child: FutureBuilder<PopularProductsModel>(
        future: _futurePopularProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: PopularProductsShimmer());
          }

          if (snapshot.hasError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              getSnackBarWidget(
                context,
                'خطا در دریافت محصولات پرطرفدار',
                Colors.red,
              );
            });
            return const Center(child: Text('خطا در بارگذاری'));
          }

          final popularProducts = snapshot.data?.products ?? [];
          if (popularProducts.isEmpty) {
            return const Center(child: Text('محصولی یافت نشد'));
          }

          return ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            itemCount: popularProducts.length,
            separatorBuilder: (_, __) => SizedBox(width: 12.w),
            itemBuilder: (context, index) {
              final item = popularProducts[index];
              return PopularProductCard(item: item);
            },
          );
        },
      ),
    );
  }
}

class PopularProductCard extends StatelessWidget {
  final Product item;

  const PopularProductCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: () {
        // TODO: برو صفحه جزئیات
        // Navigator.pushNamed(context, ProductDetails.screenId, arguments: item.sId);
      },
      child: Container(
        width: getWidth(context, 0.4.sp),
        height: getHeight(context, 0.4.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 12,
              spreadRadius: 0,
              offset: const Offset(0, 6),
              color: Colors.black.withOpacity(0.06),
            ),
          ],
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              child: AspectRatio(
                aspectRatio: 1.2,
                child: Image.network(
                  item.image ?? '',
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return PopularProductsShimmer();
                  },
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      item.name ?? 'نام نامعلوم',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppFontStyles().firstFontStyle(15.sp, primary2Color),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            formatPrice(item.price),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppFontStyles().secondFontStyle(
                              14.sp,
                              primary2Color,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 6.w),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

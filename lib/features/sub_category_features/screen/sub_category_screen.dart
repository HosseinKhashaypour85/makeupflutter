import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makeupflutter/config/app_config/app_font_styles/app_font_styles.dart';

import '../../home_features/widget/app_bar_widget.dart';
import '../logic/category_bloc.dart';
import '../model/sub_category_model.dart';
import '../services/category_api_repository.dart';

class SubCategoryScreen extends StatefulWidget {
  const SubCategoryScreen({super.key, required this.categoryId});

  static const String screenId = 'subcategory';
  final String categoryId;

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  // رنگ‌های قهوه‌ای
  final Color brownPrimary = const Color(0xFF8B4513); // قهوه‌ای سوخته
  final Color brownLight = const Color(0xFFD2691E); // قهوه‌ای روشن (چوبی)
  final Color brownDark = const Color(0xFF5D3A1A); // قهوه‌ای تیره
  final Color creamColor = const Color(0xFFF5F0E6); // کرم
  final Color beigeColor = const Color(0xFFF8F0E3); // بژ

  @override
  Widget build(BuildContext context) {
    final categoryId = widget.categoryId;

    print('Category ID: $categoryId');

    return BlocProvider(
      create: (context) =>
          CategoryBloc(CategoryApiRepository())
            ..add(CallCategoryProducts(categoryId: categoryId)),
      child: Scaffold(
        backgroundColor: creamColor,
        appBar: customAppBar(), // اپ‌بار فعلی شما
        body: SafeArea(
          child: Column(
            children: [
              // _buildCategoryHeader(),
              Expanded(
                child: ShowCategoryProducts(
                  categoryId: categoryId,
                  brownPrimary: brownPrimary,
                  brownLight: brownLight,
                  brownDark: brownDark,
                  creamColor: creamColor,
                  beigeColor: beigeColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== ویجت نمایش محصولات ====================
class ShowCategoryProducts extends StatefulWidget {
  const ShowCategoryProducts({
    super.key,
    required this.categoryId,
    required this.brownPrimary,
    required this.brownLight,
    required this.brownDark,
    required this.creamColor,
    required this.beigeColor,
  });

  final String categoryId;
  final Color brownPrimary;
  final Color brownLight;
  final Color brownDark;
  final Color creamColor;
  final Color beigeColor;

  @override
  State<ShowCategoryProducts> createState() => _ShowCategoryProductsState();
}

class _ShowCategoryProductsState extends State<ShowCategoryProducts> {
  final CategoryApiRepository _repository = CategoryApiRepository();
  late Future<SubCategoryModel> _future;

  @override
  void initState() {
    super.initState();
    _future = _repository.callCategoryApiServices(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [widget.creamColor, widget.beigeColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: FutureBuilder<SubCategoryModel>(
        future: _future,
        builder: (context, snapshot) {
          // حالت در حال بارگذاری
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      widget.brownPrimary,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'در حال بارگذاری...',
                    style: TextStyle(
                      color: widget.brownPrimary,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
            );
          }

          // حالت خطا
          if (snapshot.hasError) {
            return _buildErrorWidget();
          }

          // دریافت داده‌ها
          final data = snapshot.data;
          final products = data?.products ?? [];
          final categoryName = data?.category;

          // حالت خالی بودن لیست
          if (products.isEmpty) {
            return _buildEmptyWidget();
          }

          // نمایش لیست محصولات
          return Column(
            children: [
              if (categoryName != null && categoryName.isNotEmpty)
                _buildCategoryNameWidget(categoryName),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(12.w),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return _buildProductCard(product);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ویجت خطا
  Widget _buildErrorWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 60.sp,
              color: widget.brownPrimary.withOpacity(0.7),
            ),
            SizedBox(height: 16.h),
            Text(
              'خطا در بارگذاری محصولات',
              style: TextStyle(fontSize: 16.sp, color: widget.brownDark),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _future = _repository.callCategoryApiServices(
                    widget.categoryId,
                  );
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.brownPrimary,
                foregroundColor: widget.creamColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              ),
              child: Text('تلاش مجدد', style: TextStyle(fontSize: 16.sp)),
            ),
          ],
        ),
      ),
    );
  }

  // ویجت خالی
  Widget _buildEmptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 80.sp,
            color: widget.brownLight.withOpacity(0.5),
          ),
          SizedBox(height: 16.h),
          Text(
            'هیچ محصولی در این دسته‌بندی یافت نشد',
            style: TextStyle(
              fontSize: 18.sp,
              color: widget.brownDark,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ویجت نام دسته‌بندی
  Widget _buildCategoryNameWidget(String categoryName) {
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: widget.brownLight.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: widget.brownLight.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.category, size: 16.sp, color: widget.brownPrimary),
              SizedBox(width: 8.w),
              Text(
                'دسته‌بندی: $categoryName',
                style: AppFontStyles().secondFontStyle(13.sp, Colors.brown)
              ),
            ],
          ),
        ),
      ),
    );
  }

  // کارت محصول
  Widget _buildProductCard(Products product) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: widget.brownDark.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: () => _navigateToProductDetail(product),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProductImage(product),
                _buildProductInfo(product),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // تصویر محصول
  Widget _buildProductImage(Products product) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Image.network(
        product.image ?? 'https://via.placeholder.com/400x200',
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: widget.beigeColor,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(widget.brownLight),
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: widget.beigeColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.broken_image,
                  size: 50.sp,
                  color: widget.brownLight.withOpacity(0.5),
                ),
                SizedBox(height: 8.h),
                Text(
                  'تصویر موجود نیست',
                  style: TextStyle(color: widget.brownLight, fontSize: 12.sp),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // اطلاعات محصول
  Widget _buildProductInfo(Products product) {
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // نام محصول
          Text(
            product.name ?? 'نامشخص',
            style: AppFontStyles().secondFontStyle(14.sp, Colors.brown),
          ),
          SizedBox(height: 4.h),

          // برند
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: widget.brownLight.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              product.brand ?? 'برند نامشخص',
              style: AppFontStyles().secondFontStyle(10.sp, Colors.brown),
            ),
          ),
          SizedBox(height: 12.h),

          // قیمت و دکمه خرید
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // قیمت
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: widget.brownLight.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: widget.brownLight.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  '${_formatPrice(product.price)}' + 'تومان',
                  style: AppFontStyles().secondFontStyle(16.sp, Colors.brown),
                ),
              ),
              // دکمه خرید
              ElevatedButton(
                onPressed: () => _addToCart(product),
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.brownPrimary,
                  foregroundColor: widget.creamColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),
                  elevation: 3,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.shopping_cart, size: 16.sp),
                    SizedBox(width: 4.w),
                    Text('خرید', style: AppFontStyles().secondFontStyle(12.sp, Colors.white)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  String _formatPrice(int? price) {
    if (price == null) return '0';
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  // رفتن به صفحه جزئیات محصول
  void _navigateToProductDetail(Products product) {
    print('Navigate to product detail: ${product.id}');
    // TODO: پیاده‌سازی ناوبری به صفحه جزئیات
  }

  // اضافه کردن به سبد خرید
  void _addToCart(Products product) {
    print('Add to cart: ${product.id}');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${product.name} به سبد خرید اضافه شد',
          style: TextStyle(color: widget.creamColor),
        ),
        backgroundColor: widget.brownPrimary,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }
}

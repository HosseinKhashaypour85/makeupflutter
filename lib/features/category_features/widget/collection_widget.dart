import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/app_config/app_button/app_glass_button.dart';
import '../../../config/app_config/app_font_styles/app_font_styles.dart';
import '../../../config/app_config/app_shapes/border_radius.dart';
import '../../../config/app_config/app_urls/app_assets_url.dart';

class CollectionWidget extends StatefulWidget {
  const CollectionWidget({super.key});

  @override
  State<CollectionWidget> createState() => _CollectionWidgetState();
}

class _CollectionWidgetState extends State<CollectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.sp),
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: getBorderRadiusFunc(10),
            image: DecorationImage(
              image: AssetImage(AppAssetsUrl.collectionImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: getBorderRadiusFunc(10),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 15.sp),
                        child: Text(
                          'کالکشن جدید',
                          style: AppFontStyles().secondFontStyle(
                            20.sp,
                            Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'زیبایی جاودانه ایرانی',
                    style: AppFontStyles().secondFontStyle(
                      17.sp,
                      Colors.white,
                    ),
                  ),
                  SizedBox(height: 10.sp,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding:EdgeInsets.only(left: 8.sp),
                        child: Text(
                          'هارمونی رنگ های گرم و طبیعی پاییز',
                          style: AppFontStyles().secondFontStyle(
                            16.sp,
                            Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 100.sp,),
                  Padding(
                    padding: EdgeInsets.all(10.sp),
                    child: GlassButton(text: 'مشاهده کالکشن', onTap: (){}),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

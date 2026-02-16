import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/app_config/app_shapes/media_query.dart';

class BannerShimmer extends StatelessWidget {
  const BannerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: double.infinity,
        height: getHeight(context, 0.4),
        color: Colors.white,
      ),
    );
  }
}

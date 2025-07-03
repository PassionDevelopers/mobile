import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/components/loading/skeleton.dart';

class ShortsLoadingView extends StatefulWidget {
  const ShortsLoadingView({super.key});

  @override
  State<ShortsLoadingView> createState() => _ShortsLoadingViewState();
}

class _ShortsLoadingViewState extends State<ShortsLoadingView> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 16.0),
            ContentPlaceholder(
              lineType: ContentLineType.threeLines,
            ),
            SizedBox(height: 16.0),
            BannerPlaceholder(),
            SizedBox(height: 16.0),
          ],
        ));
  }
}


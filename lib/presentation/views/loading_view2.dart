import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'loading_view.dart';

class LoadingView2 extends StatefulWidget {
  const LoadingView2({super.key});

  @override
  State<LoadingView2> createState() => _LoadingView2State();
}

class _LoadingView2State extends State<LoadingView2> {
  String fetchedIssues = '';
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


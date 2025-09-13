import 'package:could_be/core/components/loading/media_profile_skeleton.dart';
import 'package:flutter/material.dart';

class MediaLoadingView extends StatelessWidget {
  const MediaLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return MediaProfileSkeletonVertical(
        );
      },
      itemCount: 10,
    );
  }
}

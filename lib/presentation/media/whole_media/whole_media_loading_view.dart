import 'package:could_be/core/components/loading/media_profile_skeleton.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:flutter/cupertino.dart';

class WholeMediaLoadingView extends StatelessWidget {
  const WholeMediaLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: MyPaddings.largeMedium,
        vertical: MyPaddings.medium,
      ),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.75,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
        delegate: SliverChildBuilderDelegate((context, index){
          return MediaProfileSkeleton(isFirst: false);
        })),
    );
  }
}

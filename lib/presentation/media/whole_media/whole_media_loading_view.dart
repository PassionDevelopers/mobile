import 'package:could_be/core/components/loading/media_profile_skeleton.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:flutter/cupertino.dart';

class WholeMediaLoadingView extends StatelessWidget {
  const WholeMediaLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: MyPaddings.largeMedium,
        vertical: MyPaddings.medium,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.7,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
      ),
      itemCount: 15,
      itemBuilder: (context, index) {
        return MediaProfileSkeleton(isFirst: false);
      },
    );
  }
}

import 'package:could_be/core/components/loading/media_profile_skeleton.dart';
import 'package:could_be/core/components/loading/media_protile_skeleton_horizontal.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:flutter/cupertino.dart';

class WholeMediaLoadingView extends StatelessWidget {
  const WholeMediaLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: 18,
          itemBuilder:   (context, index) {
            return MediaProfileSkeletonHorizontal();
          },
        ),
      ),
    );
  }
}

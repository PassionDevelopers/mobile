import 'package:flutter/material.dart';

import '../../../ui/color.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({super.key, required this.height, required this.imageUrl, this.borderRadius});
  final double? height;
  final String imageUrl;
  final BorderRadius? borderRadius;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.gray4,
        borderRadius: borderRadius ?? BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.vertical(
          top: Radius.circular(16),
        ),
        child: Image.network(
          // loadingBuilder: (_, child, loadingProgress) {
          //   if (loadingProgress == null) return child;
          //   return Center(
          //     child: CircularProgressIndicator(
          //       value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
          //       // value: loadingProgress.expectedTotalBytes != null
          //       //     ? loadingProgress.cumulativeBytesLoaded /
          //       //     (loadingProgress.expectedTotalBytes ?? 1)
          //       //     : null,
          //     ),
          //   );
          // },
          errorBuilder: (_, error, stackTrace) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Icon(Icons.image_not_supported, color: AppColors.gray2, size: 48),
              ),
            );
          },
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

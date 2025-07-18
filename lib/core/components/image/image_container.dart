import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';

import '../../../ui/color.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({super.key, required this.height, required this.imageUrl, this.borderRadius, this.imageSource});
  final double? height;
  final String? imageUrl;
  final String? imageSource;
  final BorderRadius? borderRadius;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Ink(
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
            child: imageUrl == null? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Icon(Icons.image_not_supported, color: AppColors.gray2, size: 48),
              ),
            ) :

              Image.network(
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
              imageUrl!,
              fit: BoxFit.cover,
            ),
          ),
        ),
        // if(imageSource != null) Container(
        //   padding: EdgeInsets.only(bottom: 5, right: 5),
        //   height: height,
        //   child: Align(alignment: Alignment.bottomRight,
        //       child: MyText.reg('*이미지 출처 : $imageSource', color: AppColors.white)),
        // ),
      ],
    );
  }
}

import 'package:could_be/core/components/image/image_container.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:could_be/domain/entities/source/source.dart';
import 'package:could_be/presentation/source/components/source_bias_tag.dart';
import 'package:flutter/material.dart';

class SourceProfileHorizontal extends StatelessWidget {
  const SourceProfileHorizontal({
    super.key,
    required this.source,
    required this.isSelected,
    required this.onSelect,
  });

  final bool isSelected;
  final VoidCallback onSelect;
  final Source source;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onSelect,
      child: Ink(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: isSelected? getBiasBackgroundColor(source.bias) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected? getBiasColor(source.bias) : AppColors.gray300
          )
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 10,
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: ImageContainer(
                        height: 40,
                        imageUrl: source.logoUrl,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    MyText.reg(source.name),
                    Expanded(child: SourceBiasTag(bias: source.bias))
                  ],
                ),
              ],
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isSelected ? getBiasColor(source.bias) : AppColors.gray300,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isSelected ? Icons.check : Icons.add,
                size: 16,
                color: AppColors.white
              )
            ),
          ],
        ),
      ),
    );
  }
}

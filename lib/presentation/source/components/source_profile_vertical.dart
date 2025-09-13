import 'package:could_be/core/components/image/image_container.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:could_be/domain/entities/source/source.dart';
import 'package:could_be/presentation/source/components/source_bias_tag.dart';
import 'package:flutter/material.dart';

class SourceProfileVertical extends StatelessWidget {
  const SourceProfileVertical({super.key,
    required this.source,
    required this.isSelected,
    required this.onSelect
  });

  final bool isSelected;
  final VoidCallback onSelect;
  final Source source;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onSelect,
        child: Ink(
          width: 80,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            color: isSelected ? getBiasBackgroundColor(source.bias) : AppColors.white,
            border: Border.all(color: isSelected? getBiasColor(source.bias) : AppColors.gray300)
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 4,
                children: [
                  MyText.reg(
                      source.name,
                      color: isSelected ? AppColors.black : AppColors.gray400
                  ),
                  SourceBiasTag(bias: source.bias)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

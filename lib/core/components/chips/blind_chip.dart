import 'package:could_be/domain/entities/issue_tag.dart';
import 'package:flutter/cupertino.dart';
import '../../../ui/color.dart';
import '../../many_use.dart';

class BlindChip extends StatelessWidget {
  const BlindChip({super.key, required this.tag});
  final IssueTag tag;

  @override
  Widget build(BuildContext context) {
    Color primary = tag.color;
    // Color secondary = primary.withAlpha(80);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primary),
      ),
      child: autoSizeText(tag.name,
        color: AppColors.primaryLight,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

// blind spot, 의견 대립,
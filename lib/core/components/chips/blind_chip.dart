import 'package:flutter/cupertino.dart';

import '../../../ui/color.dart';
import '../../many_use.dart';

class BlindChip extends StatelessWidget {
  const BlindChip({super.key, required this.isRightBlind});
  final bool isRightBlind;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isRightBlind? AppColors.rightCenter : AppColors.leftCenter,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isRightBlind? AppColors.right : AppColors.left,),
      ),
      child: autoSizeText(
        isRightBlind ? '보수 사각지대' : '진보 사각지대',
        color: isRightBlind? AppColors.right : AppColors.left,
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
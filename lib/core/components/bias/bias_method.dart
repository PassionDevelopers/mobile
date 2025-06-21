import 'dart:ui';

import '../../../ui/color.dart';
import 'bias_enum.dart';

 Color getBiasColor(Bias bias){
  switch (bias) {
    case Bias.left:
      return AppColors.left;
    case Bias.leftCenter:
      return AppColors.leftCenter;
    case Bias.right:
      return AppColors.right;
    case Bias.rightCenter:
      return AppColors.rightCenter;
    default:
      return AppColors.center;
  }
}

String getBiasName(Bias bias, {String? suffix}){
  switch (bias) {
    case Bias.left:
      return '진보 ${suffix ?? ''}';
    case Bias.leftCenter:
      return '중도 진보 ${suffix ?? ''}';
    case Bias.center:
      return '중도 ${suffix ?? ''}';
    case Bias.rightCenter:
      return '중도 보수 ${suffix ?? ''}';
    default:
      return '보수 ${suffix ?? ''}';
  }
}
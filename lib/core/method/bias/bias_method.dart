import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../ui/color.dart';
import 'bias_enum.dart';

Icon getBiasIcon(Bias bias, {double size = 24.0}) {
  switch (bias) {
    case Bias.left:
      return Icon(Icons.trending_up, color: AppColors.left, size: size);
    case Bias.leftCenter:
      return Icon(Icons.trending_up, color: AppColors.leftCenter, size: size);
    case Bias.right:
      return Icon(Icons.account_balance, color: AppColors.right, size: size);
    case Bias.rightCenter:
      return Icon(Icons.account_balance, color: AppColors.rightCenter, size: size);
    default:
      return Icon(Icons.balance, color: AppColors.center, size: size);
  }
}

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

Bias getBiasFromString(String biasString) {
  switch (biasString) {
    case 'left':
      return Bias.left;
    case 'center_left':
      return Bias.leftCenter;
    case 'right':
      return Bias.right;
    case 'center_right':
      return Bias.rightCenter;
    default:
      return Bias.center;
  }
}
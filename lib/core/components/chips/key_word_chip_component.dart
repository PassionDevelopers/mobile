import 'package:flutter/material.dart';
import '../../../ui/color.dart';
import 'my_chip.dart';

class KeyWordChip extends StatelessWidget {
  const KeyWordChip({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return MyChip(borderColor: Colors.grey[300]!, content: Text(title,
      style: TextStyle(
        color: Colors.grey[700],
        fontSize: 14,
      ),
    ), color: AppColors.surface,);
  }
}

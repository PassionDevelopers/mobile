import 'package:flutter/material.dart';

class MyChip extends StatelessWidget {
  const MyChip({super.key, this.borderColor, required this.content, required this.color});
  final Color? borderColor;
  final Widget content;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        border: borderColor== null? null : Border.all(color: borderColor!),
        borderRadius: BorderRadius.circular(15),
      ),
      child: content
    );
  }
}

import 'package:flutter/material.dart';
import '../../../ui/fonts.dart';

class BigTitle extends StatelessWidget {
  const BigTitle({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title, style: MyFontStyle.h1),
    );
  }
}

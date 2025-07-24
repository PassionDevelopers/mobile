import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';

class TypeAnimateText extends StatefulWidget {
  const TypeAnimateText({super.key});

  @override
  State<TypeAnimateText> createState() => _TypeAnimateTextState();
}

class _TypeAnimateTextState extends State<TypeAnimateText> {
  bool showSecondLine = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedTextKit(
          totalRepeatCount: 1,
          animatedTexts: [
            TypewriterAnimatedText(
              '바쁘신가요?',
              speed: Duration(milliseconds: 100),
              textStyle: MyFontStyle.h2.copyWith(
                  color: AppColors.primaryLight
              ),
            ),
          ],
          onFinished: () {
            setState(() {
              showSecondLine = true;
            });
          },
        ),
        showSecondLine?
          AnimatedTextKit(
            totalRepeatCount: 1,
            animatedTexts: [
              TypewriterAnimatedText(
                '이것만 보세요.',
                speed: Duration(milliseconds: 100),
                textStyle: MyFontStyle.h1.copyWith(
                    color: AppColors.primaryLight
                ),
              ),
            ],
          ) : MyText.h1('')
      ],
    );
  }
}

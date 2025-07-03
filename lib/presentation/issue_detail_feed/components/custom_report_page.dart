import 'package:could_be/core/components/title/big_title.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';

class CustomReportPage extends StatelessWidget {
  const CustomReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BigTitle(title: '이 이슈가 나에게 미치는 영향은?'),
        SizedBox(height: MyPaddings.medium),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyText.h3('구독 서비스로 제공되는 기능입니다.'),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                  onPressed: (){}, child: Text('구독하기')),
            ],
          ),
        ),
        SizedBox(height: MyPaddings.medium),

      ],
    );
  }
}


import 'package:could_be/core/components/text/interactive_text.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';

import '../../../core/themes/margins_paddings.dart';
import '../../../domain/entities/issue_detail.dart';

class BackgroundDescription extends StatefulWidget {
  const BackgroundDescription({
    super.key,
    required this.issue,
    required this.fontSize,
    required this.isSubscribed,
    required this.onSubscribe,
    required this.isSpread,
    required this.spreadCallback,
  });

  final IssueDetail issue;
  final double fontSize;
  final bool isSubscribed;
  final VoidCallback onSubscribe;
  final bool isSpread;
  final VoidCallback spreadCallback;

  @override
  State<BackgroundDescription> createState() => _BackgroundDescriptionState();
}

class _BackgroundDescriptionState extends State<BackgroundDescription> {

  @override
  Widget build(BuildContext context) {

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(MyPaddings.large),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.gray5,
                  width: 1,
                ),
              ),
            ),
            child: GestureDetector(
              onTap: widget.spreadCallback,
              child: Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.menu_book_outlined,
                      color: AppColors.primary,
                      size: 24,
                    ),
                    SizedBox(width: MyPaddings.medium),
                    Text(
                      '배경 설명',
                      style: MyFontStyle.h2.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      widget.isSpread ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    ),
                  ],
                ),
              ),
            ),
          ),
          if(widget.isSpread)
            Padding(
              padding: EdgeInsets.all(MyPaddings.large),
              child: InteractiveText(
                text: '	•	기후 위기가 국가적 핵심 과제이며, 대응이 필수적이기 때문입니다. 기후 위기로 인한 극한 폭우, 폭염, 가뭄 등 재난이 일상화되면서 적극적인 대응이 필요하다는 입장입니다.\n\n'
                    '•	2050년 탄소 중립 목표를 법제화했기 때문에 그 목표를 달성해야 하기 때문입니다. 이 대통령은 2035년까지 온실가스 감축 목표를 설정하여 국가 감축 목표를 달성하는 방향으로 정책을 추진하고 있습니다.\n\n'
                    '•	환경 문제와 경제 문제는 분리할 수 없고, 기후 위기를 성장의 기회로 만들어야 한다고 보기 때문입니다. 재생에너지 생산을 획기적으로 늘려 새로운 경제 활로와 신산업 개발로 기후 위기 대응과 경제 성장을 함께 이루고자 합니다.\n\n'
                    '•	온실가스 감축 과정에서 전기요금 인상 등 경제적 부담이 있을 수 있으나, 이를 국민에게 적극적으로 알리고 이해와 동의를 구해야 한다고 강조합니다. 또한 취약계층 보호 대책도 함께 고려하라고 지시했습니다.',
                fontSize: widget.fontSize,
                textColor: AppColors.gray1,
                highlightColor: Colors.amberAccent,
              ),
            ),
        ],
      ),
    );
  }
}

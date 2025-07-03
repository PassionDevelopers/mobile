

import 'package:could_be/domain/entities/topic.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../ui/color.dart';
import '../../../ui/fonts.dart';
import '../../themes/margins_paddings.dart';

class TopicCard extends StatelessWidget {
  const TopicCard({super.key, required this.topic, required this.onTap, required this.onTapSubscribe});
  final Topic topic;
  final VoidCallback onTap;
  final VoidCallback onTapSubscribe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: MyPaddings.small),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: Ink(
          padding: EdgeInsets.symmetric(
            horizontal: MyPaddings.medium,
            vertical: MyPaddings.extraSmall,
          ),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(10),
            // border: Border.all(
            //   color: AppColors.border,
            //   width: 1,
            // ),
          ),
          child: Row(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: onTapSubscribe,
                child: Padding(
                  padding: EdgeInsets.only(right: MyPaddings.medium),
                  child: Ink(
                    height: double.infinity,
                    width: 25,
                    child: Center(
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          color: topic.isSubscribed? AppColors.check : AppColors.gray3,
                          shape: BoxShape.circle,
                        ),
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Icon(
                            topic.isSubscribed? Icons.check_circle_outlined : Icons.add_circle_outline,
                            color: AppColors.primaryLight,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: onTap,
                  child: Ink(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.h3(topic.name, color: AppColors.textPrimary,),
                        MyText.reg('이슈' + topic.issuesCount.toString(), color: AppColors.textSecondary,),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

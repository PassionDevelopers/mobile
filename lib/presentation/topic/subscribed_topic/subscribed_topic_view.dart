

import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:flutter/material.dart';

import '../../../core/components/title/big_title_icon.dart';

class SubscribedTopicView extends StatelessWidget {
  const SubscribedTopicView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MyPaddings.medium, vertical: MyPaddings.small),
          child: BigTitleAdd(title: '관심 토픽', onTap: (){

          }),
        ),
      ],
    );
  }
}
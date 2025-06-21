

import 'package:could_be/core/components/buttons/big_button.dart';
import 'package:could_be/core/components/title/big_title.dart';
import 'package:flutter/material.dart';
import '../../core/themes/margins_paddings.dart';

class MyPageView extends StatelessWidget {
  const MyPageView({super.key, required this.toWatchHistory,
    required this.toSubscribedIssue,
  });
  final VoidCallback toWatchHistory;
  final VoidCallback toSubscribedIssue;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: MyPaddings.large,
        vertical: MyPaddings.large,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            BigTitle(title: '나의 성향'),
            SizedBox(height: MyPaddings.large,),
            BigButton('나의 성향 : 중도 진보', onPressed: (){

            }),
            SizedBox(height: MyPaddings.large,),
            BigTitle(title: '나의 관심 항목'),
            SizedBox(height: MyPaddings.large,),

            BigButton('나의 관심 이슈', onPressed: toSubscribedIssue),
            SizedBox(height: MyPaddings.medium,),
            BigButton('나의 관심 매체', onPressed: (){
        
            }),
            SizedBox(height: MyPaddings.medium,),
            BigButton('나의 관심 토픽', onPressed: (){


            }),
            SizedBox(height: MyPaddings.large,),
            BigTitle(title: '나의 활동'),
            SizedBox(height: MyPaddings.large,),
            BigButton('내가 본 이슈', onPressed: toWatchHistory),
            SizedBox(height: MyPaddings.medium,),
            BigButton('내가 평가한 이슈', onPressed: (){
        
            }),
            SizedBox(height: MyPaddings.medium,),
            BigButton('내가 평가한 매체', onPressed: (){
        
            }),
          ],
        ),
      ),
    );
  }
}

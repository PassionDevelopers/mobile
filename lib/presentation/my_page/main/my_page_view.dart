

import 'package:could_be/core/components/buttons/big_button.dart';
import 'package:could_be/core/components/title/big_title.dart';
import 'package:could_be/core/di/use_case/use_case.dart';
import 'package:could_be/presentation/my_page/main/my_page_view_model.dart';
import 'package:flutter/material.dart';
import '../../../core/components/loading/skeleton.dart';
import '../../../core/themes/margins_paddings.dart';

class MyPageView extends StatelessWidget {
  const MyPageView({super.key, required this.toWatchHistory,
    required this.toSubscribedIssue, required this.toUserBiasStatus,
    required this.toManageMediaSubscription,
  });
  final VoidCallback toWatchHistory;
  final VoidCallback toSubscribedIssue;
  final VoidCallback toUserBiasStatus;
  final VoidCallback toManageMediaSubscription;

  @override
  Widget build(BuildContext context) {

    final viewModel = MyPageViewModel(fetchUserBiasUseCase: fetchUserBiasUseCase);
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
            ListenableBuilder(
              listenable: viewModel,
              builder: (context, _){
                final state = viewModel.state;
                if (state.isLoading) {
                  return BigButtonSkeleton();
                } else if (state.userBias == null) {
                  return BigButtonSkeleton();
                } else {
                  return BigButton(
                    '나의 성향 : ${state.userBias!}',
                    onPressed: toUserBiasStatus,
                  );
                }
              },
            ),
            SizedBox(height: MyPaddings.large,),
            BigTitle(title: '나의 관심 항목'),
            SizedBox(height: MyPaddings.large,),

            BigButton('나의 관심 이슈', onPressed: toSubscribedIssue),
            SizedBox(height: MyPaddings.medium,),
            BigButton('나의 관심 매체', onPressed: toManageMediaSubscription),
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
            // BigButton('내가 평가한 매체', onPressed: (){
            //
            // }),
          ],
        ),
      ),
    );
  }
}

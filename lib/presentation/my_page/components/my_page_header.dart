import 'package:could_be/core/components/profile/default_profile.dart';
import 'package:could_be/core/components/profile/profile_frame.dart';
import 'package:could_be/core/components/text_form_field.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/domain/entities/dasi_score.dart';
import 'package:could_be/presentation/my_page/main/my_page_view_model.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyPageHeader extends StatelessWidget {
  const MyPageHeader({super.key, required this.viewModel});

  final MyPageViewModel viewModel;

  Widget _buildCompactScoreSection() {
    final DasiScore? score = viewModel.state.dasiScore;
    const maxScore = 100;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.stars_rounded, color: AppColors.primary, size: 16),
            SizedBox(width: 4),
            Text(
              '다시 스코어',
              style: MyFontStyle.small.copyWith(color: AppColors.gray600),
            ),
            SizedBox(width: MyPaddings.small),
            Text(
              '${score == null || viewModel.state.isDasiScoreLoading ? '??' : score.score.round()}',
              style: MyFontStyle.h3.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '/$maxScore',
              style: MyFontStyle.small.copyWith(color: AppColors.gray600),
            ),
            SizedBox(width: MyPaddings.small),
            GestureDetector(
              onTap: viewModel.fetchDasiScore,
              child: Icon(Icons.refresh, size: 15, color: AppColors.gray600),
            ),
          ],
        ),
        SizedBox(height: MyPaddings.small),
        // Compact Progress Bar
        Container(
          height: 4,
          width: 200,
          decoration: BoxDecoration(
            color: AppColors.gray300,
            borderRadius: BorderRadius.circular(2),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: (score?.score ?? 0) / maxScore,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final state = viewModel.state;
        return Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: MyPaddings.large),
                child: Row(
                  children: [
                    // Profile Image
                    GestureDetector(
                      onTap: () {
                        if (state.isEditMode) {
                          context.push(RouteNames.profileManage, extra: state.userProfile?.imageUrl);
                        }
                      },
                      child: Stack(
                        children: [
                          ProfileFrame(
                            width: 70,
                            bias: state.userProfile?.bias,
                            child:
                                state.isBiasLoading? CircularProgressIndicator() :
                                state.userProfile?.imageUrl == null
                                    ? DefaultProfile(size: 35)
                                    : Image.network(
                                      state.userProfile!.imageUrl!,
                                      fit: BoxFit.cover,
                                    ),
                          ),
                          if (state.isEditMode)
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.white,
                                    width: 2,
                                  ),
                                ),

                                child: Icon(
                                  Icons.camera_alt,
                                  size: 14,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(width: MyPaddings.large),
                    // Name and Score
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!state.isEditMode)
                            MyText.h1(
                              state.userProfile == null
                                  ? '   '
                                  : state.userProfile!.nickname,
                              color: AppColors.primary,
                            )
                          else
                            MyForm(
                              formKey: state.formKey,
                              controller: state.nicknameController,
                              hintText:
                                  state.userProfile?.nickname ?? '닉네임을 입력하세요',
                            ),
                          SizedBox(height: MyPaddings.small),
                          if (!state.isEditMode)
                            _buildCompactScoreSection()
                          else
                            Row(
                              children: [
                                TextButton(
                                  onPressed: viewModel.setEditMode,
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: MyPaddings.large,
                                      vertical: MyPaddings.small,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: BorderSide(
                                        color: AppColors.gray400,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    '취소',
                                    style: MyFontStyle.small.copyWith(
                                      color: AppColors.gray600,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(width: MyPaddings.small),
                                TextButton(
                                  onPressed: viewModel.updateUserNickname,
                                  style: TextButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: MyPaddings.large,
                                      vertical: MyPaddings.small,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    '저장',
                                    style: MyFontStyle.small.copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Edit button
            SizedBox(
              width: 20,
              child:
                  !viewModel.state.isEditMode
                      ? GestureDetector(
                        onTap: () {
                          viewModel.setEditMode();
                        },
                        child: Icon(
                          Icons.edit_outlined,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      )
                      : SizedBox.shrink(),
            ),
            SizedBox(width: MyPaddings.large),
          ],
        );
      },
    );
  }
}

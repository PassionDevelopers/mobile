import 'package:could_be/core/components/buttons/big_button.dart';
import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:could_be/core/components/profile/default_profile.dart';
import 'package:could_be/core/components/profile/profile_frame.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/presentation/my_page/profile_manage/profile_manage_view_model.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileManageView extends StatefulWidget {
  const ProfileManageView({super.key, required this.imageUrl});

  final String? imageUrl;

  @override
  State<ProfileManageView> createState() => _ProfileManageViewState();
}

class _ProfileManageViewState extends State<ProfileManageView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<ProfileManageViewModel>(
      param1: context,
      param2: widget.imageUrl,
    );

    return RegScaffold(
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          final state = viewModel.state;
          return Stack(
            children: [
              Column(
                children: [
                  AppBar(
                    title: MyText.h2('프로필 편집'),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          viewModel.completeProfileUpdate();
                        },
                        child: MyText.h3('완료', color: AppColors.primary),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(MyPaddings.extraLarge),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: ProfileFrame(
                            width: 230,
                            bias: Bias.center,
                            child:
                                state.isLoading
                                    ? const CircularProgressIndicator()
                                    : state.uint8list != null
                                    ? Image.memory(
                                      state.uint8list!,
                                      fit: BoxFit.cover,
                                    )
                                    : state.imageUrl != null
                                    ? Image.network(
                                      state.imageUrl!,
                                      fit: BoxFit.cover,
                                    )
                                    : DefaultProfile(),
                          ),
                        ),
                        const SizedBox(height: MyPaddings.large),
                        BigButton(
                          onPressed: () {
                            viewModel.onImageButtonPressed(
                              ImageSource.gallery,
                              context: context,
                            );
                          },
                          widget: Row(
                            children: [
                              const SizedBox(width: MyPaddings.extraLarge),
                              const Icon(Icons.photo),
                              const SizedBox(width: MyPaddings.large),
                              MyText.h3('앨범에서 선택'),
                            ],
                          ),
                        ),
                        const SizedBox(height: MyPaddings.large),
                        BigButton(
                          onPressed: viewModel.onCameraButtonPressed,
                          widget: Row(
                            children: [
                              const SizedBox(width: MyPaddings.extraLarge),
                              const Icon(Icons.camera_alt),
                              const SizedBox(width: MyPaddings.large),
                              MyText.h3('사진 촬영'),
                            ],
                          ),
                        ),
                        const SizedBox(height: MyPaddings.large),
                        BigButton(
                          onPressed: viewModel.onDeleteButtonPressed,
                          backgroundColor: AppColors.warning,
                          widget: Row(
                            children: [
                              const SizedBox(width: MyPaddings.extraLarge),
                              Icon(
                                Icons.delete_outline_rounded,
                                color: AppColors.white,
                              ),
                              const SizedBox(width: MyPaddings.large),
                              MyText.h3('삭제', color: AppColors.white),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (state.isUploading)
                Container(
                  color: AppColors.primary.withOpacity(0.3),
                  child: Center(child: const CircularProgressIndicator()),
                ),
            ],
          );
        },
      ),
      isScrollPage: false,
    );
  }
}

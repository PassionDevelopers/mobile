import 'package:could_be/core/components/app_bar/app_bar.dart';
import 'package:could_be/core/components/app_bar/reg_app_bar.dart';
import 'package:could_be/core/components/buttons/big_button.dart';
import 'package:could_be/core/components/layouts/bottom_safe_padding.dart';
import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:could_be/core/components/text_form_field.dart';
import 'package:could_be/core/components/title/big_title.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/presentation/customer_services/feedback_view_model.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:could_be/core/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FeedbackView extends StatefulWidget {
  const FeedbackView({super.key});

  @override
  State<FeedbackView> createState() => _FeedbackViewState();
}

class _FeedbackViewState extends State<FeedbackView> {
  final _formKey = GlobalKey<FormState>();
  // final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  String _selectedCategory = '일반 문의';

  final List<String> _categories = [
    '일반 문의',
    '기능 제안',
    '버그 신고',
    '콘텐츠 문의',
    '계정 관련',
    '기타'
  ];

  late final FeedbackViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = getIt<FeedbackViewModel>();
  }

  @override
  void dispose() {
    // _nameController.dispose();
    _emailController.dispose();
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RegScaffold(
      isScrollPage: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            RegAppBar(
              title: '피드백 보내기',
              iconData: Icons.feedback_outlined,
            ),
            Padding(
              padding: const EdgeInsets.all(MyPaddings.large),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigTitle(title: '의견을 들려주세요'),
                    SizedBox(height: MyPaddings.small),
                    Text(
                      '여러분의 소중한 의견이 다시 스탠드를 더 나은 서비스로 만들어갑니다.',
                      style: TextStyles.smallTextRegular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: MyPaddings.large),
                    
                    // Category Selection
                    _buildSectionTitle('문의 유형'),
                    SizedBox(height: MyPaddings.small),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: MyPaddings.medium,
                        vertical: MyPaddings.small,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.white,
                      ),
                      child: DropdownButton<String>(
                        value: _selectedCategory,
                        isExpanded: true,
                        underline: SizedBox(),
                        items: _categories.map((category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Text(
                              category,
                              style: TextStyles.normalTextRegular,
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value!;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: MyPaddings.large),

                    // // Name Field
                    // _buildSectionTitle('이름'),
                    // SizedBox(height: MyPaddings.small),
                    // _buildTextField(
                    //   controller: _nameController,
                    //   hintText: '이름을 입력해주세요',
                    //   validator: (value) {
                    //     if (value == null || value.trim().isEmpty) {
                    //       return '이름을 입력해주세요';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    // SizedBox(height: MyPaddings.large),

                    // Email Field
                    _buildSectionTitle('이메일'),
                    SizedBox(height: MyPaddings.small),
                    _buildTextField(
                      controller: _emailController,
                      hintText: '답변을 받을 이메일을 입력해주세요',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        // if (value == null || value.trim().isEmpty) {
                        //   return '이메일을 입력해주세요';
                        // }
                        if (value != null && value.trim().isNotEmpty && !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return '올바른 이메일 형식을 입력해주세요';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MyPaddings.large),

                    // Title Field
                    _buildSectionTitle('제목'),
                    SizedBox(height: MyPaddings.small),
                    _buildTextField(
                      controller: _titleController,
                      hintText: '제목을 입력해주세요',
                      // validator: (value) {
                      //   if (value == null || value.trim().isEmpty) {
                      //     return '제목을 입력해주세요';
                      //   }
                      //   return null;
                      // },
                    ),
                    SizedBox(height: MyPaddings.large),

                    // Content Field
                    _buildSectionTitle('내용*'),
                    SizedBox(height: MyPaddings.small),
                    _buildTextField(
                      controller: _contentController,
                      hintText: '구체적인 내용을 입력해주세요',
                      maxLines: 6,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return '내용을 입력해주세요';
                        }
                        if (value.trim().length < 10) {
                          return '최소 10자 이상 입력해주세요';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MyPaddings.extraLarge),

                    // Submit Button
                    ListenableBuilder(
                      listenable: _viewModel,
                      builder: (context, _) {
                        return BigButton(
                          text: '피드백 보내기',
                          onPressed: _viewModel.state.isSubmitting
                              ? () {}
                              : () => _submitFeedback(),
                          // isLoading: _viewModel.state.isSubmitting,
                        );
                      },
                    ),
                    SizedBox(height: MyPaddings.large),
                  ],
                ),
              ),
            ),
            BottomSafePadding()
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyles.normalTextBold.copyWith(
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.gray400.withOpacity(0.3),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: MyTextFormField(
        controller: controller,
        hintText: hintText,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: validator,
      ),);
  }

  Future<void> _submitFeedback() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      await _viewModel.submitFeedback(
        category: _selectedCategory,
        // name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
      );

      if (mounted) {
        _showSuccessDialog();
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog(e.toString());
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: AppColors.white,
        title: Text(
          '피드백이 전송되었습니다',
          style: TextStyles.mediumTextBold.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        content: Text(
          '소중한 의견 감사합니다.\n빠른 시일 내에 검토 후 답변드리겠습니다.',
          style: TextStyles.normalTextRegular.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.pop();
            },
            child: Text(
              '확인',
              style: TextStyles.normalTextBold.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: AppColors.white,
        title: Text(
          '오류가 발생했습니다',
          style: TextStyles.mediumTextBold.copyWith(
            color: AppColors.warning,
          ),
        ),
        content: Text(
          '피드백 전송 중 오류가 발생했습니다.\n잠시 후 다시 시도해주세요.',
          style: TextStyles.normalTextRegular.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              '확인',
              style: TextStyles.normalTextBold.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
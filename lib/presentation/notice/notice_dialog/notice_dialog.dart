import 'dart:developer';

import 'package:could_be/core/components/loading/not_found.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/domain/entities/notice.dart';
import 'package:could_be/presentation/notice/notice_dialog/notice_dialog_view_model.dart';
import 'package:could_be/presentation/notice/notice_view_model.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../core/di/di_setup.dart';

class NoticeDialog extends StatelessWidget {
  const NoticeDialog({super.key, required this.notice});
  final Notice notice;

  Widget htmlBuilder(Notice notice) {
    return Html(
      data: notice.content ?? '',

      // style: {
      //   "body": Style(
      //     fontSize: FontSize(MyFontSizes.medium),
      //     color: AppColors.textPrimary,
      //     padding: HtmlPaddings.symmetric(horizontal: MyPaddings.large),
      //     lineHeight: LineHeight(1.6),
      //   ),
      //   "h1": Style(
      //     fontSize: FontSize(MyFontSizes.h0),
      //     fontWeight: FontWeight.w700,
      //     color: AppColors.textPrimary,
      //     margin: Margins(bottom: Margin(MyPaddings.medium, Unit.px)),
      //   ),
      //   "h2": Style(
      //     fontSize: FontSize(MyFontSizes.extraLarge),
      //     fontWeight: FontWeight.w600,
      //     color: AppColors.textPrimary,
      //     margin: Margins(bottom: Margin(MyPaddings.small, Unit.px)),
      //   ),
      //   "p": Style(
      //     margin: Margins(bottom: Margin(MyPaddings.medium, Unit.px)),
      //   ),
      //   "a": Style(
      //     color: AppColors.primary,
      //     textDecoration: TextDecoration.underline,
      //   ),
      // },
      // extensions: [
      //   TagExtension(
      //     tagsToExtend: {"flutter"},
      //     child: const FlutterLogo(),
      //   ),
      // ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final NoticeDialogViewModel viewModel = getIt<NoticeDialogViewModel>(param1: notice);
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              padding: EdgeInsets.all(MyPaddings.small),
              child: Row(
                children: [
                  SizedBox(width: MyPaddings.medium),
                  if (notice.isImportant)
                    Align(
                    alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: MyPaddings.small,
                          vertical: MyPaddings.extraSmall,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.warning,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: MyText.small(
                          '중요',
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  if (notice.isImportant)
                    SizedBox(width: MyPaddings.small),
                  Align(
                    alignment: Alignment.centerLeft,
                      child: MyText.h2(notice.title, fontWeight: FontWeight.w700,)),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close, color: AppColors.textSecondary),
                    onPressed: () => Navigator.of(context).pop(),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: AppColors.border,
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: MyPaddings.large),
                child: ListenableBuilder(
                  listenable: viewModel,
                  builder: (context, state) {
                    final state = viewModel.state;
                    if(state.isLoading){
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      );
                    }else if(state.notice == null || state.notice!.content == null){
                      return Center(
                        child: NotFound(notFoundType: NotFoundType.notice),
                      );
                    }
                    return htmlBuilder(state.notice!);
                  }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
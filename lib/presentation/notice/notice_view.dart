import 'package:could_be/core/components/app_bar/app_bar.dart';
import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:could_be/core/components/loading/not_found.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/presentation/notice/components/notice_card.dart';
import 'package:could_be/presentation/notice/notice_view_model.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NoticeView extends StatefulWidget {
  const NoticeView({super.key});

  @override
  State<NoticeView> createState() => _NoticeViewState();
}

class _NoticeViewState extends State<NoticeView> {
  late final NoticeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt<NoticeViewModel>();
    viewModel.fetchNotices();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MyPaddings.large,
            vertical: MyPaddings.small,
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RegScaffold(
      body: Column(
        children: [
          RegAppBar(title: '공지사항'),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await viewModel.fetchNotices();
              },
              backgroundColor: AppColors.primaryLight,
              color: AppColors.primary,
              child: ListenableBuilder(
                listenable: viewModel,
                builder: (context, _) {
                  final state = viewModel.state;
                  if (state.isLoading && state.notices == null) {
                    return _buildLoadingState();
                  }
                  if (state.notices == null || state.notices!.notices.isEmpty) {
                    return Center(
                      child: NotFound(notFoundType: NotFoundType.notice),
                    );
                  }
                  return ListView.builder(
                    itemCount: state.notices!.notices.length,
                    itemBuilder: (context, index) {
                      final notice = state.notices!.notices[index];
                      return NoticeCard(notice: notice,
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:could_be/core/components/layouts/text_helper.dart';
import 'package:could_be/core/components/loading/not_found.dart';
import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/domain/entities/comment/major_comment.dart';
import 'package:could_be/core/components/comments/major_user_opinion_component.dart';
import 'package:could_be/presentation/issue_detail_feed/issue_detail_view_model.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:flutter/material.dart';
import '../../../../core/themes/margins_paddings.dart';

class MajorUserOpinionView extends StatefulWidget {
  const MajorUserOpinionView({super.key,required this.fontSize,
    required this.viewModel,
    required this.postDasiScore,
    required this.isSpread,
    required this.spreadCallback,});

  final IssueDetailViewModel viewModel;
  final double fontSize;
  final VoidCallback postDasiScore;
  final bool isSpread;
  final VoidCallback spreadCallback;

  @override
  State<MajorUserOpinionView> createState() => _MajorUserOpinionViewState();
}

class _MajorUserOpinionViewState extends State<MajorUserOpinionView> with TickerProviderStateMixin{
  final List<Color> _biasColors = [
    AppColors.left,
    AppColors.center,
    AppColors.right,
  ];

  bool isPosted = false;
  late List<bool> isWatchedBias;

  final List<String> _biasLabels = ['진보', '중도', '보수'];

  late final TabController _tabController = TabController(
    length: 3,
    initialIndex: 1,
    vsync: this,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isWatchedBias = [
      widget.viewModel.getMajorComments(bias: Bias.left).isEmpty,
      true,
      widget.viewModel.getMajorComments(bias: Bias.right).isEmpty,
    ];
    _tabController.addListener(() {
      setState(() {
      });
      // 탭이 변경될 때마다 isWatchedBias 업데이트
      if(!isPosted) {
        isWatchedBias = [
          _tabController.index == 0 ? true : isWatchedBias[0],
          true,
          _tabController.index == 2 ? true : isWatchedBias[2],
        ];
        if(!isWatchedBias.contains(false)){
          widget.postDasiScore();
          isPosted = true;
        }
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _buildTab(int index) {
    final isSelected = index == _tabController.index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          _tabController.animateTo(index);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.all(2),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          decoration: BoxDecoration(
            color: isSelected ? _biasColors[index] : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '${_biasLabels[index]} 댓글',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.gray2,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  _buildTabViewPage({
    required Bias bias,
  }) {
    final List<MajorComment> majorComments = widget.viewModel.getMajorComments(bias: bias);
    return widget.viewModel.state.isMajorCommentsLoading? Center(child: CircularProgressIndicator(),) :
    majorComments.isEmpty? bias == Bias.center?
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            icon: Icon(Icons.keyboard_arrow_left_outlined, color: AppColors.gray2),
            onPressed: (){
              _tabController.animateTo(0);
            }
        ),
        NotFound(notFoundType: NotFoundType.majorComment,),
        IconButton(
            icon: Icon(Icons.keyboard_arrow_right_outlined, color: AppColors.gray2),
            onPressed: (){
              _tabController.animateTo(2);
            }
        ),
      ],
    ):
    Center(child: NotFound(notFoundType: NotFoundType.majorComment,)) :
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(majorComments.length, (index) {
        final comment = majorComments[index];
        return Padding(
          padding: EdgeInsets.only(bottom: index == majorComments.length -1 ? 0 : MyPaddings.large),
          child: MajorUserOpinionComponent(comment: comment,
            onLikePressed: widget.viewModel.likeMajorComment,
            myBias: widget.viewModel.state.myBias,
            onReportPressed: widget.viewModel.showReportDialog,
            onDeletePressed: widget.viewModel.deleteMajorComment,
          ),
        );
      }
    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MyPaddings.medium),
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
          GestureDetector(
            onTap: (){},
            child: Container(
              padding: EdgeInsets.all(MyPaddings.large),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.gray5,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.people_outline,
                    color: AppColors.primary,
                    size: 24,
                  ),
                  SizedBox(width: MyPaddings.medium),
                  MyText.h2('성향별 사용자 대표 의견',),
                  Spacer(),
                  Icon(
                     widget.isSpread ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  ),
                ],
              ),
            ),
          ),
          if(widget.isSpread)
            Padding(
              padding: EdgeInsets.all(MyPaddings.large),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.gray5,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: List.generate(3, (index) {
                        return _buildTab(index);
                      }),
                    ),
                  ),
                  SizedBox(height: MyPaddings.large),
                  AutoSizedTabBarView(
                    tabController: _tabController,
                    heightChangeStream: widget.viewModel.majorCommentsStream,
                    children: [
                      _buildTabViewPage(
                        bias: Bias.left,
                      ),
                      _buildTabViewPage(
                        bias: Bias.center,
                      ),
                      _buildTabViewPage(
                        bias: Bias.right,
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

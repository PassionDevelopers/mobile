import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/presentation/community/comment/comment_view_model.dart';
import 'package:could_be/presentation/community/comment_input/comment_input_view.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import '../../../core/components/comments/comment_card.dart';
import '../../../domain/entities/comment.dart';

class CommentView extends StatefulWidget {
  const CommentView({super.key, required this.issueId});

  final String issueId;

  @override
  State<CommentView> createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  final ScrollController scrollController = ScrollController();
  final SlidingUpPanelController panelController = SlidingUpPanelController();
  late CommentViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt<CommentViewModel>(param1: widget.issueId);
    viewModel.initialize();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(listenable: viewModel, builder: (context, _) {
      return Stack(
        children: [
          viewModel.isLoading ? Center(child: CircularProgressIndicator()) : RefreshIndicator(
            onRefresh: () async {
              viewModel.fetchComments();
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                MyText.reg(
                  '${viewModel.userProfile == null ? '' : getBiasName(
                      viewModel.userProfile!.bias)} 댓글',
                  fontWeight: FontWeight.bold,
                  color: viewModel.userProfile == null
                      ? AppColors.gray2
                      : getBiasColor(viewModel.userProfile!.bias),
                ),
                _buildCommentStats(),
                Expanded(child: Container(
                  color: Colors.white,
                  child: ListView.separated(
                    controller: scrollController,
                    physics: ClampingScrollPhysics(),
                    padding: EdgeInsets.only(
                      left: MyPaddings.large,
                      right: MyPaddings.large,
                      bottom: 130,
                    ),
                    itemBuilder: (context, index) {
                      final comment = viewModel.comments[index];
                      return _buildCommentItem(comment);
                    },
                    separatorBuilder: (context, index) {
                      return Divider(height: 8, color: Colors.grey[100]);
                    },
                    shrinkWrap: true,
                    itemCount: viewModel.comments.length,
                  ),
                )),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: MediaQuery
                .of(context)
                .viewInsets
                .bottom,
            child: CommentInputView(issueId: widget.issueId,),
          ),
        ],
      );
    });
  }

  Widget _buildCommentStats() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MyPaddings.large, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '댓글 ${viewModel.getTotalCommentCount()}개',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          _buildSortButton(),
        ],
      ),
    );
  }

  Widget _buildSortButton() {
    return PopupMenuButton<CommentSortType>(
      onSelected: (CommentSortType value) => viewModel.setSortType(value),
      itemBuilder:
          (BuildContext context) =>
          CommentSortType.values
              .map(
                (sort) =>
                PopupMenuItem<CommentSortType>(
                  value: sort,
                  child: Row(
                    children: [
                      Icon(
                        viewModel.selectedSortType == sort
                            ? Icons.check
                            : Icons.sort,
                        size: 16,
                        color:
                        viewModel.selectedSortType == sort
                            ? AppColors.primary
                            : Colors.grey[600],
                      ),
                      SizedBox(width: 8),
                      Text(sort.displayName),
                    ],
                  ),
                ),
          )
              .toList(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              viewModel.selectedSortType.displayName,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            SizedBox(width: 4),
            Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentItem(Comment comment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommentCard(
          comment: comment,
          onLikePressed: () => viewModel.toggleLike(comment.id),
          onToggleReplies: () => viewModel.toggleReplies(comment.id),
          // onReplyPressed: () => viewModel.startReply(comment.id, comment.author.nickname),
          onReportPressed: () => viewModel.showReportDialog(context),
        ),
        // if (comment.replies.isNotEmpty == true) ...[
        //   SizedBox(height: 8),
        //   ...comment.replies.map((reply) => Padding(
        //     padding: EdgeInsets.only(left: 40),
        //     child: _buildCommentItem(reply),
        //   )),
        // ],
      ],
    );
  }

// Widget _buildReplyIndicator() {
//   return Container(
//     width: double.infinity,
//     padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
//     margin: EdgeInsets.only(bottom: 8),
//     decoration: BoxDecoration(
//       color: Colors.grey[100],
//       borderRadius: BorderRadius.circular(6),
//     ),
//     child: Row(
//       children: [
//         Icon(Icons.reply, size: 16, color: Colors.grey[600]),
//         SizedBox(width: 8),
//         Text(
//           '${viewModel.replyToUserName}님에게 답글 작성 중',
//           style: TextStyle(
//             fontSize: 12,
//             color: Colors.grey[600],
//           ),
//         ),
//         Spacer(),
//         GestureDetector(
//           onTap: viewModel.cancelReply,
//           child: Icon(Icons.close, size: 16, color: Colors.grey[600]),
//         ),
//       ],
//     ),
//   );
// }

//
// Widget _buildInputActions() {
//   return Padding(
//     padding: EdgeInsets.only(top: 8),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         TextButton(
//           onPressed: viewModel.cancelComment,
//           child: Text(
//             '취소',
//             style: TextStyle(
//               color: Colors.grey[600],
//               fontSize: 12,
//             ),
//           ),
//           style: TextButton.styleFrom(
//             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//             minimumSize: Size(0, 28),
//           ),
//         ),
//       ],
//     ),
//   );
// }
}

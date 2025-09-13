import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/presentation/community/comment/comment_state.dart';
import 'package:could_be/presentation/community/comment/comment_view_model.dart';
import 'package:could_be/presentation/community/comment_input/comment_input_view_model.dart';
import 'package:could_be/presentation/core/issue_list/infinite_scroll.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/components/comments/comment_card.dart';

class CommentView extends StatefulWidget {
  const CommentView({super.key, required this.issueId, required this.viewModel, required this.inputViewModel});

  final String issueId;
  final CommentViewModel viewModel;
  final CommentInputViewModel inputViewModel;

  @override
  State<CommentView> createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    infiniteScrollListener(
      scrollController: scrollController,
      onLoadMore: widget.viewModel.fetchMoreComments,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(listenable: widget.viewModel, builder: (context, _) {
      final state = widget.viewModel.state;
      return widget.viewModel.state.isLoading ? Center(child: CircularProgressIndicator()) : RefreshIndicator(
        onRefresh: () async {
          widget.viewModel.fetchComments();
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            MyText.reg(
              '${widget.viewModel.state.userProfile == null ? '' : getBiasName(
                  widget.viewModel.state.userProfile!.bias)} 댓글',
              fontWeight: FontWeight.bold,
              color: widget.viewModel.state.userProfile == null
                  ? AppColors.gray600
                  : getBiasColor(widget.viewModel.state.userProfile!.bias),
            ),
            _buildCommentStats(),
            Expanded(child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  Column(
                    children: List.generate(state.comments.length, (int index){
                      final comment = widget.viewModel.state.comments[index];
                      return CommentCard(
                        comment: comment,
                        isMine: comment.userProfile.userId == FirebaseAuth.instance.currentUser?.uid,
                        onLikePressed: widget.viewModel.toggleLike,
                        onToggleReplies: () => widget.viewModel.toggleReplies(comment.id),
                        onReplyPressed: () => widget.inputViewModel.startReply(comment.id, comment.userProfile.nickname),
                        onReportPressed: widget.viewModel.showReportDialog,
                        onDeletePressed: widget.viewModel.showDeleteConfirmDialog,
                      );
                    })
                  ),
                  if (state.isLoadingMore) CircularProgressIndicator(),

                  SizedBox(height: 160,)
                ],
              ),
            ))
          ],
        ),
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
            '댓글 ${widget.viewModel.state.commentsCount}개',
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
      onSelected: (CommentSortType value) => widget.viewModel.setSortType(value),
      color: AppColors.white,
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
                        widget.viewModel.state.selectedSortType == sort
                            ? Icons.check
                            : Icons.sort,
                        size: 16,
                        color:
                        widget.viewModel.state.selectedSortType == sort
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
              widget.viewModel.state.selectedSortType.displayName,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            SizedBox(width: 4),
            Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }
}

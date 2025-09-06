import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/presentation/community/comment/comment_view.dart';
import 'package:could_be/presentation/community/comment/comment_view_model.dart';
import 'package:could_be/presentation/community/comment_input/comment_input_view.dart';
import 'package:could_be/presentation/community/comment_input/comment_input_view_model.dart';
import 'package:flutter/material.dart';

class CommentRoot extends StatelessWidget {
  CommentRoot({super.key, required this.issueId});
  final String issueId;
  late final CommentViewModel commentViewModel = getIt<CommentViewModel>(param1: issueId);
  late final CommentInputViewModel commentInputViewModel = getIt<CommentInputViewModel>(param1: issueId, );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CommentView(issueId: issueId, viewModel: commentViewModel, inputViewModel: commentInputViewModel),
        Positioned(
          left: 0,
          right: 0,
          bottom: MediaQuery
              .of(context)
              .viewInsets
              .bottom,
          child: CommentInputView(issueId: issueId, viewModel: commentInputViewModel, commentViewModel: commentViewModel,)),
      ],
    );
  }
}

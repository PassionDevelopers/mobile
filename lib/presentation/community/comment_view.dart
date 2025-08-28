import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/domain/entities/user_profile.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import '../../core/many_use.dart';
import '../../core/components/comments/comment_card.dart';
import '../../domain/entities/comment.dart';

class CommentView extends StatefulWidget {
  const CommentView({super.key});

  @override
  State<CommentView> createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  final ScrollController scrollController = ScrollController();
  final SlidingUpPanelController panelController = SlidingUpPanelController();

  List<Comment> get sampleComments => [
    Comment(
      id: '1',
      content: '온실가스 없애는 가장 효율적인 방법은 원전밖에 없는데... 원전 못하게 막은 장본인들이... 그 부담을 국민에게 떠넘기고 있는 거다.',
      author: UserProfile(
        id: 'user1',
        nickname: '뉴스독자',
        bias: Bias.left,
        imageUrl: null,
      ),
      createdAt: DateTime.now().subtract(Duration(minutes: 15)),
      likeCount: 12,
      isLiked: false,
      replies: [
        Comment(
          id: '2',
          content: '설득이니 뭐니 해도 결국 전기요금 인상해서 국민 생활 어렵게 만들겠다는 거네...',
          author: UserProfile(
            id: 'user2',
            nickname: '사회관찰자',
            bias: Bias.left,
            imageUrl: null,
          ),
          createdAt: DateTime.now().subtract(Duration(minutes: 10)),
          likeCount: 5,
          isLiked: true,
          parentId: '1',
        ),
      ],
    ),
    Comment(
      id: '3',
      content: '기자분이 정말 객관적으로 잘 정리해주신 것 같아요. 감사합니다!',
      author: UserProfile(
        id: 'user3',
        nickname: '정보추구자',
        bias: Bias.left,
        imageUrl: null,
      ),
      createdAt: DateTime.now().subtract(Duration(hours: 1)),
      likeCount: 8,
      isLiked: false,
    ),
    Comment(
      id: '4',
      content: '이런 이슈는 계속 관심을 가지고 지켜봐야 할 것 같습니다. 앞으로도 좋은 기사 부탁드려요.',
      author: UserProfile(
        id: 'user4',
        nickname: '시민기자',
        bias: Bias.left,
        imageUrl: null,
      ),
      createdAt: DateTime.now().subtract(Duration(hours: 2)),
      likeCount: 3,
      isLiked: false,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: MyPaddings.large),
        decoration: ShapeDecoration(
          color: Colors.white,
          shadows: [BoxShadow(blurRadius: 5.0,spreadRadius: 2.0,color: const Color(0x11000000))],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              alignment: Alignment.center,
              height: 40.0,
              child: Row(
                children: <Widget>[
                  Icon(Icons.menu,size: 20,),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0,),
                  ),
                  MyText.reg('보수 성향 댓글창', fontWeight: FontWeight.bold, color: AppColors.right),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
            Divider(
              height: 0.5,
              color: Colors.grey[300],
            ),
            Flexible(
              child: Container(
                child: ListView.separated(
                  controller: scrollController,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final comment = sampleComments[index];
                    return CommentCard(
                      comment: comment,
                      onLikePressed: () {
                        setState(() {
                          // 좋아요 토글 로직
                        });
                      },
                      onReplyPressed: () {
                        // 답글 작성 로직
                      },
                      onReportPressed: () {
                        // 신고 로직
                        _showReportDialog(context);
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 0.5,
                    );
                  },
                  shrinkWrap: true,
                  itemCount: sampleComments.length,
                ),
                color: Colors.white,
              ),
            ),
          ],
          mainAxisSize: MainAxisSize.min,
        ),
      ),
    );
  }

  void _showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('댓글 신고'),
          content: Text('이 댓글을 신고하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('신고가 접수되었습니다.')),
                );
              },
              child: Text('신고'),
            ),
          ],
        );
      },
    );
  }
}



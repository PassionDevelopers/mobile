import 'package:flutter/material.dart';
import '../../core/many_use.dart';
import '../../ui/color.dart';
import '../../core/components/bias/bias_tab_view.dart';

class MajorUserOpinionComponent extends StatelessWidget {
  const MajorUserOpinionComponent({super.key,
    required this.text,
    required this.leftCount,
    required this.centerCount,
    required this.rightCount,
  });
  final String text;
  final int leftCount;
  final int centerCount;
  final int rightCount;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                // fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Row(
                  children: [
                    Icon(Icons.thumb_up_outlined, size: 16, color: AppColors.left),
                    const SizedBox(width: 5),
                    Text(leftCount.toString(), style: TextStyle(color: AppColors.left)),
                  ],
                ),
                const SizedBox(width: 16),
                Row(
                  children: [
                    Icon(Icons.thumb_up_outlined, size: 16, color: AppColors.center),
                    const SizedBox(width: 5),
                    Text(centerCount.toString(), style: TextStyle(color: AppColors.center)),
                  ],
                ),
                const SizedBox(width: 16),
                Row(
                  children: [
                    Icon(Icons.thumb_up_outlined, size: 16, color: AppColors.right),
                    const SizedBox(width: 5),
                    Text(rightCount.toString(), style: TextStyle(color: AppColors.right)),
                  ],
                ),
                const SizedBox(width: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class MajorUserOpinionView extends StatefulWidget {
  const MajorUserOpinionView({Key? key}) : super(key: key);

  @override
  State<MajorUserOpinionView> createState() => _MajorUserOpinionViewState();
}

class _MajorUserOpinionViewState extends State<MajorUserOpinionView> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          autoSizeText('사용자 대표 의견', color: AppColors.primary, fontSize: 20, fontWeight: FontWeight.bold),
          const SizedBox(height: 20),
          BiasTabView(
            leftContent: Column(children: [
              MajorUserOpinionComponent(
                text: '백신의 효과와 안전성은 지속적인 연구가 필요합니다.',
                leftCount: 58,
                centerCount: 47,
                rightCount: 12,
              ),
              MajorUserOpinionComponent(
                text: '과학적 데이터에 기반한 백신 효과 분석이 중요합니다.',
                leftCount: 47,
                centerCount: 58,
                rightCount: 9,
              ),
              MajorUserOpinionComponent(
                text: '해외 백신 접종률과 비교할 때, 한국의 백신 접종률은 높은 편입니다.',
                leftCount: 65,
                centerCount: 50,
                rightCount: 15,
              )

            ],),
            centerContent: Column(children: [
              MajorUserOpinionComponent(
                text: '백신의 효과와 안전성은 지속적인 연구가 필요합니다.',
                leftCount: 58,
                centerCount: 47,
                rightCount: 12,
              ),
              MajorUserOpinionComponent(
                text: '과학적 데이터에 기반한 백신 효과 분석이 중요합니다.',
                leftCount: 47,
                centerCount: 58,
                rightCount: 9,
              ),
            ],),
            rightContent: Column(children: [
              MajorUserOpinionComponent(
                text: '백신의 효과와 안전성은 지속적인 연구가 필요합니다.',
                leftCount: 58,
                centerCount: 47,
                rightCount: 12,
              ),
              MajorUserOpinionComponent(
                text: '과학적 데이터에 기반한 백신 효과 분석이 중요합니다.',
                leftCount: 47,
                centerCount: 58,
                rightCount: 9,
              ),
            ],),
          ),
          const SizedBox(height: 16),



          SizedBox(
            height: 240,
            child: DefaultTabController(length: 2, child: Column(children: [
              TabBar(tabs: [Tab(text: '대표 의견 제안'), Tab(text: '내부 자유 댓글',)]),
              Expanded(child: TabBarView(children: [
                const SizedBox(),
                // 댓글 입력 상자
                Column(
                  children: [
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: TextField(
                        controller: _commentController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(16),
                          hintText: '의견을 작성해주세요...',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: const Text('댓글 작성'),
                      ),
                    ),
                  ],
                ),
              ],))
            ],)),
          ),
          // 댓글 작성 버튼
          //
          // const SizedBox(height: 10),

          // 댓글 목록
          CommentItem(
            userId: 'U1',
            username: '사용자1',
            timeAgo: '3시간 전',
            content: '백신이 효과는 과학적으로 입증되었으며, 공중보건을 위해 접종률을 높이는 것이 중요합니다.',
            likes: 5,
          ),

          const Divider(height: 1),

          // 두 번째 댓글 (일부만 표시되어 있음)
          CommentItem(
            userId: 'U1',
            username: '사용자1',
            timeAgo: '3시간 전',
            content: '백신이 효과는 과학적으로 입증되었으며, 공중보건을 위해 접종률을 높이는 것이 중요합니다.',
            likes: 5,
          ),
        ],
      ),
    );
  }
}

class CommentItem extends StatelessWidget {
  final String userId;
  final String username;
  final String timeAgo;
  final String content;
  final int likes;

  const CommentItem({
    Key? key,
    required this.userId,
    required this.username,
    required this.timeAgo,
    required this.content,
    required this.likes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                userId,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      username,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      timeAgo,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.more_horiz,
                      color: Colors.grey.shade500,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  content,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.thumb_up_outlined, size: 16, color: Colors.grey.shade700),
                        const SizedBox(width: 5),
                        Text('$likes', style: const TextStyle(color: Colors.black54)),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Text('답글', style: TextStyle(color: Colors.grey.shade600)),
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
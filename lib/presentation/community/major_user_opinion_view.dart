import 'package:could_be/core/components/comments/user_profile_widget.dart';
import 'package:could_be/core/components/layouts/text_helper.dart';
import 'package:could_be/core/components/loading/not_found.dart';
import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/core/method/date_time_parsing.dart';
import 'package:could_be/domain/entities/comment.dart';
import 'package:could_be/domain/entities/issue_detail.dart';
import 'package:could_be/domain/entities/user_profile.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';
import '../../../core/method/bias/bias_method.dart';
import '../../../core/method/text_parsing.dart';
import '../../../core/themes/margins_paddings.dart';
import '../../core/themes/margins_paddings.dart' show MyPaddings;
import '../../ui/color.dart';

class MajorUserOpinionComponent extends StatelessWidget {
  const MajorUserOpinionComponent({super.key,
    required this.comment,
    required this.leftCount,
    required this.centerCount,
    required this.rightCount,
  });
  final Comment comment;
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
            Row(
              children: [
                UserProfileWidget(
                  userProfile: comment.author,
                  size: comment.isReply ? 32 : 40,
                ),
                SizedBox(width: 8),
                Text(
                  '•',
                  style: TextStyle(color: AppColors.gray3),
                ),
                SizedBox(width: 8),
                MyText.reg(
                  getTimeAgo(comment.createdAt),
                  color: AppColors.gray2,
                ),

                Spacer(),
                Icon(Icons.more_vert, color: AppColors.gray3,)
              ],
            ),
            SizedBox(height: MyPaddings.small),
            Text(
              comment.content,
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
  const MajorUserOpinionView({super.key,required this.fontSize,
    required this.issue,
    required this.postDasiScore,
    required this.isSpread,
    required this.spreadCallback,});

  final IssueDetail issue;
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
    // const Color(0xFFE53E3E), // 진보 - 빨강
    // const Color(0xFF38A169), // 중도 - 초록
    // const Color(0xFF3182CE), // 보수 - 파랑
  ];

  bool isPosted = false;
  late List<bool> isWatchedBias;

  final List<String> _biasLabels = ['진보', '중도', '보수'];

  late final IssueDetail issue = widget.issue;
  late final TabController _tabController = TabController(
    length: 3,
    initialIndex: 1,
    vsync: this,
  );

  List<MajorUserOpinionComponent> rightOpinions = [
    MajorUserOpinionComponent(
      comment: Comment(
        id: '1',
        content: '온실가스 없애는 가장 효율적인 방법은 원전밖에 없는데... 원전 못하게 막은 장본인들이... 그 부담을 국민에게 떠넘기고 있는 거다.',
        author: UserProfile(
          id: 'user1',
          bias: Bias.left,
          nickname: '뉴스독자',
          imageUrl: null,
        ),
        createdAt: DateTime.now().subtract(Duration(minutes: 15)),
        likeCount: 12,
        isLiked: false,
        replies: [
        ],
      ),
      leftCount: 27,
      centerCount: 32,
      rightCount: 14,
    ),
    MajorUserOpinionComponent(
      comment: Comment(
        id: '2',
        content: '설득이니 뭐니 해도 결국 전기요금 인상해서 국민 생활 어렵게 만들겠다는 거네...',
        author: UserProfile(
          id: 'user1',
          nickname: '사회관찰자',
          bias: Bias.left,
          imageUrl: null,
        ),
        createdAt: DateTime.now().subtract(Duration(minutes: 15)),
        likeCount: 12,
        isLiked: false,
        replies: [
        ],
      ),
      leftCount: 27,
      centerCount: 32,
      rightCount: 14,
    ),

    MajorUserOpinionComponent(
      comment: Comment(
        id: '3',
        content: '원전을 더 지으면 될일인데 과연 태양광 업계의 뒷돈을 얼마나 먹고 저렇게 시동을 거는지 ... 임기 끝날때는 정전 슬슬 나겠구만',
        author: UserProfile(
          id: 'user1',
          nickname: '나무둥글',
          bias: Bias.left,
          imageUrl: null,
        ),
        createdAt: DateTime.now().subtract(Duration(minutes: 15)),
        likeCount: 12,
        isLiked: false,
        replies: [
        ],
      ),
      leftCount: 27,
      centerCount: 32,
      rightCount: 14,
    ),
  ];
  List<MajorUserOpinionComponent> cetnerOptions = [];
  List<MajorUserOpinionComponent> leftOpinions = [
    MajorUserOpinionComponent(
      comment: Comment(
        id: '4',
        content: '윤석열 검찰독재 정권이 망친 것이 한들이 아니죠. 그래도 어쩔 수없이 수출품 생산 공장부터 재생에너지 공급해야죠. 제일 먼저 해야 할 것은 석탄화력발전소부터 정지시켜야 합니다. 대신에 풍력발전소로 대체할 기회를 제공하는 것으로',
        author: UserProfile(
        id: 'user1',
        nickname: '뉴스독자',
        bias: Bias.left,
        imageUrl: null,
        ),
        createdAt: DateTime.now().subtract(Duration(minutes: 15)),
        likeCount: 12,
        isLiked: false,
        replies: [],
      ),
      leftCount: 27,
      centerCount: 32,
      rightCount: 14,
    ),

    MajorUserOpinionComponent(
      comment: Comment(
        id: '4',
        content: '윤정부 들어서 전기요금으로 국민들이 너무 힘들어 하고 있습니다 환경문제 보다 더시급한게 서민이 살아가는 문제 입니다 윤정부에서 가스요금 전기요금 많이 올려놔 국민들은 삶에 시달리고 있어요',
        author: UserProfile(
          id: 'user1',
          nickname: '뉴스독자',
          bias: Bias.left,
          imageUrl: null,
        ),
        createdAt: DateTime.now().subtract(Duration(minutes: 15)),
        likeCount: 12,
        isLiked: false,
        replies: [],
      ),
      leftCount: 27,
      centerCount: 32,
      rightCount: 14,
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // isWatchedBias = [
    //   issue.leftSummary == null,
    //   true,
    //   issue.rightSummary == null,
    // ];
    _tabController.addListener(() {
      setState(() {
      });
      // 탭이 변경될 때마다 isWatchedBias 업데이트
      // if(!isPosted) {
      //   isWatchedBias = [
      //     _tabController.index == 0 ? true : isWatchedBias[0],
      //     true,
      //     _tabController.index == 2 ? true : isWatchedBias[2],
      //   ];
      //   if(!isWatchedBias.contains(false)){
      //     widget.postDasiScore();
      //     isPosted = true;
      //   }
      // }
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
            '${_biasLabels[index]} 언론',
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
    required String? text,
    required List<String>? keywords,
  }) {
    return text == null? bias == Bias.center?
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            icon: Icon(Icons.keyboard_arrow_left_outlined, color: AppColors.gray2),
            onPressed: (){
              _tabController.animateTo(0);
            }
        ),
        NotFound(notFoundType: NotFoundType.article,),
        IconButton(
            icon: Icon(Icons.keyboard_arrow_right_outlined, color: AppColors.gray2),
            onPressed: (){
              _tabController.animateTo(2);
            }
        ),
      ],
    ):
    Center(child: NotFound(notFoundType: NotFoundType.article,)) :
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: bias == Bias.left ? leftOpinions :
      bias == Bias.center ? cetnerOptions :
      rightOpinions
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                     true ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
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
                    children: [
                      _buildTabViewPage(
                        bias: Bias.left,
                        text: issue.leftSummary,
                        keywords: issue.leftKeywords,
                      ),
                      _buildTabViewPage(
                        bias: Bias.center,
                        text: issue.centerSummary,
                        keywords: issue.centerKeywords,
                      ),
                      _buildTabViewPage(
                        bias: Bias.right,
                        text: issue.rightSummary,
                        keywords: issue.rightKeywords,
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

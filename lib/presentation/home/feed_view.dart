import 'package:could_be/data/repositoryImpl/issues_repository_impl.dart';
import 'package:could_be/presentation/issue_list_view/issue_type.dart';
import 'package:could_be/presentation/issue_list_view/roots/issue_list_root.dart';
import '../../../core/components/chips/issue_chip.dart';
import '../../../core/components/daily_issue_feed.dart';
import '../../../domain/entities/issues.dart';
import '../../../ui/fonts.dart';
import '../../../ui/color.dart';
import 'package:flutter/material.dart';
import '../../core/di/api.dart';
import '../themes/margins_paddings.dart';
import '../views/loading_view.dart';

class FeedView extends StatefulWidget {
  const FeedView({super.key});

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> with TickerProviderStateMixin {
  late final TabController tabController = TabController(
    length: 5,
    vsync: this,
  );
  late final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  List<String> issueCategories = [
    '데일리 이슈',
    '추천 이슈',
    '보수 사각지대',
    '진보 사각지대',
    '경제',
  ];
  late List<bool> issueActive = List.generate(
    issueCategories.length,
    (index) => index == 0,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: AppColors.background,
          child: Container(
            height: 50,
            padding: EdgeInsets.symmetric(vertical: MyPaddings.small),
            child: StatefulBuilder(
              builder: (context, setChipState) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: scrollController,
                  padding: EdgeInsets.symmetric(horizontal: MyPaddings.large),
                  itemCount: issueCategories.length,
                  itemBuilder: (context, index) {
                    return IssueChip(
                      title: issueCategories[index],
                      isActive: issueActive[index],
                      onTap: () {
                        setChipState(() {
                          for (int i = 0; i < issueActive.length; i++) {
                            issueActive[i] = i == index;
                          }
                        });
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
        Expanded(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: MyPaddings.medium,
                          vertical: MyPaddings.small,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${DateTime.now().month}월 ${DateTime.now().day}일 이슈 Top5',
                            style: MyFontStyle.h1,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            for (int i = 0; i < 5; i++) DailyIssueFeed(),
                          ],
                        ),
                      ),
                      TabPageSelector(
                        controller: tabController,
                        color: AppColors.unselected,
                        selectedColor: AppColors.primary,
                        borderStyle: BorderStyle.none,
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: MyPaddings.large,
                    vertical: MyPaddings.small,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('데일리 이슈', style: MyFontStyle.h1),
                  ),
                ),
              ),
              IssueListRoot(issueType: IssueType.daily),
            ],
          ),
        ),
      ],
    );
  }
}

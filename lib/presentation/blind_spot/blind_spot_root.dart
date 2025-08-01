import 'package:could_be/core/components/app_bar/app_bar.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';
import '../issue_list/issue_type.dart';
import '../issue_list/main/issue_list_root.dart';

class BlindSpotRoot extends StatefulWidget {
  const BlindSpotRoot({super.key, required this.onIssueSelected});
  final void Function(String issueId) onIssueSelected;

  @override
  State<BlindSpotRoot> createState() => _BlindSpotRootState();
}

class _BlindSpotRootState extends State<BlindSpotRoot> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RegAppBar(
          title: '성향별 사각지대 이슈 보기',
          iconData: Icons.visibility_off,
        ),
        
        // 이슈 리스트 (탭바와 설명 박스가 내부에 포함됨)
        Expanded(
          child: Stack(
            children: [
              TabBarView(
                controller: _tabController,
                children: [
                  IssueListRoot(
                    issueType: IssueType.blindSpotLeft,
                    upperWidget: _buildUpperSection(0),
                  ),
                  IssueListRoot(
                    issueType: IssueType.blindSpotRight,
                    upperWidget: _buildUpperSection(1),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: MyPaddings.extraLarge, vertical: MyPaddings.extraSmall),
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.gray5,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.gray2.withOpacity(0.1),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildTabItem(
                            '진보 사각지대',
                            0,
                            AppColors.left,
                            Icons.trending_up,
                          ),
                        ),
                        Expanded(
                          child: _buildTabItem(
                            '보수 사각지대',
                            1,
                            AppColors.right,
                            Icons.account_balance,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  // 탭바와 설명 카드를 포함하는 상단 섹션
  Widget _buildUpperSection(int index) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: MyPaddings.large, vertical: MyPaddings.large),
      margin: EdgeInsets.only(bottom: MyPaddings.large),
      padding: EdgeInsets.all(MyPaddings.large),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: index == 0
              ? [AppColors.left.withOpacity(0.1), AppColors.left.withOpacity(0.05)]
              : [AppColors.right.withOpacity(0.1), AppColors.right.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        // borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: index == 0
              ? AppColors.left.withOpacity(0.3)
              : AppColors.right.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(MyPaddings.medium),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              index == 0 ? Icons.trending_up : Icons.account_balance,
              color: index == 0 ? AppColors.left : AppColors.right,
              size: 28,
            ),
          ),
          SizedBox(width: MyPaddings.large),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  index == 0
                      ? '진보 언론이 잘 안다루는 이슈'
                      : '보수 언론이 잘 안다루는 이슈',
                  style: MyFontStyle.h2.copyWith(
                    color: index == 0 ? AppColors.left : AppColors.right,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: MyPaddings.small),
                Text(
                  index == 0
                      ? '보수 언론에서 주로 다루는 이슈들을 확인하세요'
                      : '진보 언론에서 주로 다루는 이슈들을 확인하세요',
                  style: MyFontStyle.small.copyWith(
                    color: AppColors.gray2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  
  Widget _buildTabItem(String label, int index, Color color, IconData icon) {
    final isSelected = _tabController.index == index;
    
    return GestureDetector(
      onTap: () {
        _tabController.animateTo(index);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: MyPaddings.large,
          vertical: MyPaddings.medium,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.2),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? color : AppColors.gray3,
              size: 18,
            ),
            SizedBox(width: MyPaddings.small),
            Text(
              label,
              style: MyFontStyle.reg.copyWith(
                color: isSelected ? color : AppColors.gray3,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}

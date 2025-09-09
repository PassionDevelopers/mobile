import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../themes/color.dart';
import '../../themes/fonts.dart';
import '../../themes/margins_paddings.dart';
import '../../responsive/responsive_constants.dart';

class SideNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;
  final bool collapsed;

  const SideNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.collapsed = false,
  });

  @override
  State<SideNavigationBar> createState() => _SideNavigationBarState();
}

class _SideNavigationBarState extends State<SideNavigationBar>
    with TickerProviderStateMixin {
  late List<AnimationController> _animationControllers;
  late List<Animation<double>> _scaleAnimations;

  final List<SideNavItem> _items = [
    SideNavItem(
      icon: Icons.home_rounded,
      label: '홈',
    ),
    SideNavItem(
      icon: Icons.explore_rounded,
      label: '토픽',
    ),
    SideNavItem(
      icon: Icons.visibility_off,
      label: '사각지대',
    ),
    SideNavItem(
      icon: Icons.article_rounded,
      label: '언론',
    ),
    SideNavItem(
      icon: Icons.account_circle_rounded,
      label: '마이페이지',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationControllers = List.generate(
      _items.length,
      (index) => AnimationController(
        duration: Duration(milliseconds: 200),
        vsync: this,
      ),
    );
    _scaleAnimations = _animationControllers
        .map((controller) => Tween<double>(
              begin: 1.0,
              end: 1.1,
            ).animate(CurvedAnimation(
              parent: controller,
              curve: Curves.elasticOut,
            )))
        .toList();

    if (widget.currentIndex < _animationControllers.length) {
      _animationControllers[widget.currentIndex].forward();
    }
  }

  @override
  void didUpdateWidget(SideNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      if (oldWidget.currentIndex < _animationControllers.length) {
        _animationControllers[oldWidget.currentIndex].reverse();
      }
      if (widget.currentIndex < _animationControllers.length) {
        _animationControllers[widget.currentIndex].forward();
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index != widget.currentIndex) {
      HapticFeedback.lightImpact();
      widget.onTap(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = widget.collapsed 
        ? ResponsiveBreakpoints.sidebarCollapsedWidth 
        : ResponsiveBreakpoints.sidebarWidth;

    return Container(
      width: width,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        border: Border(
          right: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          // 로고 영역
          Container(
            height: 80,
            padding: EdgeInsets.all(MyPaddings.large),
            child: widget.collapsed
                ? Icon(
                    Icons.menu,
                    color: AppColors.primary,
                    size: 24,
                  )
                : Image.asset(
                    'assets/images/logo/logo_black.jpeg',
                    height: 40,
                  ),
          ),
          
          // 네비게이션 아이템들
          Expanded(
            child: Column(
              children: List.generate(_items.length, (index) {
                final isSelected = index == widget.currentIndex;
                final item = _items[index];

                return AnimatedBuilder(
                  animation: _scaleAnimations[index],
                  builder: (context, child) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: MyPaddings.small,
                        vertical: MyPaddings.extraSmall,
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () => _onItemTapped(index),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            padding: EdgeInsets.symmetric(
                              horizontal: widget.collapsed ? MyPaddings.small : MyPaddings.large,
                              vertical: MyPaddings.medium,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary.withOpacity(0.1)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                              border: isSelected
                                  ? Border.all(
                                      color: AppColors.primary.withOpacity(0.3),
                                      width: 1,
                                    )
                                  : null,
                            ),
                            child: Row(
                              children: [
                                Transform.scale(
                                  scale: _scaleAnimations[index].value,
                                  child: Icon(
                                    item.icon,
                                    size: 24,
                                    color: isSelected
                                        ? AppColors.primary
                                        : AppColors.textSecondary,
                                  ),
                                ),
                                if (!widget.collapsed) ...[
                                  SizedBox(width: MyPaddings.medium),
                                  Expanded(
                                    child: AnimatedDefaultTextStyle(
                                      duration: Duration(milliseconds: 200),
                                      style: MyFontStyle.reg.copyWith(
                                        color: isSelected
                                            ? AppColors.primary
                                            : AppColors.textSecondary,
                                        fontWeight: isSelected
                                            ? FontWeight.w600
                                            : FontWeight.w400,
                                      ),
                                      child: Text(
                                        item.label,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class SideNavItem {
  final IconData icon;
  final String label;

  SideNavItem({
    required this.icon,
    required this.label,
  });
}
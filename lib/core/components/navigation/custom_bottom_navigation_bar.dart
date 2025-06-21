import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../ui/color.dart';
import '../../../ui/fonts.dart';
import '../../themes/margins_paddings.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar>
    with TickerProviderStateMixin {
  late List<AnimationController> _animationControllers;
  late List<Animation<double>> _scaleAnimations;

  final List<BottomNavItem> _items = [
    BottomNavItem(
      icon: Icons.home_rounded,
      label: '홈',
    ),
    BottomNavItem(
      icon: Icons.explore_rounded,
      label: '토픽',
    ),
    BottomNavItem(
      icon: Icons.visibility_off,
      label: '사각지대',
    ),
    BottomNavItem(
      icon: Icons.article_rounded,
      label: '매체',
    ),
    BottomNavItem(
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
              end: 1.2,
            ).animate(CurvedAnimation(
              parent: controller,
              curve: Curves.elasticOut,
            )))
        .toList();

    // Animate the initially selected item
    if (widget.currentIndex < _animationControllers.length) {
      _animationControllers[widget.currentIndex].forward();
    }
  }

  @override
  void didUpdateWidget(CustomBottomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      // Reset previous animation
      if (oldWidget.currentIndex < _animationControllers.length) {
        _animationControllers[oldWidget.currentIndex].reverse();
      }
      // Start new animation
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
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(_items.length, (index) {
          final isSelected = index == widget.currentIndex;
          final item = _items[index];

          return Expanded(
            child: GestureDetector(
              onTap: () => _onItemTapped(index),
              child: AnimatedBuilder(
                animation: _scaleAnimations[index],
                builder: (context, child) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: MyPaddings.small),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Icon container with gradient background when selected
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: isSelected? AppColors.primary : null,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: AppColors.primary.withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                    ),
                                  ]
                                : [],
                          ),
                          child: Transform.scale(
                            scale: _scaleAnimations[index].value,
                            child: Icon(
                              item.icon,
                              size: 24,
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        // Label
                        AnimatedDefaultTextStyle(
                          duration: Duration(milliseconds: 200),
                          style: MyFontStyle.small.copyWith(
                            color: isSelected
                                ? AppColors.textPrimary
                                : AppColors.textSecondary,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w400,
                            fontSize: isSelected ? 11 : 10,
                          ),
                          child: Text(
                            item.label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}

class BottomNavItem {
  final IconData icon;
  final String label;

  BottomNavItem({
    required this.icon,
    required this.label,
  });
}
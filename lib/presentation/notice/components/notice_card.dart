import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/domain/entities/notice.dart';
import 'package:could_be/presentation/notice/notice_dialog/notice_dialog.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoticeCard extends StatefulWidget {
  final Notice notice;

  const NoticeCard({
    super.key,
    required this.notice,
  });

  @override
  State<NoticeCard> createState() => _NoticeCardState();
}

class _NoticeCardState extends State<NoticeCard> with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 200),
  );
  
  late final Animation<double> _scaleAnimation = Tween<double>(
    begin: 1.0,
    end: 0.98,
  ).animate(
    CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
  );

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      return '오늘';
    } else if (difference.inDays == 1) {
      return '어제';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}일 전';
    } else {
      return DateFormat('yyyy.MM.dd').format(date);
    }
  }

  void _showNoticeDialog() async{
    showDialog(
      context: context,
      builder: (context){
        return NoticeDialog(notice: widget.notice);
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MyPaddings.large,
        vertical: MyPaddings.small,
      ),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: GestureDetector(
              onTapDown: (_) => _animationController.forward(),
              onTapUp: (_) {
                _animationController.reverse();
                _showNoticeDialog();
              },
              onTapCancel: () => _animationController.reverse(),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: widget.notice.isImportant
                      ? Border.all(
                          color: AppColors.warning.withOpacity(0.3),
                          width: 2,
                        )
                      : null,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.gray400,
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(MyPaddings.large),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.notice.isImportant)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: MyPaddings.small,
                                vertical: MyPaddings.extraSmall,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.warning,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: MyText.small(
                                '중요',
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          if (widget.notice.isImportant)
                            SizedBox(width: MyPaddings.small),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText.h3(
                                  widget.notice.title,
                                ),
                                SizedBox(height: MyPaddings.small),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      size: 14,
                                      color: AppColors.textTertiary,
                                    ),
                                    SizedBox(width: MyPaddings.extraSmall),
                                    MyText.small(
                                      _formatDate(widget.notice.createdAt),
                                      color: AppColors.textTertiary,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: AppColors.textTertiary,
                            size: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
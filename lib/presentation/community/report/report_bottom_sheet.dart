import 'package:could_be/core/components/alert/snack_bar.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/data/repositoryImpl/report_repository_impl.dart';
import 'package:could_be/domain/useCases/report_use_case.dart';
import 'package:flutter/material.dart';
import '../../../core/themes/margins_paddings.dart';
import '../../../domain/repositoryInterfaces/report_interface.dart';
import '../../../ui/color.dart';
import '../../../ui/fonts.dart';

class ReportBottomSheet extends StatefulWidget {
  final String? commentId;
  final String? issueId;
  final String? userId;
  final VoidCallback onReportSuccess;

  const ReportBottomSheet({
    super.key,
    required this.onReportSuccess,
    this.commentId,
    this.issueId,
    this.userId,
  });

  @override
  State<ReportBottomSheet> createState() => _ReportBottomSheetState();
}

class _ReportBottomSheetState extends State<ReportBottomSheet> {
  ReportCategory _selectedCategory = ReportCategory.comment;
  final ReportUseCase reportUseCase = getIt<ReportUseCase>();

  dynamic _selectedReason;

  @override
  void initState() {
    super.initState();
    
    if (widget.commentId != null) {
      _selectedCategory = ReportCategory.comment;
    } else if (widget.issueId != null) {
      _selectedCategory = ReportCategory.issue;
    } else if (widget.userId != null) {
      _selectedCategory = ReportCategory.user;
    }
  }

  List<dynamic> get _currentReasons {
    switch (_selectedCategory) {
      case ReportCategory.user:
        return UserReportReason.values;
      case ReportCategory.issue:
        return IssueReportReason.values;
      case ReportCategory.comment:
        return CommentReportReason.values;
    }
  }

  String _getReasonText(dynamic reason) {
    if (reason is UserReportReason) {
      return reason.value;
    } else if (reason is IssueReportReason) {
      return reason.value;
    } else if (reason is CommentReportReason) {
      return reason.value;
    }
    return '';
  }

  String _getReasonString(dynamic reason) {
    if (reason is UserReportReason) {
      return reason.value;
    } else if (reason is IssueReportReason) {
      return reason.value;
    } else if (reason is CommentReportReason) {
      return reason.value;
    }
    return '';
  }

  String _getCategoryText(ReportCategory category) {
    switch (category) {
      case ReportCategory.user:
        return '사용자';
      case ReportCategory.issue:
        return '이슈';
      case ReportCategory.comment:
        return '댓글';
    }
  }

  bool get _canReport {
    return _selectedReason != null;
  }

  void _onReport() {
    if (!_canReport) return;

    reportUseCase.report(
      contentId: widget.commentId ?? widget.issueId ?? widget.userId ?? '',
      contentType: _selectedCategory.name,
      reason: _getReasonString(_selectedReason),
    );
    widget.onReportSuccess();
    showSnackBar(context, msg: '신고가 접수되었습니다.');
    
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(top: MyPaddings.small),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.gray4,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(MyPaddings.large),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText.reg(
                          '${_getCategoryText(_selectedCategory)} 신고하기',
                          fontWeight: FontWeight.bold,
                        ),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: Icon(Icons.close, color: AppColors.gray2),
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                        ),
                      ],
                    ),
                    
                    const Divider(),
                
                    MyText.reg(
                      '문제점을 선택해주세요',
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                
                    SizedBox(height: MyPaddings.medium),
                
                    Column(
                      children: _currentReasons.map((reason) {
                        final isSelected = _selectedReason == reason;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedReason = reason;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: MyPaddings.small),
                            padding: EdgeInsets.all(MyPaddings.medium),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.primary.withOpacity(0.05) : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSelected ? AppColors.primary : AppColors.gray4,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected ? AppColors.primary : AppColors.gray3,
                                      width: 2,
                                    ),
                                    color: isSelected ? AppColors.primary : Colors.transparent,
                                  ),
                                  child: isSelected
                                      ? Center(
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                      : null,
                                ),
                                SizedBox(width: MyPaddings.medium),
                                Expanded(
                                  child: MyText.reg(
                                    _getReasonText(reason),
                                    color: isSelected ? AppColors.primary : AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                
                    SizedBox(height: MyPaddings.large),
                
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _canReport ? _onReport : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _canReport ? AppColors.primary : AppColors.gray4,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: MyPaddings.medium),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: MyText.reg(
                          '신고하기',
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
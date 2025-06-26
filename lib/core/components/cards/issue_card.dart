import 'package:could_be/core/components/bias/bias_enum.dart';
import 'package:could_be/core/components/title/issue_info_title.dart';
import 'package:could_be/ui/color_styles.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/entities/issue.dart';
import '../../../ui/color.dart';
import '../../themes/margins_paddings.dart';
import '../bias/bias_bar.dart';
import '../chips/blind_chip.dart';
import '../chips/key_word_chip_component.dart';

class IssueCard extends StatefulWidget {
  final Issue issue;
  final bool isDailyIssue;

  const IssueCard({super.key, required this.issue, required this.isDailyIssue});

  @override
  State<IssueCard> createState() => _IssueCardState();
}

class _IssueCardState extends State<IssueCard> with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 200),
  );
  late final Animation<double> _scaleAnimation = Tween<double>(
    begin: 1.0,
    end: 1.05,
  ).animate(
    CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
  );

  getBlindChip(){
    if( (widget.issue.coverageSpectrum.left + widget.issue.coverageSpectrum.centerLeft)
        < (widget.issue.coverageSpectrum.right + widget.issue.coverageSpectrum.centerRight) / 2){
      return BlindChip(bias: Bias.left,);
    } else if( (widget.issue.coverageSpectrum.left + widget.issue.coverageSpectrum.centerLeft)/2
        > (widget.issue.coverageSpectrum.right + widget.issue.coverageSpectrum.centerRight) ){
      return BlindChip(bias: Bias.right,);
    }else{
      return BlindChip(bias: Bias.center,);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(MyPaddings.largeMedium, 0, MyPaddings.largeMedium,
          widget.isDailyIssue? 0 : MyPaddings.large),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: GestureDetector(
              onTapDown: (_) => _animationController.forward(),
              onTapUp: (_) {
                _animationController.reverse();
                context.push('/shortsView/${widget.issue.id}');
              },
              onTapCancel: () => _animationController.reverse(),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  context.push('/shortsView/${widget.issue.id}');
                },
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.primaryLight,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.issue.imageUrl != null && widget.isDailyIssue)
                        Container(
                          height: 180,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                            child: Image.network(
                              widget.issue.imageUrl!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          MyPaddings.large,
                          MyPaddings.medium,
                          MyPaddings.large,
                          MyPaddings.large,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                getBlindChip(),
                                SizedBox(width: MyPaddings.small),
                                Expanded(child: MyText.h2(widget.issue.title, maxLines: 2,)),
                              ],
                            ),
                            SizedBox(height: MyPaddings.small),
                            MyText.reg(
                              widget.issue.summary,
                              color: AppColors.gray2,
                              maxLines: 3,
                            ),
                            SizedBox(height: MyPaddings.medium),
                            SizedBox(
                              height: 26,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (_, index) {
                                  return KeyWordChip(
                                    title: widget.issue.keywords[index],
                                  );
                                },
                                itemCount: widget.issue.keywords.length,
                                shrinkWrap: true,
                              ),
                            ),
                            // Bias Bar
                            SizedBox(height: MyPaddings.medium),
                            CardBiasBar(
                              isDailyIssue: widget.isDailyIssue,
                              coverageSpectrum: widget.issue.coverageSpectrum,
                            ),
                            SizedBox(height: MyPaddings.medium),
                           IssueInfoTitle(
                              mediaTotal: widget.issue.coverageSpectrum.total,
                              viewCount: widget.issue.view,
                              time: widget.issue.createdAt,
                            ),
                          ],
                        ),
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

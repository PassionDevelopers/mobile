import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';

class BiasCheckButton extends StatefulWidget {
  const BiasCheckButton({
    super.key,
    required this.userEvaluation,
    required this.onBiasSelected,
    required this.leftLikeCount,
    required this.centerLikeCount,
    required this.rightLikeCount,
    required this.isEvaluating,
    required this.existLeft,
    required this.existCenter,
    required this.existRight,
  });

  final String? userEvaluation;
  final int leftLikeCount;
  final int centerLikeCount;
  final int rightLikeCount;
  final bool isEvaluating;
  final bool existLeft;
  final bool existCenter;
  final bool existRight;
  final void Function(Bias bias) onBiasSelected;

  @override
  State<BiasCheckButton> createState() => _BiasCheckButtonState();
}

class _BiasCheckButtonState extends State<BiasCheckButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.00).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // userEvaluation이 null일 때만 애니메이션 시작
    if (widget.userEvaluation == null) {
      _animationController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(BiasCheckButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    // userEvaluation 상태 변경 시 애니메이션 제어
    if (widget.userEvaluation == null && oldWidget.userEvaluation != null) {
      _animationController.repeat(reverse: true);
    } else if (widget.userEvaluation != null &&
        oldWidget.userEvaluation == null) {
      _animationController.stop();
      _animationController.animateTo(1.0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  _buildBiasCircle(Bias bias) {
    return Column(
      children: [
        MyText.reg(getBiasName(bias), color: getBiasColor(bias)),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MyPaddings.small,
            // vertical: MyPaddings.small,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: () {
              if (!widget.isEvaluating) widget.onBiasSelected(bias);
            },
            child: Ink(
              height: 50,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: getBiasColor(bias)),
              ),
              child: Center(
                child: Icon(Icons.check, color: getBiasColor(bias)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildBiasRect(Bias bias) {
    int total =
        widget.leftLikeCount + widget.centerLikeCount + widget.rightLikeCount;
    bool isSelected = widget.userEvaluation == bias.toPerspective();
    return Column(
      children: [
        MyText.reg(getBiasName(bias), color: getBiasColor(bias)),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MyPaddings.small,
            vertical: MyPaddings.small,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: () {
              if (!widget.isEvaluating) widget.onBiasSelected(bias);
            },
            child: Ink(
              height: 50,
              width: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  stops: [
                    0,
                    switch (bias) {
                      Bias.left => widget.leftLikeCount / total,
                      Bias.center => widget.centerLikeCount / total,
                      _ => widget.rightLikeCount / total,
                    },
                    switch (bias) {
                      Bias.left => widget.leftLikeCount / total,
                      Bias.center => widget.centerLikeCount / total,
                      _ => widget.rightLikeCount / total,
                    },
                    1.0,
                  ],
                  colors: [
                    getBiasColor(bias).withOpacity(0.2),
                    getBiasColor(bias).withOpacity(0.2),
                    AppColors.primaryLight,
                    AppColors.primaryLight,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: getBiasColor(bias)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check,
                    color: isSelected ? getBiasColor(bias) : AppColors.gray3,
                  ),
                  SizedBox(width: MyPaddings.small),
                  MyText.reg(switch (bias) {
                    Bias.left => widget.leftLikeCount.toString(),
                    Bias.right => widget.rightLikeCount.toString(),
                    _ => widget.centerLikeCount.toString(),
                  }, color: isSelected ? getBiasColor(bias) : AppColors.gray3),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ValueNotifier(widget.userEvaluation),
      builder: (context, listenable) {
        return AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Ink(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: myShadow
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MyPaddings.medium,
                  ),
                  child: Column(
                    children: [
                      widget.userEvaluation == null
                          ? MyText.h3('어떤 관점에 동의하시나요?')
                          : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyText.h3('내가 동의한 관점 : '),
                          MyText.h3(
                            getBiasName(
                              getBiasFromString(widget.userEvaluation!),
                            ),
                            color: getBiasColor(
                              getBiasFromString(widget.userEvaluation!),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MyPaddings.medium),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (widget.existLeft)
                            _buildBiasRect(Bias.left),
                          if (widget.existCenter)
                            _buildBiasRect(Bias.center),
                          if (widget.existRight)
                            _buildBiasRect(Bias.right),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        );
      },
    );
  }
}

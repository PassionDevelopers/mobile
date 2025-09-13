import 'dart:developer';

import 'package:could_be/core/components/alert/toast.dart';
import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:flutter/material.dart';

class BiasCheckButton extends StatefulWidget {
  const BiasCheckButton({
    super.key,
    this.draggableScrollableController,
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

  final DraggableScrollableController? draggableScrollableController;
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

class _BiasCheckButtonState extends State<BiasCheckButton> {
  _buildBiasRect(Bias bias) {
    int total =
        widget.leftLikeCount + widget.centerLikeCount + widget.rightLikeCount;
    bool isSelected = widget.userEvaluation == bias.toPerspective();
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: () {
          if (!widget.isEvaluating) widget.onBiasSelected(bias);
        },
        child: Ink(
          height: 36,
          width: double.infinity,
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
                AppColors.white,
                AppColors.white,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: isSelected ? getBiasColor(bias) : AppColors.gray400,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isSelected)
                Icon(Icons.check, size: 16, color: getBiasColor(bias)),
              MyText.reg(getBiasName(bias), color: getBiasColor(bias)),
              SizedBox(width: MyPaddings.small),
              MyText.reg(switch (bias) {
                Bias.left => widget.leftLikeCount.toString(),
                Bias.right => widget.rightLikeCount.toString(),
                _ => widget.centerLikeCount.toString(),
              }, color: isSelected ? getBiasColor(bias) : AppColors.gray500),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.draggableScrollableController != null) {
      widget.draggableScrollableController!.addListener(() {
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ValueNotifier(widget.userEvaluation),
      builder: (context, listenable) {
        return Material(
          color: AppColors.white,
          shadowColor: AppColors.black,
          elevation: 30,
          child: Ink(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border(top: BorderSide(color: AppColors.gray300)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black,
                  blurRadius: 10,
                  offset: Offset(0, -4),
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: MyPaddings.medium),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 40),
                      Spacer(),
                      Row(
                        children:
                            widget.userEvaluation == null
                                ? [
                                  MyText.reg(
                                    '어떤 관점에 동의하시나요?',
                                    color: AppColors.gray700,
                                  ),
                                ]
                                : [
                                  MyText.reg(
                                    '내가 동의한 관점 : ',
                                    color: AppColors.gray700,
                                  ),
                                  MyText.reg(
                                    getBiasName(
                                      getBiasFromString(widget.userEvaluation!),
                                    ),
                                    color: getBiasColor(
                                      getBiasFromString(widget.userEvaluation!),
                                    ),
                                  ),
                                ],
                      ),
                      Spacer(),
                      if (widget.draggableScrollableController != null)
                        GestureDetector(
                          onTap: () {
                            if (widget.draggableScrollableController!.size <
                                0.5) {
                              widget.draggableScrollableController!.animateTo(
                                1,
                                duration: Duration(milliseconds: 200),
                                curve: Curves.ease,
                              );
                            } else {
                              widget.draggableScrollableController!.animateTo(
                                0,
                                duration: Duration(milliseconds: 200),
                                curve: Curves.ease,
                              );
                            }
                          },
                          child: Icon(
                            widget.draggableScrollableController!.size < 0.5
                                ? Icons.keyboard_arrow_up_rounded
                                : Icons.keyboard_arrow_down_rounded,
                            size: 24,
                            color: AppColors.gray400,
                          ),
                        ),
                      SizedBox(width: 16),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 16),
                      if (widget.existLeft) _buildBiasRect(Bias.left),
                      if (widget.existLeft) SizedBox(width: 12),
                      if (widget.existCenter) _buildBiasRect(Bias.center),
                      if (widget.existCenter) SizedBox(width: 12),
                      if (widget.existRight) _buildBiasRect(Bias.right),
                      SizedBox(width: 16),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

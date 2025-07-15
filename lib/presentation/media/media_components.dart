import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/domain/entities/article.dart';
import 'package:could_be/domain/entities/source.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';

import '../../core/components/bias/bias_enum.dart';
import 'media_profile_component.dart';

class MediaChatBubble extends StatefulWidget {
  const MediaChatBubble({
    super.key,
    required this.articles,
    required this.toWebView,
  });

  final List<Article> articles;
  final void Function(String articleId) toWebView;

  @override
  State<MediaChatBubble> createState() => _MediaChatBubbleState();
}

class _MediaChatBubbleState extends State<MediaChatBubble> {
  bool isExpanded = false;

  Widget expandButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(right: 8),
        child: InkWell(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          borderRadius: BorderRadius.circular(8),
          child: Ink(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.gray5,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyText.reg(
                  isExpanded? '기사 접기' :
                  '외 ${widget.articles.length - 1}개 기사',
                  color: AppColors.gray2,
                ),
                Icon(
                  isExpanded? Icons.keyboard_double_arrow_up_rounded :
                  Icons.keyboard_double_arrow_down_rounded,
                  color: AppColors.gray2,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bubbleContent(Article article, Bias bias) {
    return GestureDetector(
      onTap: (){
        widget.toWebView(article.id);
      },
      child: BubbleSpecialThree(
        text: article.title,
        isSender: false,
        color: getBiasColor(bias).withAlpha(80),
        // color: getBiasColor(bias),
        textStyle: TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontStyle: FontStyle.italic,
          // fontWeight: FontWeight.bold,
          // overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Bias bias = widget.articles.first.source.bias;
    final Source source = widget.articles.first.source;
    return Padding(
      padding: EdgeInsets.only(bottom: MyPaddings.medium),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MediaProfileRef(source: source),
              Expanded(
                child: bubbleContent(widget.articles.first, bias)
              ),
            ],
          ),
          isExpanded
              ? Column(
                children: [
                  Column(
                    children:
                        widget.articles.sublist(1).map((article) {
                          return Padding(
                            padding: EdgeInsets.only(left: 60, ),
                            child: SizedBox(height: 82,
                                child: bubbleContent(article, bias))
                          );
                        }).toList(),
                  ),
                  expandButton()
                ],
              )
              : widget.articles.length > 1
              ? expandButton()
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

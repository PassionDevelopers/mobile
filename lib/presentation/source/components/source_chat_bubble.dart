import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/domain/entities/article/article.dart';
import 'package:could_be/domain/entities/source/source.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:could_be/presentation/source/components/media_profile_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../core/method/bias/bias_enum.dart';

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
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyText.small(
                  isExpanded? '기사 접기' :
                  '외 ${widget.articles.length - 1}개 기사 더보기',
                  color: AppColors.gray400,
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }

  Widget bubbleContent(Article article, Bias bias) {
    return InkWell(
      onTap: (){
        widget.toWebView(article.id);
      },
      borderRadius: BorderRadius.circular(6),
      child: Ink(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.gray50,
          borderRadius: BorderRadius.circular(6)
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 6,
          children: [
            SvgPicture.asset('assets/images/icon/Link.svg', width: 16, height: 16,),
            Expanded(child: MyText.reg(
              article.title,
              color: AppColors.black,
              maxLines: 2,
            ))
          ],
        ),
      )
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
          MediaProfileRef(source: source, toDetailPage: (){
            context.push(RouteNames.mediaDetail, extra: source.id);
          },),
          bubbleContent(widget.articles.first, bias),
          isExpanded
              ? Column(
                children: [
                  Column(
                    children:
                        widget.articles.sublist(1).map((article) {
                          return Column(
                            children: [
                              SizedBox(height: MyPaddings.small,),
                              bubbleContent(article, bias),
                            ],
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

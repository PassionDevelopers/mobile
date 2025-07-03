import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/domain/entities/article.dart';
import 'package:could_be/domain/entities/source.dart';
import 'package:flutter/material.dart';

import '../../core/components/bias/bias_enum.dart';
import 'media_profile_component.dart';

class MediaChatBubble extends StatelessWidget {
  const MediaChatBubble({super.key,
    required this.article,
    required this.toWebView,
  });
  final Article article;
  final VoidCallback toWebView;

  @override
  Widget build(BuildContext context) {

    final Bias bias = getBiasFromString(article.source.perspective);
    final Source source = article.source;
    return GestureDetector(
      onTap: toWebView,
      child: Padding(
        padding: EdgeInsets.only(bottom: MyPaddings.medium),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(
            //     width: 40,
            //     child: ProfileCircle(bias: bias, name: source.name)),
            MediaProfileRef(source: source),
            Expanded(
              child: BubbleSpecialThree(
                text: article.title,
                isSender: false,
                color: getBiasColor(bias).withAlpha(80),
                // color: getBiasColor(bias),
                textStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  // fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  // overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




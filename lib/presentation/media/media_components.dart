import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:flutter/material.dart';
import '../../ui/color.dart';
import '../../core/components/bias/bias_enum.dart';
import 'media_profile_component.dart';

class MediaChatBubble extends StatelessWidget {
  const MediaChatBubble({super.key, required this.news});
  final Map<String, String> news;

  getBias(){
    switch (news['orientation']) {
      case 'left':
        return Bias.left;
      case 'leftCenter':
        return Bias.leftCenter;
      case 'right':
        return Bias.right;
      case 'rightCenter':
        return Bias.rightCenter;
      default:
        return Bias.center;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color cardColor;

    switch (news['orientation']) {
      case 'left':
        cardColor = AppColors.leftCenter;
        break;
      case 'right':
        cardColor = AppColors.rightCenter;
        break;
      default:
        cardColor = Colors.grey.shade200;
    }

    return GestureDetector(
      onTap: () {
        // Handle tap event
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: Text(news['title']!),
            content: Text('원문 링크로 이동'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('닫기'),
              ),
            ],
          );
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: 40,
                child: ProfileCircle(bias: getBias(),
                    name: news['channel']!)),
            // Flexible(
            //   child: Center(
            //     child: BubbleSpecialOne(
            //       text: news['title']!,
            //       isSender: false,
            //       color: cardColor,
            //       textStyle: TextStyle(
            //         fontSize: 14,
            //         color: Colors.black,
            //         fontStyle: FontStyle.italic,
            //         fontWeight: FontWeight.bold,
            //         overflow: TextOverflow.ellipsis,
            //       ),
            //     ),
            //   ),
            // ),
            Expanded(
              child: BubbleSpecialOne(
                text: news['title']!,
                isSender: false,
                color: cardColor,
                textStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Icon(Icons.link, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class MediaNews extends StatelessWidget {
  const MediaNews({super.key, required this.news});
  final List<Map<String, String>> news;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: news.length,
      itemBuilder: (context, index) {
        return MediaChatBubble(
          news: news[index],
        );
      },
    );
  }
}




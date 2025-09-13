import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/presentation/setting/notification_setting_view_model.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:flutter/material.dart';

class NotificationSettingView extends StatelessWidget {
  NotificationSettingView({super.key});

  final viewModel = getIt<NotificationSettingViewModel>();

  Widget buildNotificationOption(String title, String description, bool value, NotificationType type) {
    return SwitchListTile(
      title: MyText.h2(title),
      subtitle: MyText.articleSmall(description),
      value: value,
      onChanged: (value){viewModel.updateNotificationSetting(type);},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      backgroundColor: AppColors.white,
      insetPadding: EdgeInsets.fromLTRB(10, 30, 10, 30),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListenableBuilder(
            listenable: viewModel,
            builder: (context, _) {
              final state = viewModel.state;
              return Column(
                children: [
                  buildNotificationOption('알림 설정', '알림 권한을 허용', state.isEnabled, NotificationType.isEnabled),
                  AbsorbPointer(
                    absorbing: !state.isEnabled,
                    child: Opacity(
                      opacity: state.isEnabled ? 1.0 : 0.3,
                      child: Column(
                        children: [
                          buildNotificationOption('댓글 좋아요 알림', '작성한 댓글에 좋아요가 추가되면 알림', state.notifications.commentLikeEnabled, NotificationType.commentLike),
                          buildNotificationOption('답글 알림', '작성한 댓글에 답글이 달리면 알림', state.notifications.commentReplyEnabled, NotificationType.commentReply),
                          buildNotificationOption('대표 의견 알림', '작성한 댓글이 대표 의견으로 승급되면 알림', state.notifications.majorCommentEnabled, NotificationType.majorComment),
                          buildNotificationOption('관심 이슈 알림', '구독한 이슈에 새로운 대표 의견이 달리면 알림', state.notifications.issueSubscriptionEnabled, NotificationType.issueSubscription),
                          buildNotificationOption('관심 언론 알림', '구독한 언론에 새 기사가 등록되면 알림', state.notifications.mediaSubscriptionEnabled, NotificationType.mediaSubscription),
                          buildNotificationOption('관심 토픽 알림', '구독한 토픽에 새 이슈가 등록되면 알림', state.notifications.topicSubscriptionEnabled, NotificationType.topicSubscription),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}

// "commentLikeEnabled": true,
// "commentReplyEnabled": true,
// "majorCommentEnabled": true,
// "issueSubscriptionEnabled": true,
// "mediaSubscriptionEnabled": true,
// "topicSubscriptionEnabled": true

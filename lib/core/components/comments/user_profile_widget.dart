
import 'package:could_be/domain/entities/user/user_profile.dart';
import 'package:flutter/material.dart';
import '../../themes/color.dart';
import '../../themes/fonts.dart';

class UserProfileWidget extends StatelessWidget {
  final UserProfile userProfile;
  final double size;

  const UserProfileWidget({
    super.key,
    required this.userProfile,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: size / 2,
          backgroundColor: AppColors.gray4,
          backgroundImage: userProfile.imageUrl != null
              ? NetworkImage(userProfile.imageUrl!)
              : null,
          child: userProfile.imageUrl == null
              ? Icon(
                  Icons.person,
                  color: AppColors.gray2,
                  size: size * 0.6,
                )
              : null,
        ),
        SizedBox(width: 8),
        MyText.reg(
          userProfile.nickname,
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}
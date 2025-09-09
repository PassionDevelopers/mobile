import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/domain/entities/user/user_profile.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileFrame extends StatelessWidget {
  const ProfileFrame({
    super.key,
    required this.width,
    required this.bias,
    required this.child,
  });

  final double width;
  final Bias? bias;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width,
      decoration: BoxDecoration(
        border: Border.all(
          color: bias == null ? AppColors.gray3 : getBiasColor(bias!),
          width: 2,
        ),
        shape: BoxShape.circle,
        color: AppColors.gray5,
      ),
      child: ClipOval(child: child),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key, required this.width, required this.userProfile});

  final double width;
  final UserProfile? userProfile;

  @override
  Widget build(BuildContext context) {
    return ProfileFrame(
      width: width,
      bias: userProfile?.bias,
      child:
          userProfile == null
              ? const SizedBox()
              : userProfile!.imageUrl != null
              ? CachedNetworkImage(imageUrl: userProfile!.imageUrl!, fit: BoxFit.cover)
              : Icon(Icons.person, size: width * 0.6, color: AppColors.gray3),
    );
  }
}

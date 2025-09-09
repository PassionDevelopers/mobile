import '../../../core/method/bias/bias_enum.dart';

class UserProfile{
  final String? userId;
  final Bias bias;
  final String nickname;
  final String? imageUrl;

  UserProfile({
    required this.userId,
    required this.bias,
    required nickname,
    required this.imageUrl
  }) : nickname = nickname ?? '(탈퇴한 사용자)';

  UserProfile copyWith({
    Bias? bias,
    String? nickname,
    String? imageUrl,
    bool? clearImage,
  }){
    return UserProfile(
      userId: userId,
      bias: bias ?? this.bias,
      nickname: nickname ?? this.nickname,
      imageUrl: clearImage == true? null : (imageUrl ?? this.imageUrl),
    );
  }

}
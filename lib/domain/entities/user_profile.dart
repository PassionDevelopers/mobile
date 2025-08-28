import '../../core/method/bias/bias_enum.dart';

class UserProfile{
  final String id;
  final Bias bias;
  final String nickname;
  final String? imageUrl;

  UserProfile({
    required this.id,
    required this.bias, required this.nickname, required this.imageUrl
  });

  UserProfile copyWith({
    String? id,
    Bias? bias,
    String? nickname,
    String? imageUrl,
    bool? clearImage,
  }){
    return UserProfile(
      id: id ?? this.id,
      bias: bias ?? this.bias,
      nickname: nickname ?? this.nickname,
      imageUrl: clearImage == true? null : (imageUrl ?? this.imageUrl),
    );
  }

}
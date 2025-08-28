import 'package:could_be/core/domain/nick_name_error.dart';
import 'package:could_be/core/domain/result.dart';
import 'package:could_be/domain/entities/comment.dart';
import 'package:could_be/domain/entities/s3_upload_url.dart';
import 'package:could_be/domain/entities/user_profile.dart';

abstract class ManageUserProfileRepository {

  Future<UserProfile> fetchUserProfile();

  Future<S3UploadUrl> getS3UploadUrl(String mimeType);

  Future<void> deleteProfileImage();

  Future<String> commitStatus(String uploadKey);

  Future<Result<bool, NickNameError>> updateUserNickname(String nickname);
}
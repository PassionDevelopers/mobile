import 'dart:developer';
import 'dart:typed_data';

import 'package:could_be/core/domain/nick_name_error.dart';
import 'package:could_be/core/domain/result.dart';
import 'package:could_be/core/analytics/unified_analytics_helper.dart';
import 'package:could_be/core/analytics/analytics_event_names.dart';
import 'package:could_be/data/data_source/local/user_preferences.dart';
import 'package:could_be/domain/entities/comment.dart';
import 'package:could_be/domain/entities/s3_upload_url.dart';
import 'package:could_be/domain/entities/user_profile.dart';
import 'package:could_be/domain/repositoryInterfaces/manage_user_profile_interface.dart';
import 'package:http/http.dart' as http;

class ManageUserProfileUseCase {
  final ManageUserProfileRepository manageUserProfileRepository;

  ManageUserProfileUseCase(this.manageUserProfileRepository);

  Future<void> deleteUserProfileImage()async{
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.deleteUserProfileImage,
    );
    await manageUserProfileRepository.deleteProfileImage();
  }

  Future<UserProfile> fetchUserProfile() async {
    final result = await manageUserProfileRepository.fetchUserProfile();
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.fetchUserBias,
    );
    return result;
  }

  Future<String?> _uploadFileToS3({required S3UploadUrl s3UploadUrl, required Uint8List fileBytes, required String mimeType}) async {
    try {
      final response = await http.put(
        Uri.parse(s3UploadUrl.uploadUrl),
        headers: {
          'Content-Type': mimeType, // 파일 타입에 따라 조정
          'Content-Length': fileBytes.length.toString(),
        },
        body: fileBytes,
      );

      if (response.statusCode == 200) {
        final String imageUrl = await manageUserProfileRepository.commitStatus(s3UploadUrl.uploadKey);
        await UserPreferences.setUserProfileImageUrl(imageUrl);
        return imageUrl;
      } else {
        print('업로드 실패: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('업로드 에러: $e');
      return null;
    } finally {

    }
  }

  Future<String?> uploadProfileImage({required Uint8List uint8List, required String mimeType}) async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.uploadProfileImage,
      parameters: {
        'content_type': mimeType,
      },
    );
    try {
      S3UploadUrl s3uploadUrl = await manageUserProfileRepository.getS3UploadUrl(mimeType);
      try{
        final String? imageUrl = await _uploadFileToS3(s3UploadUrl: s3uploadUrl, fileBytes: uint8List, mimeType: mimeType);
        return imageUrl;
      } catch(e){
        log('Error during file upload to S3: $e');
        rethrow;
      }
    } catch (e) {
      log('Error uploading profile image: $e');
      rethrow;
    }
  }

  Future<Result<bool, NickNameError>> updateUserNickname(String name) async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.updateUserNickname,
      parameters: {
        'name_length': name.length.toString(),
      },
    );
    final result = await manageUserProfileRepository.updateUserNickname(name);
    return result;
  }
}
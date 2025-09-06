import 'package:could_be/core/di/api_versions.dart';
import 'package:could_be/core/domain/nick_name_error.dart';
import 'package:could_be/core/domain/result.dart';
import 'package:could_be/data/dto/s3_upload_url_dto.dart';
import 'package:could_be/data/dto/user_profile_dto.dart';
import 'package:could_be/domain/entities/s3_upload_url.dart';
import 'package:could_be/domain/entities/user_profile.dart';
import 'package:could_be/domain/repositoryInterfaces/user/manage_user_profile_interface.dart';
import 'package:dio/dio.dart';

class ManageUserProfileRepositoryImpl extends ManageUserProfileRepository {
    final Dio dio;
    ManageUserProfileRepositoryImpl(this.dio);

    @override
    Future<UserProfile> fetchUserProfile() async {
      final response = await dio.get(
        '${ApiVersions.v1}/user/profile',
      );
      final UserProfileDTO userBiasDTO = UserProfileDTO.fromJson(response.data);
      return userBiasDTO.toDomain();
    }

    @override
    Future<S3UploadUrl> getS3UploadUrl(String mimeType) async {
      final response = await dio.post(
        '${ApiVersions.v1}/user/profile/upload-url',
        data: {
         'contentType': mimeType,
        },
      );
      final S3UploadUrlDto s3UploadUrlDto = S3UploadUrlDto.fromJson(response.data);
      return s3UploadUrlDto.toDomain();
    }

    @override
    Future<void> deleteProfileImage() async {
      final response = await dio.delete(
        '${ApiVersions.v1}/user/profile/image',
      );
      final statusCode = response.statusCode;
      if (statusCode != 200) {
        throw Exception('Failed to delete profile image');
      }
    }

    @override
    Future<String> commitStatus(String uploadKey) async {
      final response = await dio.post(
          '${ApiVersions.v1}/user/profile/commit',
          data:{
            "uploadKey": uploadKey
          }
      );
      final statusCode = response.statusCode;
      if(statusCode == 200) {
        return response.data['imageUrl'];
      }else{
        throw Exception('Failed to commit profile image status');
      }
    }

    @override
    Future<Result<bool, NickNameError>> updateUserNickname(String name) async {
      final response = await dio.put(
        '${ApiVersions.v1}/user/nickname',
        data: {
          'nickname': name,
        },
      ).onError((DioException e, stackTrace) {
        return e.response ?? Response(
          requestOptions: e.requestOptions,
          statusCode: e.response?.statusCode ?? 999,
        );
      });

      switch(response.statusCode) {
        case 200:
          return Result.success(true);
        case 409:
          return Result.error(NickNameError.alreadyExists);
        default:
          return Result.error(NickNameError.unknown);
      }
    }
}
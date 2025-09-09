import 'dart:io';

import 'package:could_be/core/components/alert/snack_bar.dart';
import 'package:could_be/core/events/profile_events.dart';
import 'package:could_be/domain/useCases/user/manage_user_profile_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:mime/mime.dart' show lookupMimeType;

import 'profile_manage_state.dart';

class ProfileManageViewModel with ChangeNotifier{

  // ProfileEvents.notifyProfileUpdated(imageUrl)

  late ProfileManageState _state = ProfileManageState(imageUrl: imageUrl);
  ProfileManageState get state => _state;

  late final BuildContext context;
  late final String? imageUrl;

  final ManageUserProfileUseCase manageUserProfileUsecase;

  ProfileManageViewModel({
    required this.context,
    required this.imageUrl,
    required this.manageUserProfileUsecase,
  });

  void _setImageFileListFromFile(XFile? value)async{
    _state = state.copyWith(imageFile: value, isLoading: true);
    notifyListeners();

    final Text? retrieveError = _getRetrieveErrorWidget();

    if (retrieveError != null) {
      _state = state.copyWith(isLoading: false);
      notifyListeners();
      showSnackBar(context, msg: '에러가 발생하였습니다.');
      return;
    }

    if (state.imageFile != null) {
      // _state = state.copyWith(mimeType: lookupMimeType(state.imageFile!.path));
      // const allowedMimeTypes = [
      //   'image/png',
      //   'image/jpeg',
      //   'image/jpg',
      //   'image/webp',
      // ];

      // if (state.mimeType == null || !allowedMimeTypes.contains(state.mimeType)) {
      //   showSnackBar(context, msg:'지원하지 않는 이미지 형식입니다.\n파일 형식: $state.mimeType');
      //   _state = state.copyWith(isLoading: false);
      //   notifyListeners();
      //   return;
      // }

      final XFile? compressedImage = await compressImage(
        state.imageFile,
        // mimeType: state.mimeType!,
      );

      if (compressedImage != null) {
        _state = state.copyWith(imageFile: compressedImage);
        _state = state.copyWith(uint8list: await state.imageFile!.readAsBytes(), isLoading: false);
        notifyListeners();
        return;
      } else {
        showSnackBar(context, msg:'이미지 압축에 실패했습니다.');
        _state = state.copyWith(isLoading: false);
        notifyListeners();
        return;
      }
    } else if (state.pickImageError != null) {
      _state = state.copyWith(isLoading: false);
      notifyListeners();
      showSnackBar(context, msg: '에러가 발생하였습니다.');
      return;
    } else {
      _state = state.copyWith(isLoading: false);
      notifyListeners();
      showSnackBar(context, msg: '에러가 발생하였습니다.');
      return;
    }
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> onImageButtonPressed(
      ImageSource source, {
        required BuildContext context,
      }) async {
    if (context.mounted) {
      try {
        final XFile? pickedFile = await _picker.pickImage(source: source);
        _setImageFileListFromFile(pickedFile);
      } catch (e) {
        _state = state.copyWith(pickImageError: e);
        notifyListeners();
      }
    }
  }

  Future<void> onCameraButtonPressed() async {
    if (_picker.supportsImageSource(ImageSource.camera)) {
      onImageButtonPressed(ImageSource.camera, context: context);
    }
  }

  Future<void> onDeleteButtonPressed() async {
    _state = state.copyWith(isUploading: true);
    notifyListeners();

    await manageUserProfileUsecase.deleteUserProfileImage();
    ProfileEvents.notifyProfileUpdated(null);
    _state = state.copyWith(clearImage: true, isUploading: false);
    notifyListeners();
    showSnackBar(context, msg: '프로필 사진이 삭제되었습니다.');
  }

  Text? _getRetrieveErrorWidget() {
    if (state.retrieveDataError != null) {
      final Text result = Text(state.retrieveDataError!);
      _state = state.copyWith(clearRetrieveDataError: true);
      notifyListeners();
      return result;
    }
    return null;
  }

  Future<void> retrieveLostData() async {
    if(!kIsWeb && defaultTargetPlatform == TargetPlatform.android){
      final LostDataResponse response = await _picker.retrieveLostData();
      if (response.isEmpty) {
        return;
      }
      if (response.file != null) {
        _setImageFileListFromFile(response.file);
      } else {
        _state = state.copyWith(
          retrieveDataError: response.exception!.code,
        );
        notifyListeners();
      }
    }
  }

  void completeProfileUpdate()async{
    if (state.uint8list != null) {
      _state = state.copyWith(isUploading: true);
      notifyListeners();
      String? imageUrl = await manageUserProfileUsecase.uploadProfileImage(
        uint8List: state.uint8list!,
        mimeType: 'image/webp',
      );
      ProfileEvents.notifyProfileUpdated(imageUrl);
      _state = state.copyWith(isUploading: false);
      notifyListeners();
    }
    if(context.mounted) {
      context.pop();
    }
  }

  Future<XFile?> compressImage(XFile? pickedFile,
      {
        // required String mimeType,
        int maxSizeInBytes = 50 * 1024}) async {

    if (pickedFile == null) return null;

    File originalFile = File(pickedFile.path);

    int quality = 100;
    Uint8List? compressedBytes;

    // 퀄리티를 낮춰가며 반복적으로 압축

    // var format = CompressFormat.jpeg; // 기본값
    // if (mimeType == 'image/png') format = CompressFormat.png;
    // if (mimeType == 'image/webp') format = CompressFormat.webp;

    while (quality > 0) {
      compressedBytes = await FlutterImageCompress.compressWithFile(
        originalFile.absolute.path,
        quality: quality,
        format: CompressFormat.webp,
      );

      if (compressedBytes == null) return null;
      if (compressedBytes.lengthInBytes <= maxSizeInBytes) {
        break;
      }
      if(quality <= 10){
        quality --;
      }else{
        quality -= 10;
      }
    }

    // // 임시 파일로 저장
    // final tempDir = await getTemporaryDirectory();
    // final targetPath = path.join(tempDir.path, 'compressed_image.jpg');

    final compressedFile = XFile.fromData(
      compressedBytes!,
      name: 'compressed_image.webp',
      mimeType: 'image/webp',
    );

    // final compressedFile = XFile.fromData(
    //   compressedBytes!,
    //   name: 'compressed_image.jpg',
    //   mimeType: 'image/jpeg',
    // );

    return compressedFile;
  }
}
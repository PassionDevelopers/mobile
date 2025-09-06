import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileManageState {
  final XFile? imageFile;
  final String? imageUrl;
  final Uint8List? uint8list;
  // final String? mimeType;

  final bool isLoading;
  final bool isUploading;

  final dynamic pickImageError;

  final String? retrieveDataError;

  final Widget widget;

  ProfileManageState({
    this.imageFile,
    this.uint8list,
    // this.mimeType,
    this.imageUrl,
    this.isUploading = false,
    this.pickImageError,
    this.retrieveDataError,
    this.isLoading = false,
    this.widget = const CircularProgressIndicator()
  });

  ProfileManageState copyWith({
    XFile? imageFile,
    Uint8List? uint8list,
    String? mimeType,
    dynamic pickImageError,
    String? retrieveDataError,
    bool? clearRetrieveDataError,
    bool? clearImage,
    bool? isLoading,
    Widget? widget,
    String? imageUrl,
    bool? isUploading,
  }) {
    return ProfileManageState(
      imageFile: clearImage == true ? null : (imageFile ?? this.imageFile),
      uint8list: clearImage == true ? null : (uint8list ?? this.uint8list),
      // mimeType: clearImage == true ? null : (mimeType ?? this.mimeType),
      pickImageError: pickImageError ?? this.pickImageError,
      isLoading: isLoading ?? this.isLoading,
      widget: widget ?? this.widget,
      imageUrl: clearImage == true ? null : (imageUrl ?? this.imageUrl),
      isUploading: isUploading ?? this.isUploading,
      retrieveDataError: clearRetrieveDataError==true ? null : (retrieveDataError ?? this.retrieveDataError),
    );
  }

}
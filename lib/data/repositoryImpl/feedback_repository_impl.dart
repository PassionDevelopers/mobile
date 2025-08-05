import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:could_be/domain/repositoryInterfaces/feedback_interface.dart';

class FeedbackRepositoryImpl implements FeedbackInterface {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  FeedbackRepositoryImpl(this._firestore, this._auth);

  @override
  Future<void> submitFeedback({
    required String category,
    // required String name,
    required String? email,
    required String? title,
    required String content,
  }) async {
    try {
      // Get app info
      final packageInfo = await PackageInfo.fromPlatform();
      final currentUser = _auth.currentUser;
      
      // Prepare feedback data
      final feedbackData = {
        // Form data
        'category': category,
        // 'name': name,
        'email': email,
        'title': title,
        'content': content,
        
        // Timestamp
        'timestamp': FieldValue.serverTimestamp(),
        'submittedAt': DateTime.now().toIso8601String(),
        
        // User context
        'userId': currentUser?.uid,
        'userEmail': currentUser?.email,
        'isAnonymous': currentUser?.isAnonymous ?? true,
        'authProvider': currentUser?.providerData.isNotEmpty == true 
            ? currentUser!.providerData.first.providerId 
            : null,
            
        // App metadata
        'appVersion': packageInfo.version,
        'buildNumber': packageInfo.buildNumber,
        'packageName': packageInfo.packageName,
        
        // Platform info
        'platform': Platform.operatingSystem,
        'platformVersion': Platform.operatingSystemVersion,
        'isAndroid': Platform.isAndroid,
        'isIOS': Platform.isIOS,
        
        // Status
        'status': 'pending',
        'resolved': false,
      };
      // Add to Firestore
      await _firestore.collection('feedback').add(feedbackData);
      
    } on FirebaseException catch (e) {
      switch (e.code) {
        case 'permission-denied':
          throw Exception('권한이 없습니다. 다시 로그인해주세요.');
        case 'unavailable':
          throw Exception('서비스를 일시적으로 사용할 수 없습니다. 잠시 후 다시 시도해주세요.');
        case 'quota-exceeded':
          throw Exception('일시적으로 요청이 많습니다. 잠시 후 다시 시도해주세요.');
        case 'network-request-failed':
          throw Exception('네트워크 연결을 확인해주세요.');
        default:
          throw Exception('피드백 전송 중 오류가 발생했습니다: ${e.message}');
      }
    } catch (e) {
      throw Exception('피드백 전송 중 오류가 발생했습니다.');
    }
  }
}
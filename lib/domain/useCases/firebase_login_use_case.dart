import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../repositoryInterfaces/token_storage_interface.dart';

class FirebaseLoginUseCase {
  final TokenStorageRepository _tokenStorageRepository;

  FirebaseLoginUseCase({
    required TokenStorageRepository tokenStorageRepository,
  })  : _tokenStorageRepository = tokenStorageRepository;

  Future<bool> saveToken(String token) async {
    return await _tokenStorageRepository.saveToken(token);
  }

  Future<bool> signInAnon() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
      String? idToken = await userCredential.user?.getIdToken();
      if (idToken == null) {
        log("idToken is null");
        return false;
      } else {
        log(idToken);
        return await saveToken(idToken);
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> signInWithApple({bool? isReauth}) async {
    try{
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );
      // Sign in the user with Firebase. If the nonce we generated earlier does
      // not match the nonce in `appleCredential.identityToken`, sign in will fail.
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      String? idToken = await userCredential.user?.getIdToken();
      if (idToken == null) {
        log("idToken is null");
        return false;
      } else {
        return await saveToken(idToken);
      }
    }catch(e){
      log(e.toString());
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    //계정 다시 선택하도록 연결 끊기
    // await GoogleSignIn().disconnect();
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    //GoogleSignInAuthentication:Instance of 'GoogleSignInTokenData'

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    String? idToken = await userCredential.user?.getIdToken();
    if(idToken == null) {
      log("idToken is null");
      return false;
    }else{
      return await saveToken(idToken);
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    if(await GoogleSignIn().isSignedIn()){
      await GoogleSignIn().signOut();
    }
  }

  // Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
  //   return await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  // }
  //
  // Future<UserCredential?> reauthWithApple({bool? isReauth}) async {
  //   final appleCredential = await SignInWithApple.getAppleIDCredential(
  //     scopes: [
  //       AppleIDAuthorizationScopes.email,
  //       AppleIDAuthorizationScopes.fullName,
  //     ],);
  //   final oauthCredential = OAuthProvider("apple.com").credential(
  //     idToken: appleCredential.identityToken,
  //     accessToken: appleCredential.authorizationCode,
  //   );
  //   return await FirebaseAuth.instance.currentUser?.reauthenticateWithCredential(oauthCredential);
  // }
  //
  // Future<UserCredential?> reauthWithGoogle() async {
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //   final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );
  //   return await FirebaseAuth.instance.currentUser?.reauthenticateWithCredential(credential);
  // }

  //
  // Future<void> deleteUser()async{
  //   await _tokenStorageRepository.clearToken();
  //   _manageUserStatusRepository.deleteUser();
  // }

}
import 'package:amplitude_flutter/amplitude.dart';
import 'package:amplitude_flutter/configuration.dart';
import 'package:app_links/app_links.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:could_be/constants.dart';
import 'package:could_be/core/di/di_repository.dart';
import 'package:could_be/core/di/di_use_case.dart';
import 'package:could_be/core/di/di_view_model.dart';
import 'package:could_be/core/routes/route_service.dart';
import 'package:could_be/core/routes/router.dart';
import 'package:could_be/data/data_source/cache/deep_link_storage.dart';
import 'package:could_be/data/repositoryImpl/kakao_register_uuid_repository_impl.dart';
import 'package:could_be/data/repositoryImpl/token_storage_repository_impl.dart';
import 'package:could_be/domain/repositoryInterfaces/kakao_register_uuid_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/token_storage_interface.dart';
import 'package:could_be/domain/useCases/firebase_login_use_case.dart';
import 'package:could_be/presentation/log_in/login_view_model.dart';
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'api.dart';

final getIt = GetIt.instance;

//previous
Future<void> diSetupToken() async {

  getIt.registerSingleton<Amplitude>(Amplitude(Configuration(
    apiKey: EnvConstants.amplitudeApiKey
    ))
  );

  getIt.registerSingleton<RouteService>(RouteService(router));

  getIt.registerSingleton<TokenStorageRepository>(TokenStorageRepositoryImpl());
  // dio with token interceptor
  getIt.registerSingleton<Dio>(createDio(getIt()));
  //
  // Firebase instances
  //
  getIt.registerSingleton<AppLinks>(AppLinks());
  getIt.registerSingleton<DeepLinkStorage>(DeepLinkStorage());
  getIt.registerSingleton<KakaoRegisterUuidRepository>(KakaoRegisterUuidRepositoryImpl(getIt<Dio>()));
  getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  getIt.registerSingleton<FirebaseAnalytics>(FirebaseAnalytics.instance);

  getIt.registerSingleton<FirebaseLoginUseCase>(
    FirebaseLoginUseCase(
      tokenStorageRepository: getIt(),
      kakaoRegisterUuidRepository: getIt(),
      firebaseAuth: getIt(),
    ),
  );

  getIt.registerSingleton<LoginViewModel>(
    LoginViewModel(firebaseLoginUseCase: getIt()),
  );
}

Future<void> diSetup() async{
  // repository
  diRepoSetup();
  // useCase
  diUseCaseSetup();
  // viewModel
  diViewModelSetup();
}

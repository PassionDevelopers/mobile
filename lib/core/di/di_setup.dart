import 'package:amplitude_flutter/amplitude.dart';
import 'package:amplitude_flutter/configuration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:could_be/core/di/di_repository.dart';
import 'package:could_be/core/di/di_use_case.dart';
import 'package:could_be/core/di/di_view_model.dart';
import 'package:could_be/data/repositoryImpl/token_storage_repository_impl.dart';
import 'package:could_be/domain/repositoryInterfaces/token_storage_interface.dart';
import 'package:could_be/domain/useCases/firebase_login_use_case.dart';
import 'package:could_be/presentation/log_in/login_view_model.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'api.dart';

final getIt = GetIt.instance;

Future<void> diSetupToken() async {

  getIt.registerSingleton<Amplitude>(Amplitude(Configuration(
          apiKey: "f7b82ddae07365f5aa64dc2496a44dc8"
        ))
  );

  getIt.registerSingleton<TokenStorageRepository>(TokenStorageRepositoryImpl());
  //
  // Firebase instances
  //
  getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  getIt.registerSingleton<FirebaseLoginUseCase>(
    FirebaseLoginUseCase(
      tokenStorageRepository: getIt(),
      firebaseAuth: getIt(),
    ),
  );

  getIt.registerSingleton<LoginViewModel>(
    LoginViewModel(firebaseLoginUseCase: getIt()),
  );
}

Future<void> diSetup() async{
  // dio with token interceptor
  getIt.registerSingleton<Dio>(createDio(getIt()));
  // repository
  diRepoSetup();
  // useCase
  diUseCaseSetup();
  // viewModel
  diViewModelSetup();
}

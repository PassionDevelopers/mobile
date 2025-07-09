

import 'package:amplitude_flutter/amplitude.dart';
import 'package:could_be/core/amplitude/amplitude.dart';
import 'package:could_be/core/di/di_setup.dart';
import '../entities/user_bias.dart';
import '../repositoryInterfaces/user_bias_interface.dart';

class FetchUserBiasUseCase {
  final UserBiasRepository _userBiasRepository;

  FetchUserBiasUseCase(this._userBiasRepository);

  Future<UserBias> execute() async {
    getIt<Amplitude>().track(AmplitudeEvents.fetchUserBias);
    return await _userBiasRepository.fetchUserBias();
  }
}
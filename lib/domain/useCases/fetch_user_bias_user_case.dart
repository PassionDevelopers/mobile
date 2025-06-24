

import '../entities/user_bias.dart';
import '../repositoryInterfaces/user_bias_interface.dart';

class FetchUserBiasUseCase {
  final UserBiasRepository _userBiasRepository;

  FetchUserBiasUseCase(this._userBiasRepository);

  Future<UserBias> execute() async {
    return await _userBiasRepository.fetchUserBias();
  }
}
import 'package:could_be/domain/repositoryInterfaces/manage_user_profile_interface.dart';

class ManageUserProfileUseCase {
  final ManageUserProfileRepository manageUserProfileRepository;

  ManageUserProfileUseCase(this.manageUserProfileRepository);

  Future<void> updateUserNickname(String name) async {
    await manageUserProfileRepository.updateUserNickname(name);
  }
}
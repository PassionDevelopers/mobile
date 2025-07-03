import '../repositoryInterfaces/manage_user_status_interface.dart';

class ManageUserStatusUseCase{

  final ManageUserStatusRepository _manageUserStatusRepository;
  ManageUserStatusUseCase(this._manageUserStatusRepository);

  Future<void> registerUser()async{
    _manageUserStatusRepository.registerUser();
  }

  Future<void> deleteUser()async{
    _manageUserStatusRepository.deleteUser();
  }

}
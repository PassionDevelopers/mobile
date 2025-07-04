abstract class ManageUserStatusRepository {

  Future<void> registerUserWithIdToken();

  Future<void> deleteUser();
}
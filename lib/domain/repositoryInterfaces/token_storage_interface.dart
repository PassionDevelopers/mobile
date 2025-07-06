abstract class TokenStorageRepository {
  Future<bool> saveToken(String token);
  Future<String?> getToken();
}
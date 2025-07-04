abstract class TokenStorageRepository {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
}
abstract class TokenStorageRepository {

  Future<bool> saveToken(String token);
  Future<bool> saveGuestUid(String guestUid);

  Future<String?> getGuestUid();
  Future<String?> getToken();

}


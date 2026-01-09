abstract class TokenStorage {
  Future<void> save(String token);
  Future<String?> load();
  Future<void> clear();
}

import '../models/auth.dart';
import '../services/config.dart';
import '../services/api_service.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(LoginRequest request);
  Future<void> logout();
  Future<bool> isLoggedIn();
  Future<String?> getAccessToken();
  Future<void> saveTokens(String accessToken, String refreshToken);
  Future<void> clearTokens();
}

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await ApiService().dio.post(
        "/auth/login/",
        data: request.toJson(),
      );

      final data = response.data;

      print("🔥 LOGIN RESPONSE: $data");

      // ✅ FIX RESPONSE STRUCTURE
      final access = data["access"];
      final refresh = data["refresh"];

      final user = data["user"] ?? {};

      // ✅ SAVE TOKEN
      await ApiService().setAuthToken(access);

      return LoginResponse(
        accessToken: access ?? '',
        refreshToken: refresh ?? '',
        studentId: user["student_id"]?.toString() ?? '',
        collegeId: user["college_id"]?.toString() ?? '',
        userName: user["username"] ?? '',
        email: user["email"] ?? '',
        profilePhotoUrl: user["profile_photo"],
      );
    } catch (e) {
      print("❌ LOGIN ERROR: $e");
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    await clearTokens();
  }

  @override
  Future<bool> isLoggedIn() async {
    // TODO: Implement token validation
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }

  @override
  Future<String?> getAccessToken() async {
    // TODO: Implement secure storage retrieval
    return null;
  }

  @override
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    // TODO: Implement secure storage
  }

  @override
  Future<void> clearTokens() async {
    // TODO: Implement secure storage clearing
  }
}

// Factory constructor for easy switching
AuthRepository createAuthRepository() {
  return AuthRepositoryImpl();
}

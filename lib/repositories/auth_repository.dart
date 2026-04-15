import '../models/auth.dart';
import '../services/config.dart';

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
    if (Config.USE_MOCK_DATA) {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Mock implementation - accept any email with password validation
      return LoginResponse(
        accessToken: 'mock_access_token_${DateTime.now().millisecondsSinceEpoch}',
        refreshToken: 'mock_refresh_token_${DateTime.now().millisecondsSinceEpoch}',
        studentId: '1',
        collegeId: 'KUMSS001',
        userName: 'John Doe',
        email: request.email,
        profilePhotoUrl: 'https://via.placeholder.com/150',
      );
    } else {
      // TODO: Implement real API call
      // final response = await ApiService().dio.post(
      //   '/auth/login/',
      //   data: request.toJson(),
      // );
      // return LoginResponse.fromJson(response.data);
      throw UnimplementedError('Real API implementation pending');
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

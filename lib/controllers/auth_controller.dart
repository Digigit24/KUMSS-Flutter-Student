import 'package:get/get.dart';
import '../models/auth.dart';
import '../repositories/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository repository;

  // Observables
  RxBool isLoading = false.obs;
  RxBool isLoggedIn = false.obs;
  RxString error = ''.obs;
  RxString accessToken = ''.obs;

  // Getters
  bool get isLoadingValue => isLoading.value;
  bool get isLoggedInValue => isLoggedIn.value;
  String get errorValue => error.value;
  String get accessTokenValue => accessToken.value;

  AuthController({required this.repository});

  @override
  void onInit() {
    super.onInit();
    _checkIfLoggedIn();
  }

  Future<void> _checkIfLoggedIn() async {
    try {
      isLoggedIn.value = await repository.isLoggedIn();
    } catch (e) {
      isLoggedIn.value = false;
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      error.value = 'Email and password are required';
      return;
    }

    isLoading.value = true;
    error.value = '';

    try {
      final request = LoginRequest(
        email: email,
        password: password,
      );
      final response = await repository.login(request);

      // Save tokens
      await repository.saveTokens(response.accessToken, response.refreshToken);

      accessToken.value = response.accessToken;
      isLoggedIn.value = true;
      error.value = '';
    } catch (e) {
      error.value = e.toString();
      isLoggedIn.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    isLoading.value = true;
    try {
      await repository.logout();
      accessToken.value = '';
      isLoggedIn.value = false;
      error.value = '';
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> forgotPassword(String email) async {
    if (email.isEmpty) {
      error.value = 'Email is required';
      return;
    }

    isLoading.value = true;
    error.value = '';

    try {
      // TODO: Implement forgot password
      error.value = '';
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetPassword({
    required String email,
    required String token,
    required String newPassword,
    required String confirmPassword,
  }) async {
    if (newPassword != confirmPassword) {
      error.value = 'Passwords do not match';
      return;
    }

    isLoading.value = true;
    error.value = '';

    try {
      // TODO: Implement reset password
      error.value = '';
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}

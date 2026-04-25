/// Login credentials
class LoginRequest {
  final String username;
  final String password;

  LoginRequest({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}

/// Login response with tokens
class LoginResponse {
  final String accessToken;
  final String refreshToken;
  final String studentId;
  final String collegeId;
  final String userName;
  final String email;
  final String? profilePhotoUrl;

  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.studentId,
    required this.collegeId,
    required this.userName,
    required this.email,
    this.profilePhotoUrl,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final user = json['user'] ?? {};
    return LoginResponse(
      accessToken: json['access_token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
      studentId: json['student_id']?.toString() ?? '',
      collegeId: json['college_id']?.toString() ?? '',
      userName: json['user_name'] ?? '',
      email: json['email'] ?? '',
      profilePhotoUrl: json['profile_photo_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'student_id': studentId,
      'college_id': collegeId,
      'user_name': userName,
      'email': email,
      'profile_photo_url': profilePhotoUrl,
    };
  }
}

/// Forgot password request
class ForgotPasswordRequest {
  final String email;

  ForgotPasswordRequest({required this.email});

  Map<String, dynamic> toJson() {
    return {'email': email};
  }
}

/// Reset password request
class ResetPasswordRequest {
  final String email;
  final String token;
  final String newPassword;
  final String confirmPassword;

  ResetPasswordRequest({
    required this.email,
    required this.token,
    required this.newPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'token': token,
      'new_password': newPassword,
      'confirm_password': confirmPassword,
    };
  }
}

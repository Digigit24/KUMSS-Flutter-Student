/// Global configuration for the application
class Config {
  /// Toggle between mock data and real API calls
  static const bool USE_MOCK_DATA = true;

  /// Base URL for API endpoints
  static const String BASE_URL = 'https://kumsserp2.celiyo.com';

  /// API version
  static const String API_VERSION = 'v1';

  /// Full API base URL
  static String get apiBaseUrl => '$BASE_URL/api/$API_VERSION';

  /// College ID header (will be populated from auth)
  static String collegeId = '';

  /// Student ID (will be populated from auth)
  static String studentId = '';

  /// Connection timeout in milliseconds
  static const int connectionTimeout = 30000;

  /// Receive timeout in milliseconds
  static const int receiveTimeout = 30000;
}

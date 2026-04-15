import 'package:hive_flutter/hive_flutter.dart';
import '../models/student.dart';
import '../models/attendance.dart';
import '../models/academic.dart';
import '../models/assignment.dart';
import '../models/notice.dart';
import 'dart:convert';

class HiveService {
  static final HiveService _instance = HiveService._internal();

  late Box<String> _cacheBox;
  late Box<String> _userBox;

  factory HiveService() {
    return _instance;
  }

  HiveService._internal();

  Future<void> init() async {
    try {
      _cacheBox = await Hive.openBox<String>('app_cache');
      _userBox = await Hive.openBox<String>('user_data');
    } catch (e) {
      print('Hive initialization error: $e');
    }
  }

  // User Data Methods
  Future<void> saveStudent(Student student) async {
    try {
      await _userBox.put('student', jsonEncode(student.toJson()));
    } catch (e) {
      print('Error saving student: $e');
    }
  }

  Student? getStudent() {
    try {
      final json = _userBox.get('student');
      if (json != null) {
        return Student.fromJson(jsonDecode(json));
      }
    } catch (e) {
      print('Error getting student: $e');
    }
    return null;
  }

  Future<void> saveUserToken(String token) async {
    try {
      await _userBox.put('access_token', token);
    } catch (e) {
      print('Error saving token: $e');
    }
  }

  String? getUserToken() {
    try {
      return _userBox.get('access_token');
    } catch (e) {
      print('Error getting token: $e');
    }
    return null;
  }

  // Cache Methods
  Future<void> cacheData<T>(String key, T data) async {
    try {
      final jsonString = jsonEncode(data);
      await _cacheBox.put(key, jsonString);
    } catch (e) {
      print('Error caching data: $e');
    }
  }

  T? getCachedData<T>(String key, T Function(Map<String, dynamic>) fromJson) {
    try {
      final jsonString = _cacheBox.get(key);
      if (jsonString != null) {
        return fromJson(jsonDecode(jsonString));
      }
    } catch (e) {
      print('Error retrieving cached data: $e');
    }
    return null;
  }

  Future<void> cacheList<T>(String key, List<T> list) async {
    try {
      final jsonString = jsonEncode(list);
      await _cacheBox.put(key, jsonString);
    } catch (e) {
      print('Error caching list: $e');
    }
  }

  List<T>? getCachedList<T>(String key, T Function(Map<String, dynamic>) fromJson) {
    try {
      final jsonString = _cacheBox.get(key);
      if (jsonString != null) {
        final list = jsonDecode(jsonString) as List;
        return list.map((item) => fromJson(item as Map<String, dynamic>)).toList();
      }
    } catch (e) {
      print('Error retrieving cached list: $e');
    }
    return null;
  }

  // Cache Invalidation
  Future<void> clearCache(String key) async {
    try {
      await _cacheBox.delete(key);
    } catch (e) {
      print('Error clearing cache: $e');
    }
  }

  Future<void> clearAllCache() async {
    try {
      await _cacheBox.clear();
    } catch (e) {
      print('Error clearing all cache: $e');
    }
  }

  Future<void> clearAllData() async {
    try {
      await _cacheBox.clear();
      await _userBox.clear();
    } catch (e) {
      print('Error clearing all data: $e');
    }
  }

  // Specific Cache Keys
  static const String studentCacheKey = 'student_profile';
  static const String attendanceCacheKey = 'attendance_records';
  static const String subjectsCacheKey = 'enrolled_subjects';
  static const String assignmentsCacheKey = 'assignments';
  static const String noticesCacheKey = 'notices';
  static const String feesCacheKey = 'fees';
  static const String examsCacheKey = 'exams';
  static const String resultsCacheKey = 'results';

  // Timestamp tracking for cache invalidation
  Future<void> setCacheTimestamp(String key) async {
    try {
      await _cacheBox.put('${key}_timestamp', DateTime.now().toIso8601String());
    } catch (e) {
      print('Error setting timestamp: $e');
    }
  }

  bool isCacheExpired(String key, {Duration expiry = const Duration(hours: 1)}) {
    try {
      final timestamp = _cacheBox.get('${key}_timestamp');
      if (timestamp == null) return true;

      final cachedTime = DateTime.parse(timestamp);
      return DateTime.now().difference(cachedTime) > expiry;
    } catch (e) {
      print('Error checking cache expiry: $e');
      return true;
    }
  }

  Future<void> invalidateExpiredCache() async {
    try {
      final keys = _cacheBox.keys;
      for (var key in keys) {
        if (key.toString().endsWith('_timestamp')) {
          final baseKey = key.toString().replaceAll('_timestamp', '');
          if (isCacheExpired(baseKey)) {
            await clearCache(baseKey);
            await clearCache(key.toString());
          }
        }
      }
    } catch (e) {
      print('Error invalidating expired cache: $e');
    }
  }
}

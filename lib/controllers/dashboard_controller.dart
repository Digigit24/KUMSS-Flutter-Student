import 'package:get/get.dart';
import '../models/dashboard.dart';
import '../repositories/dashboard_repository.dart';

class DashboardController extends GetxController {
  final DashboardRepository repository;

  // Observables
  Rx<DashboardStats?> stats = Rx<DashboardStats?>(null);
  RxBool isLoading = false.obs;
  RxString error = ''.obs;

  // Getters
  DashboardStats? get statsValue => stats.value;
  bool get isLoadingValue => isLoading.value;
  String get errorValue => error.value;

  DashboardController({required this.repository});

  @override
  void onInit() {
    super.onInit();
    getDashboardStats();
  }

  Future<void> getDashboardStats({bool forceRefresh = false}) async {
    if (stats.value != null && !forceRefresh) {
      return;
    }

    isLoading.value = true;
    error.value = '';

    try {
      final data = await repository.getDashboardStats();
      stats.value = data;
      error.value = '';
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshDashboard() async {
    await getDashboardStats(forceRefresh: true);
  }

  // Helper getters for individual stats
  double get attendancePercentage => stats.value?.attendancePercentage ?? 0.0;
  int get pendingAssignments => stats.value?.pendingAssignments ?? 0;
  int get pendingHomework => stats.value?.pendingHomework ?? 0;
  int get pendingFees => stats.value?.pendingFees ?? 0;
  int get todayClasses => stats.value?.todayClasses ?? 0;
  List<RecentMark> get recentMarks => stats.value?.recentMarks ?? [];
  List<Notice> get pinnedNotices => stats.value?.pinnedNotices ?? [];
  List<QuickActionItem> get quickActions => stats.value?.quickActions ?? [];
}

import '../models/notice.dart';

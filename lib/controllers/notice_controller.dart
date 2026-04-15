import 'package:get/get.dart';
import '../models/notice.dart';
import '../repositories/notice_repository.dart';

class NoticeController extends GetxController {
  final NoticeRepository repository;

  // Observables
  RxList<Notice> allNotices = RxList<Notice>();
  RxList<Notice> filteredNotices = RxList<Notice>();
  RxList<Notice> pinnedNotices = RxList<Notice>();
  Rx<Notice?> selectedNotice = Rx<Notice?>(null);
  RxBool isLoading = false.obs;
  RxString error = ''.obs;
  RxString selectedCategory = RxString('All');
  RxString selectedPriority = RxString('All');

  // Getters
  List<Notice> get noticesList => filteredNotices;
  List<Notice> get pinnedNoticesList => pinnedNotices;
  Notice? get selectedNoticeValue => selectedNotice.value;
  bool get isLoadingValue => isLoading.value;
  String get errorValue => error.value;

  // Categories
  static const List<String> categories = ['All', 'Academic', 'Event', 'Holiday', 'General'];
  static const List<String> priorities = ['All', 'Urgent', 'High', 'Normal', 'Low'];

  NoticeController({required this.repository});

  @override
  void onInit() {
    super.onInit();
    getNotices();
    getPinnedNotices();
  }

  Future<void> getNotices({String? category, String? priority}) async {
    isLoading.value = true;
    error.value = '';

    try {
      final data = await repository.getNotices(
        category: category != 'All' ? category : null,
        priority: priority != 'All' ? priority : null,
      );
      allNotices.assignAll(data);
      _applyFilters();
      error.value = '';
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getNoticeDetail(int noticeId) async {
    isLoading.value = true;
    error.value = '';

    try {
      final data = await repository.getNoticeDetail(noticeId);
      selectedNotice.value = data;
      error.value = '';
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getPinnedNotices() async {
    try {
      final data = await repository.getPinnedNotices();
      pinnedNotices.assignAll(data);
      error.value = '';
    } catch (e) {
      error.value = e.toString();
    }
  }

  void setCategory(String category) {
    selectedCategory.value = category;
    _applyFilters();
  }

  void setPriority(String priority) {
    selectedPriority.value = priority;
    _applyFilters();
  }

  void _applyFilters() {
    var filtered = allNotices.toList();

    // Apply category filter
    if (selectedCategory.value != 'All') {
      filtered = filtered.where((n) => n.category == selectedCategory.value).toList();
    }

    // Apply priority filter
    if (selectedPriority.value != 'All') {
      filtered = filtered.where((n) => n.priority == selectedPriority.value).toList();
    }

    // Sort by pinned and date
    filtered.sort((a, b) {
      if (a.isPinned != b.isPinned) {
        return a.isPinned ? -1 : 1;
      }
      return b.createdAt.compareTo(a.createdAt);
    });

    filteredNotices.assignAll(filtered);
  }

  Future<void> refresh() async {
    await Future.wait([
      getNotices(),
      getPinnedNotices(),
    ]);
  }
}

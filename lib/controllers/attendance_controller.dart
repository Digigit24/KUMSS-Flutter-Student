import 'package:get/get.dart';
import '../models/attendance.dart';
import '../repositories/attendance_repository.dart';

class AttendanceController extends GetxController {
  final AttendanceRepository repository;

  // Observables
  RxList<AttendanceRecord> records = RxList<AttendanceRecord>();
  Rx<AttendanceSummary?> summary = Rx<AttendanceSummary?>(null);
  RxBool isLoading = false.obs;
  RxString error = ''.obs;
  RxInt selectedMonth = RxInt(DateTime.now().month);

  // Getters
  List<AttendanceRecord> get recordsList => records;
  AttendanceSummary? get summaryValue => summary.value;
  bool get isLoadingValue => isLoading.value;
  String get errorValue => error.value;

  AttendanceController({required this.repository});

  @override
  void onInit() {
    super.onInit();
    getAttendanceSummary();
    getAttendanceRecords();
  }

  Future<void> getAttendanceRecords({int? subjectId}) async {
    isLoading.value = true;
    error.value = '';

    try {
      final data = await repository.getAttendanceRecords(subjectId: subjectId);
      records.assignAll(data);
      error.value = '';
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAttendanceSummary() async {
    try {
      final data = await repository.getAttendanceSummary();
      summary.value = data;
      error.value = '';
    } catch (e) {
      error.value = e.toString();
    }
  }

  List<AttendanceRecord> getRecordsForMonth(int month) {
    return records
        .where((r) {
          try {
            final date = DateTime.parse(r.date);
            return date.month == month;
          } catch (e) {
            return false;
          }
        })
        .toList();
  }

  Map<String, int> getStatusBreakdown() {
    final breakdown = {
      'Present': 0,
      'Absent': 0,
      'Late': 0,
      'Excused': 0,
    };

    for (var record in records) {
      breakdown[record.status] = (breakdown[record.status] ?? 0) + 1;
    }

    return breakdown;
  }

  void setSelectedMonth(int month) {
    selectedMonth.value = month;
  }

  Future<void> refresh() async {
    await Future.wait([
      getAttendanceRecords(),
      getAttendanceSummary(),
    ]);
  }
}

import '../models/attendance.dart';
import '../services/config.dart';

abstract class AttendanceRepository {
  Future<List<AttendanceRecord>> getAttendanceRecords({
    int? subjectId,
    String? fromDate,
    String? toDate,
  });
  Future<AttendanceSummary> getAttendanceSummary();
}

class AttendanceRepositoryImpl implements AttendanceRepository {
  @override
  Future<List<AttendanceRecord>> getAttendanceRecords({
    int? subjectId,
    String? fromDate,
    String? toDate,
  }) async {
    if (Config.USE_MOCK_DATA) {
      await Future.delayed(const Duration(milliseconds: 500));

      // Generate mock attendance records
      final records = <AttendanceRecord>[];
      final statuses = ['Present', 'Absent', 'Late', 'Excused'];
      final subjects = [1, 2, 3, 4];

      for (int i = 0; i < 20; i++) {
        final DateTime date = DateTime.now().subtract(Duration(days: i));
        records.add(
          AttendanceRecord(
            id: i,
            studentId: 1,
            subjectId: subjectId ?? subjects[i % subjects.length],
            date: date.toString().split(' ').first,
            status: statuses[i % statuses.length],
            remarks: i % 3 == 0 ? 'Late due to traffic' : null,
          ),
        );
      }
      return records;
    } else {
      // TODO: Implement real API call
      throw UnimplementedError('Real API implementation pending');
    }
  }

  @override
  Future<AttendanceSummary> getAttendanceSummary() async {
    if (Config.USE_MOCK_DATA) {
      await Future.delayed(const Duration(milliseconds: 500));

      return AttendanceSummary(
        studentId: 1,
        overallPercentage: 85.5,
        totalClasses: 80,
        presentDays: 68,
        absentDays: 8,
        lateDays: 3,
        excusedDays: 1,
        subjectWiseAttendance: {
          1: SubjectAttendance(
            subjectId: 1,
            subjectName: 'Mathematics',
            attendancePercentage: 90.0,
            totalClasses: 20,
            presentClasses: 18,
          ),
          2: SubjectAttendance(
            subjectId: 2,
            subjectName: 'Physics',
            attendancePercentage: 85.0,
            totalClasses: 20,
            presentClasses: 17,
          ),
          3: SubjectAttendance(
            subjectId: 3,
            subjectName: 'Chemistry',
            attendancePercentage: 80.0,
            totalClasses: 20,
            presentClasses: 16,
          ),
          4: SubjectAttendance(
            subjectId: 4,
            subjectName: 'English',
            attendancePercentage: 87.5,
            totalClasses: 20,
            presentClasses: 17,
          ),
        },
      );
    } else {
      // TODO: Implement real API call
      throw UnimplementedError('Real API implementation pending');
    }
  }
}

// Factory constructor
AttendanceRepository createAttendanceRepository() {
  return AttendanceRepositoryImpl();
}

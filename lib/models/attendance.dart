/// Attendance record model
class AttendanceRecord {
  final int id;
  final int studentId;
  final int subjectId;
  final String date;
  final String status; // Present, Absent, Late, Excused
  final String? remarks;

  AttendanceRecord({
    required this.id,
    required this.studentId,
    required this.subjectId,
    required this.date,
    required this.status,
    this.remarks,
  });

  bool get isPresent => status == 'Present';
  bool get isAbsent => status == 'Absent';
  bool get isLate => status == 'Late';
  bool get isExcused => status == 'Excused';

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    return AttendanceRecord(
      id: json['id'] ?? 0,
      studentId: json['student_id'] ?? 0,
      subjectId: json['subject_id'] ?? 0,
      date: json['date'] ?? '',
      status: json['status'] ?? 'Present',
      remarks: json['remarks'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_id': studentId,
      'subject_id': subjectId,
      'date': date,
      'status': status,
      'remarks': remarks,
    };
  }
}

/// Attendance summary for a student
class AttendanceSummary {
  final int studentId;
  final double overallPercentage;
  final int totalClasses;
  final int presentDays;
  final int absentDays;
  final int lateDays;
  final int excusedDays;
  final Map<int, SubjectAttendance> subjectWiseAttendance;

  AttendanceSummary({
    required this.studentId,
    required this.overallPercentage,
    required this.totalClasses,
    required this.presentDays,
    required this.absentDays,
    required this.lateDays,
    required this.excusedDays,
    required this.subjectWiseAttendance,
  });

  factory AttendanceSummary.fromJson(Map<String, dynamic> json) {
    final subjectMap = <int, SubjectAttendance>{};
    if (json['subject_wise_attendance'] is List) {
      for (var item in json['subject_wise_attendance'] as List) {
        if (item is Map<String, dynamic>) {
          final subjectId = item['subject_id'] ?? 0;
          subjectMap[subjectId] = SubjectAttendance.fromJson(item);
        }
      }
    }

    return AttendanceSummary(
      studentId: json['student_id'] ?? 0,
      overallPercentage: (json['overall_percentage'] ?? 0.0).toDouble(),
      totalClasses: json['total_classes'] ?? 0,
      presentDays: json['present_days'] ?? 0,
      absentDays: json['absent_days'] ?? 0,
      lateDays: json['late_days'] ?? 0,
      excusedDays: json['excused_days'] ?? 0,
      subjectWiseAttendance: subjectMap,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'student_id': studentId,
      'overall_percentage': overallPercentage,
      'total_classes': totalClasses,
      'present_days': presentDays,
      'absent_days': absentDays,
      'late_days': lateDays,
      'excused_days': excusedDays,
      'subject_wise_attendance': subjectWiseAttendance.values.map((e) => e.toJson()).toList(),
    };
  }
}

/// Subject-wise attendance
class SubjectAttendance {
  final int subjectId;
  final String subjectName;
  final double attendancePercentage;
  final int totalClasses;
  final int presentClasses;

  SubjectAttendance({
    required this.subjectId,
    required this.subjectName,
    required this.attendancePercentage,
    required this.totalClasses,
    required this.presentClasses,
  });

  factory SubjectAttendance.fromJson(Map<String, dynamic> json) {
    return SubjectAttendance(
      subjectId: json['subject_id'] ?? 0,
      subjectName: json['subject_name'] ?? '',
      attendancePercentage: (json['attendance_percentage'] ?? 0.0).toDouble(),
      totalClasses: json['total_classes'] ?? 0,
      presentClasses: json['present_classes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subject_id': subjectId,
      'subject_name': subjectName,
      'attendance_percentage': attendancePercentage,
      'total_classes': totalClasses,
      'present_classes': presentClasses,
    };
  }
}

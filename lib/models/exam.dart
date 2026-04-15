/// Exam model
class Exam {
  final int id;
  final String name;
  final String examType; // Midterm, Final, etc.
  final int semesterId;
  final String startDate;
  final String endDate;
  final String? admitCardUrl;
  final String? notificationUrl;
  final String status; // Scheduled, Ongoing, Completed
  final List<ExamSchedule> examSchedules;

  Exam({
    required this.id,
    required this.name,
    required this.examType,
    required this.semesterId,
    required this.startDate,
    required this.endDate,
    this.admitCardUrl,
    this.notificationUrl,
    required this.status,
    required this.examSchedules,
  });

  factory Exam.fromJson(Map<String, dynamic> json) {
    final schedules = <ExamSchedule>[];
    if (json['exam_schedules'] is List) {
      schedules.addAll((json['exam_schedules'] as List).map(
            (e) => ExamSchedule.fromJson(e as Map<String, dynamic>),
          ));
    }
    return Exam(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      examType: json['exam_type'] ?? '',
      semesterId: json['semester_id'] ?? 0,
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      admitCardUrl: json['admit_card_url'],
      notificationUrl: json['notification_url'],
      status: json['status'] ?? 'Scheduled',
      examSchedules: schedules,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'exam_type': examType,
      'semester_id': semesterId,
      'start_date': startDate,
      'end_date': endDate,
      'admit_card_url': admitCardUrl,
      'notification_url': notificationUrl,
      'status': status,
      'exam_schedules': examSchedules.map((e) => e.toJson()).toList(),
    };
  }
}

/// Exam Schedule (per subject)
class ExamSchedule {
  final int id;
  final int examId;
  final int subjectId;
  final String subjectName;
  final String date;
  final String startTime;
  final String endTime;
  final String? venue;
  final String? seatNumber;
  final int? maxMarks;

  ExamSchedule({
    required this.id,
    required this.examId,
    required this.subjectId,
    required this.subjectName,
    required this.date,
    required this.startTime,
    required this.endTime,
    this.venue,
    this.seatNumber,
    this.maxMarks,
  });

  factory ExamSchedule.fromJson(Map<String, dynamic> json) {
    return ExamSchedule(
      id: json['id'] ?? 0,
      examId: json['exam_id'] ?? 0,
      subjectId: json['subject_id'] ?? 0,
      subjectName: json['subject_name'] ?? '',
      date: json['date'] ?? '',
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
      venue: json['venue'],
      seatNumber: json['seat_number'],
      maxMarks: json['max_marks'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'exam_id': examId,
      'subject_id': subjectId,
      'subject_name': subjectName,
      'date': date,
      'start_time': startTime,
      'end_time': endTime,
      'venue': venue,
      'seat_number': seatNumber,
      'max_marks': maxMarks,
    };
  }
}

/// Exam Registration model
class ExamRegistration {
  final int id;
  final int studentId;
  final int examId;
  final String registrationDate;
  final String status; // Registered, Withdrawn, Completed
  final List<SubjectRegistration> subjects;

  ExamRegistration({
    required this.id,
    required this.studentId,
    required this.examId,
    required this.registrationDate,
    required this.status,
    required this.subjects,
  });

  factory ExamRegistration.fromJson(Map<String, dynamic> json) {
    final subjects = <SubjectRegistration>[];
    if (json['subjects'] is List) {
      subjects.addAll((json['subjects'] as List).map(
            (e) => SubjectRegistration.fromJson(e as Map<String, dynamic>),
          ));
    }
    return ExamRegistration(
      id: json['id'] ?? 0,
      studentId: json['student_id'] ?? 0,
      examId: json['exam_id'] ?? 0,
      registrationDate: json['registration_date'] ?? '',
      status: json['status'] ?? 'Registered',
      subjects: subjects,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_id': studentId,
      'exam_id': examId,
      'registration_date': registrationDate,
      'status': status,
      'subjects': subjects.map((e) => e.toJson()).toList(),
    };
  }
}

/// Subject registration for exam
class SubjectRegistration {
  final int subjectId;
  final String subjectName;
  final bool isRegistered;

  SubjectRegistration({
    required this.subjectId,
    required this.subjectName,
    required this.isRegistered,
  });

  factory SubjectRegistration.fromJson(Map<String, dynamic> json) {
    return SubjectRegistration(
      subjectId: json['subject_id'] ?? 0,
      subjectName: json['subject_name'] ?? '',
      isRegistered: json['is_registered'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subject_id': subjectId,
      'subject_name': subjectName,
      'is_registered': isRegistered,
    };
  }
}

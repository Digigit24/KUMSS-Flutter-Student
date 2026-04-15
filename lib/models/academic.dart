/// Subject model
class Subject {
  final int id;
  final String code;
  final String name;
  final int credits;
  final int hoursPerWeek;
  final int semesterId;
  final int departmentId;
  final int teacherId;
  final String? syllabusUrl;
  final String? description;
  final double? maxMarks;

  Subject({
    required this.id,
    required this.code,
    required this.name,
    required this.credits,
    required this.hoursPerWeek,
    required this.semesterId,
    required this.departmentId,
    required this.teacherId,
    this.syllabusUrl,
    this.description,
    this.maxMarks,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'] ?? 0,
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      credits: json['credits'] ?? 0,
      hoursPerWeek: json['hours_per_week'] ?? 0,
      semesterId: json['semester_id'] ?? 0,
      departmentId: json['department_id'] ?? 0,
      teacherId: json['teacher_id'] ?? 0,
      syllabusUrl: json['syllabus_url'],
      description: json['description'],
      maxMarks: (json['max_marks'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'credits': credits,
      'hours_per_week': hoursPerWeek,
      'semester_id': semesterId,
      'department_id': departmentId,
      'teacher_id': teacherId,
      'syllabus_url': syllabusUrl,
      'description': description,
      'max_marks': maxMarks,
    };
  }
}

/// Timetable entry model
class TimetableEntry {
  final int id;
  final int studentId;
  final int subjectId;
  final String dayOfWeek; // Monday, Tuesday, etc.
  final String startTime; // HH:mm format
  final String endTime; // HH:mm format
  final String classType; // Lecture, Lab, Tutorial
  final String? roomNumber;
  final String? teacherName;
  final String? building;

  TimetableEntry({
    required this.id,
    required this.studentId,
    required this.subjectId,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    required this.classType,
    this.roomNumber,
    this.teacherName,
    this.building,
  });

  factory TimetableEntry.fromJson(Map<String, dynamic> json) {
    return TimetableEntry(
      id: json['id'] ?? 0,
      studentId: json['student_id'] ?? 0,
      subjectId: json['subject_id'] ?? 0,
      dayOfWeek: json['day_of_week'] ?? '',
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
      classType: json['class_type'] ?? 'Lecture',
      roomNumber: json['room_number'],
      teacherName: json['teacher_name'],
      building: json['building'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_id': studentId,
      'subject_id': subjectId,
      'day_of_week': dayOfWeek,
      'start_time': startTime,
      'end_time': endTime,
      'class_type': classType,
      'room_number': roomNumber,
      'teacher_name': teacherName,
      'building': building,
    };
  }
}

/// Lab Schedule model
class LabSchedule {
  final int id;
  final int studentId;
  final int subjectId;
  final String date;
  final String startTime;
  final String endTime;
  final String? labName;
  final String? roomNumber;
  final String? details;

  LabSchedule({
    required this.id,
    required this.studentId,
    required this.subjectId,
    required this.date,
    required this.startTime,
    required this.endTime,
    this.labName,
    this.roomNumber,
    this.details,
  });

  factory LabSchedule.fromJson(Map<String, dynamic> json) {
    return LabSchedule(
      id: json['id'] ?? 0,
      studentId: json['student_id'] ?? 0,
      subjectId: json['subject_id'] ?? 0,
      date: json['date'] ?? '',
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
      labName: json['lab_name'],
      roomNumber: json['room_number'],
      details: json['details'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_id': studentId,
      'subject_id': subjectId,
      'date': date,
      'start_time': startTime,
      'end_time': endTime,
      'lab_name': labName,
      'room_number': roomNumber,
      'details': details,
    };
  }
}

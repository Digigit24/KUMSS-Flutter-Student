/// Exam result model
class ExamResult {
  final int id;
  final int studentId;
  final int examId;
  final int semesterId;
  final String examName;
  final String resultDate;
  final double gpa;
  final String resultStatus; // Passed, Failed, Pending
  final List<SubjectResult> subjectResults;

  ExamResult({
    required this.id,
    required this.studentId,
    required this.examId,
    required this.semesterId,
    required this.examName,
    required this.resultDate,
    required this.gpa,
    required this.resultStatus,
    required this.subjectResults,
  });

  factory ExamResult.fromJson(Map<String, dynamic> json) {
    final results = <SubjectResult>[];
    if (json['subject_results'] is List) {
      results.addAll((json['subject_results'] as List).map(
            (e) => SubjectResult.fromJson(e as Map<String, dynamic>),
          ));
    }
    return ExamResult(
      id: json['id'] ?? 0,
      studentId: json['student_id'] ?? 0,
      examId: json['exam_id'] ?? 0,
      semesterId: json['semester_id'] ?? 0,
      examName: json['exam_name'] ?? '',
      resultDate: json['result_date'] ?? '',
      gpa: (json['gpa'] ?? 0.0).toDouble(),
      resultStatus: json['result_status'] ?? 'Pending',
      subjectResults: results,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_id': studentId,
      'exam_id': examId,
      'semester_id': semesterId,
      'exam_name': examName,
      'result_date': resultDate,
      'gpa': gpa,
      'result_status': resultStatus,
      'subject_results': subjectResults.map((e) => e.toJson()).toList(),
    };
  }
}

/// Subject-wise result
class SubjectResult {
  final int subjectId;
  final String subjectCode;
  final String subjectName;
  final double marksObtained;
  final double maxMarks;
  final double percentage;
  final String grade;
  final double gradePoint;
  final int credits;

  SubjectResult({
    required this.subjectId,
    required this.subjectCode,
    required this.subjectName,
    required this.marksObtained,
    required this.maxMarks,
    required this.percentage,
    required this.grade,
    required this.gradePoint,
    required this.credits,
  });

  bool get isPassed => grade != 'F';

  factory SubjectResult.fromJson(Map<String, dynamic> json) {
    return SubjectResult(
      subjectId: json['subject_id'] ?? 0,
      subjectCode: json['subject_code'] ?? '',
      subjectName: json['subject_name'] ?? '',
      marksObtained: (json['marks_obtained'] ?? 0.0).toDouble(),
      maxMarks: (json['max_marks'] ?? 0.0).toDouble(),
      percentage: (json['percentage'] ?? 0.0).toDouble(),
      grade: json['grade'] ?? 'NA',
      gradePoint: (json['grade_point'] ?? 0.0).toDouble(),
      credits: json['credits'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subject_id': subjectId,
      'subject_code': subjectCode,
      'subject_name': subjectName,
      'marks_obtained': marksObtained,
      'max_marks': maxMarks,
      'percentage': percentage,
      'grade': grade,
      'grade_point': gradePoint,
      'credits': credits,
    };
  }
}

/// Report card / Semester performance
class ReportCard {
  final int id;
  final int studentId;
  final int semesterId;
  final String semesterName;
  final String academicYear;
  final double semesterGPA;
  final double cumulativeGPA;
  final String reportCardUrl;
  final List<SubjectResult> subjectResults;

  ReportCard({
    required this.id,
    required this.studentId,
    required this.semesterId,
    required this.semesterName,
    required this.academicYear,
    required this.semesterGPA,
    required this.cumulativeGPA,
    required this.reportCardUrl,
    required this.subjectResults,
  });

  factory ReportCard.fromJson(Map<String, dynamic> json) {
    final results = <SubjectResult>[];
    if (json['subject_results'] is List) {
      results.addAll((json['subject_results'] as List).map(
            (e) => SubjectResult.fromJson(e as Map<String, dynamic>),
          ));
    }
    return ReportCard(
      id: json['id'] ?? 0,
      studentId: json['student_id'] ?? 0,
      semesterId: json['semester_id'] ?? 0,
      semesterName: json['semester_name'] ?? '',
      academicYear: json['academic_year'] ?? '',
      semesterGPA: (json['semester_gpa'] ?? 0.0).toDouble(),
      cumulativeGPA: (json['cumulative_gpa'] ?? 0.0).toDouble(),
      reportCardUrl: json['report_card_url'] ?? '',
      subjectResults: results,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_id': studentId,
      'semester_id': semesterId,
      'semester_name': semesterName,
      'academic_year': academicYear,
      'semester_gpa': semesterGPA,
      'cumulative_gpa': cumulativeGPA,
      'report_card_url': reportCardUrl,
      'subject_results': subjectResults.map((e) => e.toJson()).toList(),
    };
  }
}

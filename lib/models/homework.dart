/// Homework model
class Homework {
  final int id;
  final int subjectId;
  final int teacherId;
  final String title;
  final String description;
  final String dueDate;
  final String status; // Pending, Submitted, Graded
  final String createdAt;
  final int? maxMarks;
  final String? attachmentUrl;

  Homework({
    required this.id,
    required this.subjectId,
    required this.teacherId,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.status,
    required this.createdAt,
    this.maxMarks,
    this.attachmentUrl,
  });

  bool get isPending => status == 'Pending';
  bool get isSubmitted => status == 'Submitted';
  bool get isGraded => status == 'Graded';

  factory Homework.fromJson(Map<String, dynamic> json) {
    return Homework(
      id: json['id'] ?? 0,
      subjectId: json['subject_id'] ?? 0,
      teacherId: json['teacher_id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      dueDate: json['due_date'] ?? '',
      status: json['status'] ?? 'Pending',
      createdAt: json['created_at'] ?? '',
      maxMarks: json['max_marks'],
      attachmentUrl: json['attachment_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject_id': subjectId,
      'teacher_id': teacherId,
      'title': title,
      'description': description,
      'due_date': dueDate,
      'status': status,
      'created_at': createdAt,
      'max_marks': maxMarks,
      'attachment_url': attachmentUrl,
    };
  }
}

/// Homework submission model
class HomeworkSubmission {
  final int id;
  final int homeworkId;
  final int studentId;
  final String submissionText;
  final String? attachmentUrl;
  final String submittedAt;
  final bool isLateSubmission;
  final String status; // Submitted, Graded
  final int? marksObtained;
  final int? maxMarks;
  final String? feedbackText;

  HomeworkSubmission({
    required this.id,
    required this.homeworkId,
    required this.studentId,
    required this.submissionText,
    this.attachmentUrl,
    required this.submittedAt,
    required this.isLateSubmission,
    required this.status,
    this.marksObtained,
    this.maxMarks,
    this.feedbackText,
  });

  factory HomeworkSubmission.fromJson(Map<String, dynamic> json) {
    return HomeworkSubmission(
      id: json['id'] ?? 0,
      homeworkId: json['homework_id'] ?? 0,
      studentId: json['student_id'] ?? 0,
      submissionText: json['submission_text'] ?? '',
      attachmentUrl: json['attachment_url'],
      submittedAt: json['submitted_at'] ?? '',
      isLateSubmission: json['is_late_submission'] ?? false,
      status: json['status'] ?? 'Submitted',
      marksObtained: json['marks_obtained'],
      maxMarks: json['max_marks'],
      feedbackText: json['feedback_text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'homework_id': homeworkId,
      'student_id': studentId,
      'submission_text': submissionText,
      'attachment_url': attachmentUrl,
      'submitted_at': submittedAt,
      'is_late_submission': isLateSubmission,
      'status': status,
      'marks_obtained': marksObtained,
      'max_marks': maxMarks,
      'feedback_text': feedbackText,
    };
  }
}

/// Assignment model
class Assignment {
  final int id;
  final int subjectId;
  final String title;
  final String description;
  final String dueDate;
  final int maxMarks;
  final String? attachmentUrl;
  final String status; // Pending, Submitted, Graded, Overdue
  final String createdAt;
  final String? feedbackText;
  final int? obtainedMarks;
  final String? submissionId;

  Assignment({
    required this.id,
    required this.subjectId,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.maxMarks,
    this.attachmentUrl,
    required this.status,
    required this.createdAt,
    this.feedbackText,
    this.obtainedMarks,
    this.submissionId,
  });

  bool get isPending => status == 'Pending';
  bool get isSubmitted => status == 'Submitted';
  bool get isGraded => status == 'Graded';
  bool get isOverdue => status == 'Overdue';

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      id: json['id'] ?? 0,
      subjectId: json['subject_id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      dueDate: json['due_date'] ?? '',
      maxMarks: json['max_marks'] ?? 0,
      attachmentUrl: json['attachment_url'],
      status: json['status'] ?? 'Pending',
      createdAt: json['created_at'] ?? '',
      feedbackText: json['feedback_text'],
      obtainedMarks: json['obtained_marks'],
      submissionId: json['submission_id']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject_id': subjectId,
      'title': title,
      'description': description,
      'due_date': dueDate,
      'max_marks': maxMarks,
      'attachment_url': attachmentUrl,
      'status': status,
      'created_at': createdAt,
      'feedback_text': feedbackText,
      'obtained_marks': obtainedMarks,
      'submission_id': submissionId,
    };
  }
}

/// Assignment submission model
class AssignmentSubmission {
  final int id;
  final int assignmentId;
  final int studentId;
  final String? submissionText;
  final String? attachmentUrl;
  final String submittedAt;
  final bool isLateSubmission;
  final int? latePenalty;
  final String status; // Submitted, Graded, Pending Review
  final int? marksObtained;
  final String? feedbackText;

  AssignmentSubmission({
    required this.id,
    required this.assignmentId,
    required this.studentId,
    this.submissionText,
    this.attachmentUrl,
    required this.submittedAt,
    required this.isLateSubmission,
    this.latePenalty,
    required this.status,
    this.marksObtained,
    this.feedbackText,
  });

  factory AssignmentSubmission.fromJson(Map<String, dynamic> json) {
    return AssignmentSubmission(
      id: json['id'] ?? 0,
      assignmentId: json['assignment_id'] ?? 0,
      studentId: json['student_id'] ?? 0,
      submissionText: json['submission_text'],
      attachmentUrl: json['attachment_url'],
      submittedAt: json['submitted_at'] ?? '',
      isLateSubmission: json['is_late_submission'] ?? false,
      latePenalty: json['late_penalty'],
      status: json['status'] ?? 'Submitted',
      marksObtained: json['marks_obtained'],
      feedbackText: json['feedback_text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'assignment_id': assignmentId,
      'student_id': studentId,
      'submission_text': submissionText,
      'attachment_url': attachmentUrl,
      'submitted_at': submittedAt,
      'is_late_submission': isLateSubmission,
      'late_penalty': latePenalty,
      'status': status,
      'marks_obtained': marksObtained,
      'feedback_text': feedbackText,
    };
  }
}

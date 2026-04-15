import '../models/assignment.dart';
import '../services/config.dart';

abstract class AssignmentRepository {
  Future<List<Assignment>> getAssignments({String? status});
  Future<Assignment> getAssignmentDetail(int assignmentId);
  Future<AssignmentSubmission> submitAssignment(
    int assignmentId,
    String? text,
    String? fileUrl,
  );
}

class AssignmentRepositoryImpl implements AssignmentRepository {
  @override
  Future<List<Assignment>> getAssignments({String? status}) async {
    if (Config.USE_MOCK_DATA) {
      await Future.delayed(const Duration(milliseconds: 500));

      final assignments = [
        Assignment(
          id: 1,
          subjectId: 1,
          title: 'Array Implementation',
          description: 'Implement dynamic array with resize functionality',
          dueDate: DateTime.now().subtract(const Duration(days: 2)).toString().split(' ').first,
          maxMarks: 10,
          status: 'Overdue',
          createdAt: DateTime.now().subtract(const Duration(days: 10)).toString().split(' ').first,
        ),
        Assignment(
          id: 2,
          subjectId: 1,
          title: 'Linked List Operations',
          description: 'Implement singly linked list with insert, delete, search',
          dueDate: DateTime.now().add(const Duration(days: 3)).toString().split(' ').first,
          maxMarks: 10,
          status: 'Pending',
          createdAt: DateTime.now().subtract(const Duration(days: 5)).toString().split(' ').first,
        ),
        Assignment(
          id: 3,
          subjectId: 2,
          title: 'Database Design',
          description: 'Design E-R diagram for e-commerce platform',
          dueDate: DateTime.now().subtract(const Duration(days: 1)).toString().split(' ').first,
          maxMarks: 15,
          status: 'Submitted',
          createdAt: DateTime.now().subtract(const Duration(days: 7)).toString().split(' ').first,
          submissionId: '101',
        ),
        Assignment(
          id: 4,
          subjectId: 3,
          title: 'Process Scheduling Simulation',
          description: 'Simulate FCFS, SJF, and Round Robin scheduling',
          dueDate: DateTime.now().subtract(const Duration(days: 5)).toString().split(' ').first,
          maxMarks: 20,
          status: 'Graded',
          createdAt: DateTime.now().subtract(const Duration(days: 14)).toString().split(' ').first,
          obtainedMarks: 18,
          feedbackText: 'Excellent implementation with good documentation',
        ),
      ];

      if (status != null) {
        return assignments.where((a) => a.status == status).toList();
      }
      return assignments;
    } else {
      // TODO: Implement real API call
      throw UnimplementedError('Real API implementation pending');
    }
  }

  @override
  Future<Assignment> getAssignmentDetail(int assignmentId) async {
    if (Config.USE_MOCK_DATA) {
      await Future.delayed(const Duration(milliseconds: 500));

      return Assignment(
        id: assignmentId,
        subjectId: 1,
        title: 'Linked List Operations',
        description:
            'Implement a complete singly linked list with the following operations:\n1. Insert at beginning\n2. Insert at end\n3. Delete from position\n4. Search for element\n5. Display list',
        dueDate: DateTime.now().add(const Duration(days: 3)).toString().split(' ').first,
        maxMarks: 10,
        attachmentUrl: 'https://via.placeholder.com/assignment.pdf',
        status: 'Pending',
        createdAt: DateTime.now().subtract(const Duration(days: 5)).toString().split(' ').first,
      );
    } else {
      // TODO: Implement real API call
      throw UnimplementedError('Real API implementation pending');
    }
  }

  @override
  Future<AssignmentSubmission> submitAssignment(
    int assignmentId,
    String? text,
    String? fileUrl,
  ) async {
    if (Config.USE_MOCK_DATA) {
      await Future.delayed(const Duration(milliseconds: 500));

      return AssignmentSubmission(
        id: 1,
        assignmentId: assignmentId,
        studentId: 1,
        submissionText: text,
        attachmentUrl: fileUrl,
        submittedAt: DateTime.now().toString().split(' ').first,
        isLateSubmission: false,
        status: 'Submitted',
      );
    } else {
      // TODO: Implement real API call
      throw UnimplementedError('Real API implementation pending');
    }
  }
}

// Factory constructor
AssignmentRepository createAssignmentRepository() {
  return AssignmentRepositoryImpl();
}

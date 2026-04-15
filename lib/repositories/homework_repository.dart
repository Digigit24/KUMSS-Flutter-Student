import '../models/homework.dart';
import '../services/config.dart';

abstract class HomeworkRepository {
  Future<List<Homework>> getHomework({String? status, int? subjectId});
  Future<Homework> getHomeworkDetail(int homeworkId);
  Future<HomeworkSubmission> submitHomework(
    int homeworkId,
    String text,
    String? fileUrl,
  );
}

class HomeworkRepositoryImpl implements HomeworkRepository {
  @override
  Future<List<Homework>> getHomework({String? status, int? subjectId}) async {
    if (Config.USE_MOCK_DATA) {
      await Future.delayed(const Duration(milliseconds: 500));

      final homework = [
        Homework(
          id: 1,
          subjectId: 1,
          teacherId: 101,
          title: 'Array Problems',
          description: 'Solve 5 problems on array manipulation from textbook page 45-50',
          dueDate: DateTime.now().add(const Duration(days: 2)).toString().split(' ').first,
          status: 'Pending',
          createdAt: DateTime.now().subtract(const Duration(days: 3)).toString().split(' ').first,
          maxMarks: 5,
        ),
        Homework(
          id: 2,
          subjectId: 2,
          teacherId: 102,
          title: 'SQL Queries',
          description: 'Write SQL queries for the given scenarios',
          dueDate: DateTime.now().subtract(const Duration(days: 1)).toString().split(' ').first,
          status: 'Pending',
          createdAt: DateTime.now().subtract(const Duration(days: 4)).toString().split(' ').first,
          maxMarks: 10,
        ),
        Homework(
          id: 3,
          subjectId: 1,
          teacherId: 101,
          title: 'Linked List Implementation',
          description: 'Implement a linked list with basic operations',
          dueDate: DateTime.now().subtract(const Duration(days: 5)).toString().split(' ').first,
          status: 'Submitted',
          createdAt: DateTime.now().subtract(const Duration(days: 7)).toString().split(' ').first,
          maxMarks: 10,
        ),
      ];

      var filtered = homework;
      if (status != null) {
        filtered = filtered.where((h) => h.status == status).toList();
      }
      if (subjectId != null) {
        filtered = filtered.where((h) => h.subjectId == subjectId).toList();
      }
      return filtered;
    } else {
      // TODO: Implement real API call
      throw UnimplementedError('Real API implementation pending');
    }
  }

  @override
  Future<Homework> getHomeworkDetail(int homeworkId) async {
    if (Config.USE_MOCK_DATA) {
      await Future.delayed(const Duration(milliseconds: 500));

      return Homework(
        id: homeworkId,
        subjectId: 1,
        teacherId: 101,
        title: 'Array Problems',
        description: 'Solve the following 5 problems on array manipulation:\n1. Find maximum element\n2. Rotate array\n3. Find duplicates\n4. Merge sorted arrays\n5. Remove duplicates',
        dueDate: DateTime.now().add(const Duration(days: 2)).toString().split(' ').first,
        status: 'Pending',
        createdAt: DateTime.now().subtract(const Duration(days: 3)).toString().split(' ').first,
        maxMarks: 5,
        attachmentUrl: 'https://via.placeholder.com/homework.pdf',
      );
    } else {
      // TODO: Implement real API call
      throw UnimplementedError('Real API implementation pending');
    }
  }

  @override
  Future<HomeworkSubmission> submitHomework(
    int homeworkId,
    String text,
    String? fileUrl,
  ) async {
    if (Config.USE_MOCK_DATA) {
      await Future.delayed(const Duration(milliseconds: 500));

      return HomeworkSubmission(
        id: 1,
        homeworkId: homeworkId,
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
HomeworkRepository createHomeworkRepository() {
  return HomeworkRepositoryImpl();
}

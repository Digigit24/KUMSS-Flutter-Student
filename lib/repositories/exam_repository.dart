import '../models/exam.dart';
import '../services/config.dart';

abstract class ExamRepository {
  Future<List<Exam>> getExams();
  Future<Exam> getExamDetail(int examId);
  Future<ExamRegistration> registerForExam(int examId, List<int> subjectIds);
  Future<ExamRegistration> getRegistration(int examId);
}

class ExamRepositoryImpl implements ExamRepository {
  @override
  Future<List<Exam>> getExams() async {
    if (Config.USE_MOCK_DATA) {
      await Future.delayed(const Duration(milliseconds: 500));

      return [
        Exam(
          id: 1,
          name: 'Mid Semester Exam',
          examType: 'Midterm',
          semesterId: 6,
          startDate: DateTime.now().add(const Duration(days: 15)).toString().split(' ').first,
          endDate: DateTime.now().add(const Duration(days: 25)).toString().split(' ').first,
          status: 'Scheduled',
          examSchedules: [
            ExamSchedule(
              id: 1,
              examId: 1,
              subjectId: 1,
              subjectName: 'Data Structures',
              date: DateTime.now().add(const Duration(days: 15)).toString().split(' ').first,
              startTime: '09:00',
              endTime: '11:00',
              venue: 'Exam Hall A',
              maxMarks: 50,
            ),
          ],
        ),
        Exam(
          id: 2,
          name: 'End Semester Exam',
          examType: 'Final',
          semesterId: 6,
          startDate: DateTime.now().add(const Duration(days: 60)).toString().split(' ').first,
          endDate: DateTime.now().add(const Duration(days: 75)).toString().split(' ').first,
          status: 'Scheduled',
          examSchedules: [],
        ),
      ];
    } else {
      // TODO: Implement real API call
      throw UnimplementedError('Real API implementation pending');
    }
  }

  @override
  Future<Exam> getExamDetail(int examId) async {
    if (Config.USE_MOCK_DATA) {
      await Future.delayed(const Duration(milliseconds: 500));

      return Exam(
        id: examId,
        name: 'Mid Semester Exam',
        examType: 'Midterm',
        semesterId: 6,
        startDate: DateTime.now().add(const Duration(days: 15)).toString().split(' ').first,
        endDate: DateTime.now().add(const Duration(days: 25)).toString().split(' ').first,
        status: 'Scheduled',
        examSchedules: [
          ExamSchedule(
            id: 1,
            examId: examId,
            subjectId: 1,
            subjectName: 'Data Structures',
            date: DateTime.now().add(const Duration(days: 15)).toString().split(' ').first,
            startTime: '09:00',
            endTime: '11:00',
            venue: 'Exam Hall A',
            seatNumber: 'A-15',
            maxMarks: 50,
          ),
        ],
      );
    } else {
      // TODO: Implement real API call
      throw UnimplementedError('Real API implementation pending');
    }
  }

  @override
  Future<ExamRegistration> registerForExam(int examId, List<int> subjectIds) async {
    if (Config.USE_MOCK_DATA) {
      await Future.delayed(const Duration(milliseconds: 500));

      return ExamRegistration(
        id: 1,
        studentId: 1,
        examId: examId,
        registrationDate: DateTime.now().toString().split(' ').first,
        status: 'Registered',
        subjects: subjectIds
            .map(
              (id) => SubjectRegistration(
                subjectId: id,
                subjectName: 'Subject $id',
                isRegistered: true,
              ),
            )
            .toList(),
      );
    } else {
      // TODO: Implement real API call
      throw UnimplementedError('Real API implementation pending');
    }
  }

  @override
  Future<ExamRegistration> getRegistration(int examId) async {
    if (Config.USE_MOCK_DATA) {
      await Future.delayed(const Duration(milliseconds: 500));

      return ExamRegistration(
        id: 1,
        studentId: 1,
        examId: examId,
        registrationDate: DateTime.now().subtract(const Duration(days: 5)).toString().split(' ').first,
        status: 'Registered',
        subjects: [
          SubjectRegistration(subjectId: 1, subjectName: 'Data Structures', isRegistered: true),
          SubjectRegistration(subjectId: 2, subjectName: 'Database Management', isRegistered: true),
          SubjectRegistration(subjectId: 3, subjectName: 'Operating Systems', isRegistered: true),
        ],
      );
    } else {
      // TODO: Implement real API call
      throw UnimplementedError('Real API implementation pending');
    }
  }
}

// Factory constructor
ExamRepository createExamRepository() {
  return ExamRepositoryImpl();
}

import '../models/result.dart';
import '../services/config.dart';

abstract class ResultRepository {
  Future<List<ExamResult>> getExamResults();
  Future<ExamResult> getExamResult(int resultId);
  Future<List<ReportCard>> getReportCards();
  Future<ReportCard> getReportCard(int reportCardId);
}

class ResultRepositoryImpl implements ResultRepository {
  @override
  Future<List<ExamResult>> getExamResults() async {
    if (Config.USE_MOCK_DATA) {
      await Future.delayed(const Duration(milliseconds: 500));

      return [
        ExamResult(
          id: 1,
          studentId: 1,
          examId: 1,
          semesterId: 5,
          examName: 'Mid Semester Exam - Sem 5',
          resultDate: '2024-03-15',
          gpa: 3.7,
          resultStatus: 'Passed',
          subjectResults: [
            SubjectResult(
              subjectId: 1,
              subjectCode: 'CS201',
              subjectName: 'Data Structures',
              marksObtained: 42,
              maxMarks: 50,
              percentage: 84,
              grade: 'A',
              gradePoint: 4.0,
              credits: 4,
            ),
          ],
        ),
      ];
    } else {
      // TODO: Implement real API call
      throw UnimplementedError('Real API implementation pending');
    }
  }

  @override
  Future<ExamResult> getExamResult(int resultId) async {
    if (Config.USE_MOCK_DATA) {
      await Future.delayed(const Duration(milliseconds: 500));

      return ExamResult(
        id: resultId,
        studentId: 1,
        examId: 1,
        semesterId: 5,
        examName: 'Mid Semester Exam - Sem 5',
        resultDate: '2024-03-15',
        gpa: 3.7,
        resultStatus: 'Passed',
        subjectResults: [
          SubjectResult(
            subjectId: 1,
            subjectCode: 'CS201',
            subjectName: 'Data Structures',
            marksObtained: 42,
            maxMarks: 50,
            percentage: 84,
            grade: 'A',
            gradePoint: 4.0,
            credits: 4,
          ),
          SubjectResult(
            subjectId: 2,
            subjectCode: 'CS202',
            subjectName: 'Database Management',
            marksObtained: 38,
            maxMarks: 50,
            percentage: 76,
            grade: 'B+',
            gradePoint: 3.5,
            credits: 3,
          ),
        ],
      );
    } else {
      // TODO: Implement real API call
      throw UnimplementedError('Real API implementation pending');
    }
  }

  @override
  Future<List<ReportCard>> getReportCards() async {
    if (Config.USE_MOCK_DATA) {
      await Future.delayed(const Duration(milliseconds: 500));

      return [
        ReportCard(
          id: 1,
          studentId: 1,
          semesterId: 5,
          semesterName: 'Semester 5',
          academicYear: '2023-2024',
          semesterGPA: 3.7,
          cumulativeGPA: 3.65,
          reportCardUrl: 'https://via.placeholder.com/reportcard.pdf',
          subjectResults: [
            SubjectResult(
              subjectId: 1,
              subjectCode: 'CS201',
              subjectName: 'Data Structures',
              marksObtained: 85,
              maxMarks: 100,
              percentage: 85,
              grade: 'A',
              gradePoint: 4.0,
              credits: 4,
            ),
          ],
        ),
      ];
    } else {
      // TODO: Implement real API call
      throw UnimplementedError('Real API implementation pending');
    }
  }

  @override
  Future<ReportCard> getReportCard(int reportCardId) async {
    if (Config.USE_MOCK_DATA) {
      await Future.delayed(const Duration(milliseconds: 500));

      return ReportCard(
        id: reportCardId,
        studentId: 1,
        semesterId: 5,
        semesterName: 'Semester 5',
        academicYear: '2023-2024',
        semesterGPA: 3.7,
        cumulativeGPA: 3.65,
        reportCardUrl: 'https://via.placeholder.com/reportcard.pdf',
        subjectResults: [
          SubjectResult(
            subjectId: 1,
            subjectCode: 'CS201',
            subjectName: 'Data Structures',
            marksObtained: 85,
            maxMarks: 100,
            percentage: 85,
            grade: 'A',
            gradePoint: 4.0,
            credits: 4,
          ),
        ],
      );
    } else {
      // TODO: Implement real API call
      throw UnimplementedError('Real API implementation pending');
    }
  }
}

// Factory constructor
ResultRepository createResultRepository() {
  return ResultRepositoryImpl();
}

import '../models/academic.dart';
import '../services/config.dart';

abstract class AcademicRepository {
  Future<List<Subject>> getEnrolledSubjects();
  Future<Subject> getSubjectDetail(int subjectId);
  Future<List<TimetableEntry>> getTimetable();
  Future<List<LabSchedule>> getLabSchedules();
}

class AcademicRepositoryImpl implements AcademicRepository {
  @override
  Future<List<Subject>> getEnrolledSubjects() async {
    if (Config.USE_MOCK_DATA) {
      await Future.delayed(const Duration(milliseconds: 500));

      return [
        Subject(
          id: 1,
          code: 'CS201',
          name: 'Data Structures',
          credits: 4,
          hoursPerWeek: 4,
          semesterId: 6,
          departmentId: 1,
          teacherId: 101,
          syllabusUrl: 'https://via.placeholder.com/syllabus',
          description: 'Study of arrays, linked lists, trees, and graphs',
          maxMarks: 100,
        ),
        Subject(
          id: 2,
          code: 'CS202',
          name: 'Database Management',
          credits: 3,
          hoursPerWeek: 3,
          semesterId: 6,
          departmentId: 1,
          teacherId: 102,
          syllabusUrl: 'https://via.placeholder.com/syllabus',
          description: 'SQL, Normalization, ACID properties',
          maxMarks: 100,
        ),
        Subject(
          id: 3,
          code: 'CS203',
          name: 'Operating Systems',
          credits: 4,
          hoursPerWeek: 4,
          semesterId: 6,
          departmentId: 1,
          teacherId: 103,
          syllabusUrl: 'https://via.placeholder.com/syllabus',
          description: 'Process management, Memory management, Scheduling',
          maxMarks: 100,
        ),
        Subject(
          id: 4,
          code: 'CS204',
          name: 'Web Development',
          credits: 3,
          hoursPerWeek: 3,
          semesterId: 6,
          departmentId: 1,
          teacherId: 104,
          syllabusUrl: 'https://via.placeholder.com/syllabus',
          description: 'HTML, CSS, JavaScript, React',
          maxMarks: 100,
        ),
      ];
    } else {
      // TODO: Implement real API call
      throw UnimplementedError('Real API implementation pending');
    }
  }

  @override
  Future<Subject> getSubjectDetail(int subjectId) async {
    if (Config.USE_MOCK_DATA) {
      await Future.delayed(const Duration(milliseconds: 500));

      return Subject(
        id: subjectId,
        code: 'CS201',
        name: 'Data Structures',
        credits: 4,
        hoursPerWeek: 4,
        semesterId: 6,
        departmentId: 1,
        teacherId: 101,
        syllabusUrl: 'https://via.placeholder.com/syllabus',
        description: 'Comprehensive study of data structures including arrays, linked lists, stacks, queues, trees, graphs, and their applications.',
        maxMarks: 100,
      );
    } else {
      // TODO: Implement real API call
      throw UnimplementedError('Real API implementation pending');
    }
  }

  @override
  Future<List<TimetableEntry>> getTimetable() async {
    if (Config.USE_MOCK_DATA) {
      await Future.delayed(const Duration(milliseconds: 500));

      final entries = <TimetableEntry>[];
      final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
      final times = [
        ('09:00', '10:00'),
        ('10:00', '11:00'),
        ('11:15', '12:15'),
        ('13:00', '14:00'),
        ('14:00', '15:00'),
      ];
      final types = ['Lecture', 'Lecture', 'Lecture', 'Lab', 'Lab'];
      final subjects = [1, 2, 3, 4, 1];

      int entryId = 0;
      for (var dayIndex = 0; dayIndex < days.length; dayIndex++) {
        for (var timeIndex = 0; timeIndex < times.length; timeIndex++) {
          entries.add(
            TimetableEntry(
              id: entryId++,
              studentId: 1,
              subjectId: subjects[timeIndex],
              dayOfWeek: days[dayIndex],
              startTime: times[timeIndex].$1,
              endTime: times[timeIndex].$2,
              classType: types[timeIndex],
              roomNumber: 'Room ${101 + (dayIndex * 5 + timeIndex)}',
              teacherName: 'Dr. ${['Smith', 'Johnson', 'Williams', 'Brown', 'Jones'][timeIndex]}',
              building: 'Building ${(dayIndex % 3) + 1}',
            ),
          );
        }
      }
      return entries;
    } else {
      // TODO: Implement real API call
      throw UnimplementedError('Real API implementation pending');
    }
  }

  @override
  Future<List<LabSchedule>> getLabSchedules() async {
    if (Config.USE_MOCK_DATA) {
      await Future.delayed(const Duration(milliseconds: 500));

      return [
        LabSchedule(
          id: 1,
          studentId: 1,
          subjectId: 3,
          date: DateTime.now().add(const Duration(days: 2)).toString().split(' ').first,
          startTime: '14:00',
          endTime: '16:00',
          labName: 'CS Lab 1',
          roomNumber: 'Lab 101',
          details: 'OS Lab - Process Management Simulation',
        ),
        LabSchedule(
          id: 2,
          studentId: 1,
          subjectId: 4,
          date: DateTime.now().add(const Duration(days: 4)).toString().split(' ').first,
          startTime: '10:00',
          endTime: '12:00',
          labName: 'Web Dev Lab',
          roomNumber: 'Lab 202',
          details: 'Web Development - React Components',
        ),
        LabSchedule(
          id: 3,
          studentId: 1,
          subjectId: 1,
          date: DateTime.now().add(const Duration(days: 7)).toString().split(' ').first,
          startTime: '15:00',
          endTime: '17:00',
          labName: 'CS Lab 1',
          roomNumber: 'Lab 101',
          details: 'Data Structures - Tree Traversal Implementation',
        ),
      ];
    } else {
      // TODO: Implement real API call
      throw UnimplementedError('Real API implementation pending');
    }
  }
}

// Factory constructor
AcademicRepository createAcademicRepository() {
  return AcademicRepositoryImpl();
}

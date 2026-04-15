import '../models/notice.dart';
import '../services/config.dart';

abstract class NoticeRepository {
  Future<List<Notice>> getNotices({String? category, String? priority});
  Future<Notice> getNoticeDetail(int noticeId);
  Future<List<Notice>> getPinnedNotices();
}

class NoticeRepositoryImpl implements NoticeRepository {
  @override
  Future<List<Notice>> getNotices({String? category, String? priority}) async {
    if (Config.USE_MOCK_DATA) {
      await Future.delayed(const Duration(milliseconds: 500));

      final notices = [
        Notice(
          id: 1,
          title: 'Mid Semester Exam Schedule Released',
          content: 'The mid-semester exam schedule for Semester 6 has been released. Please check the examination portal for details.',
          category: 'Academic',
          priority: 'Urgent',
          createdAt: DateTime.now().subtract(const Duration(days: 2)).toString().split(' ').first,
          validFrom: DateTime.now().subtract(const Duration(days: 2)).toString().split(' ').first,
          validTill: DateTime.now().add(const Duration(days: 20)).toString().split(' ').first,
          isPinned: true,
          views: 245,
          createdBy: 'Academic Department',
        ),
        Notice(
          id: 2,
          title: 'Library Timings Updated',
          content: 'The library will remain closed on weekends effective from next week.',
          category: 'General',
          priority: 'Normal',
          createdAt: DateTime.now().subtract(const Duration(days: 1)).toString().split(' ').first,
          validFrom: DateTime.now().subtract(const Duration(days: 1)).toString().split(' ').first,
          isPinned: false,
          views: 128,
          createdBy: 'Library',
        ),
        Notice(
          id: 3,
          title: 'Annual Fest Registration Open',
          content: 'Register for the Annual Fest 2024! Participate in various events and win exciting prizes.',
          category: 'Event',
          priority: 'High',
          createdAt: DateTime.now().subtract(const Duration(days: 5)).toString().split(' ').first,
          validFrom: DateTime.now().subtract(const Duration(days: 5)).toString().split(' ').first,
          validTill: DateTime.now().add(const Duration(days: 10)).toString().split(' ').first,
          isPinned: true,
          views: 456,
          createdBy: 'Student Activities',
        ),
      ];

      var filtered = notices;
      if (category != null) {
        filtered = filtered.where((n) => n.category == category).toList();
      }
      if (priority != null) {
        filtered = filtered.where((n) => n.priority == priority).toList();
      }
      return filtered;
    } else {
      // TODO: Implement real API call
      throw UnimplementedError('Real API implementation pending');
    }
  }

  @override
  Future<Notice> getNoticeDetail(int noticeId) async {
    if (Config.USE_MOCK_DATA) {
      await Future.delayed(const Duration(milliseconds: 500));

      return Notice(
        id: noticeId,
        title: 'Mid Semester Exam Schedule Released',
        content:
            'The mid-semester exam schedule for Semester 6 has been released. Please check the examination portal for details.\n\nExam Schedule:\n- Data Structures: March 15, 09:00 AM\n- Database Management: March 17, 10:00 AM\n- Operating Systems: March 19, 02:00 PM\n- Web Development: March 21, 09:00 AM\n\nPlease report 15 minutes before the exam time.',
        category: 'Academic',
        priority: 'Urgent',
        createdAt: DateTime.now().subtract(const Duration(days: 2)).toString().split(' ').first,
        validFrom: DateTime.now().subtract(const Duration(days: 2)).toString().split(' ').first,
        validTill: DateTime.now().add(const Duration(days: 20)).toString().split(' ').first,
        isPinned: true,
        attachmentUrl: 'https://via.placeholder.com/exam_schedule.pdf',
        attachmentFileName: 'exam_schedule.pdf',
        views: 245,
        createdBy: 'Academic Department',
      );
    } else {
      // TODO: Implement real API call
      throw UnimplementedError('Real API implementation pending');
    }
  }

  @override
  Future<List<Notice>> getPinnedNotices() async {
    if (Config.USE_MOCK_DATA) {
      final all = await getNotices();
      return all.where((n) => n.isPinned).toList();
    } else {
      // TODO: Implement real API call
      throw UnimplementedError('Real API implementation pending');
    }
  }
}

// Factory constructor
NoticeRepository createNoticeRepository() {
  return NoticeRepositoryImpl();
}

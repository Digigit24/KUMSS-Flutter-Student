import '../models/dashboard.dart';
import '../services/config.dart';

abstract class DashboardRepository {
  Future<DashboardStats> getDashboardStats();
}

class DashboardRepositoryImpl implements DashboardRepository {
  @override
  Future<DashboardStats> getDashboardStats() async {
    if (Config.USE_MOCK_DATA) {
      await Future.delayed(const Duration(milliseconds: 500));

      return DashboardStats(
        attendancePercentage: 85.5,
        pendingAssignments: 2,
        pendingHomework: 1,
        pendingFees: 1,
        todayClasses: 3,
        recentMarks: [
          RecentMark(
            subjectId: 1,
            subjectName: 'Mathematics',
            marks: 85,
            maxMarks: 100,
            percentage: 85,
            date: DateTime.now().subtract(const Duration(days: 1)).toString().split(' ').first,
          ),
          RecentMark(
            subjectId: 2,
            subjectName: 'Physics',
            marks: 78,
            maxMarks: 100,
            percentage: 78,
            date: DateTime.now().subtract(const Duration(days: 3)).toString().split(' ').first,
          ),
        ],
        pinnedNotices: [
          Notice(
            id: 1,
            title: 'Mid Semester Exam Schedule Released',
            content: 'The mid-semester exam schedule has been released',
            category: 'Academic',
            priority: 'Urgent',
            createdAt: DateTime.now().subtract(const Duration(days: 2)).toString().split(' ').first,
            validFrom: DateTime.now().toString().split(' ').first,
            isPinned: true,
            views: 245,
            createdBy: 'Academic Department',
          ),
          Notice(
            id: 2,
            title: 'Annual Fest Registration Open',
            content: 'Register for Annual Fest 2024',
            category: 'Event',
            priority: 'High',
            createdAt: DateTime.now().subtract(const Duration(days: 5)).toString().split(' ').first,
            validFrom: DateTime.now().toString().split(' ').first,
            isPinned: true,
            views: 456,
            createdBy: 'Student Activities',
          ),
        ],
        quickActions: [
          QuickActionItem(
            id: 'assignments',
            title: 'Assignments',
            icon: 'assignment',
            route: '/assignments',
            color: '#3B82F6',
          ),
          QuickActionItem(
            id: 'attendance',
            title: 'Attendance',
            icon: 'calendar_today',
            route: '/attendance',
            color: '#22C55E',
          ),
          QuickActionItem(
            id: 'results',
            title: 'Results',
            icon: 'grade',
            route: '/results',
            color: '#FFA500',
          ),
          QuickActionItem(
            id: 'timetable',
            title: 'Timetable',
            icon: 'schedule',
            route: '/timetable',
            color: '#F87171',
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
DashboardRepository createDashboardRepository() {
  return DashboardRepositoryImpl();
}

// Import Notice for this file
import '../models/notice.dart';

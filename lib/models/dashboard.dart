/// Dashboard stats model
class DashboardStats {
  final double attendancePercentage;
  final int pendingAssignments;
  final int pendingHomework;
  final int pendingFees;
  final int todayClasses;
  final List<RecentMark> recentMarks;
  final List<Notice> pinnedNotices;
  final List<QuickActionItem> quickActions;

  DashboardStats({
    required this.attendancePercentage,
    required this.pendingAssignments,
    required this.pendingHomework,
    required this.pendingFees,
    required this.todayClasses,
    required this.recentMarks,
    required this.pinnedNotices,
    required this.quickActions,
  });

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    final marks = <RecentMark>[];
    if (json['recent_marks'] is List) {
      marks.addAll((json['recent_marks'] as List).map(
            (e) => RecentMark.fromJson(e as Map<String, dynamic>),
          ));
    }

    final notices = <Notice>[];
    if (json['pinned_notices'] is List) {
      notices.addAll((json['pinned_notices'] as List).map(
            (e) => Notice.fromJson(e as Map<String, dynamic>),
          ));
    }

    final actions = <QuickActionItem>[];
    if (json['quick_actions'] is List) {
      actions.addAll((json['quick_actions'] as List).map(
            (e) => QuickActionItem.fromJson(e as Map<String, dynamic>),
          ));
    }

    return DashboardStats(
      attendancePercentage: (json['attendance_percentage'] ?? 0.0).toDouble(),
      pendingAssignments: json['pending_assignments'] ?? 0,
      pendingHomework: json['pending_homework'] ?? 0,
      pendingFees: json['pending_fees'] ?? 0,
      todayClasses: json['today_classes'] ?? 0,
      recentMarks: marks,
      pinnedNotices: notices,
      quickActions: actions,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attendance_percentage': attendancePercentage,
      'pending_assignments': pendingAssignments,
      'pending_homework': pendingHomework,
      'pending_fees': pendingFees,
      'today_classes': todayClasses,
      'recent_marks': recentMarks.map((e) => e.toJson()).toList(),
      'pinned_notices': pinnedNotices.map((e) => e.toJson()).toList(),
      'quick_actions': quickActions.map((e) => e.toJson()).toList(),
    };
  }
}

/// Recent mark record
class RecentMark {
  final int subjectId;
  final String subjectName;
  final double marks;
  final double maxMarks;
  final double percentage;
  final String date;

  RecentMark({
    required this.subjectId,
    required this.subjectName,
    required this.marks,
    required this.maxMarks,
    required this.percentage,
    required this.date,
  });

  factory RecentMark.fromJson(Map<String, dynamic> json) {
    return RecentMark(
      subjectId: json['subject_id'] ?? 0,
      subjectName: json['subject_name'] ?? '',
      marks: (json['marks'] ?? 0.0).toDouble(),
      maxMarks: (json['max_marks'] ?? 0.0).toDouble(),
      percentage: (json['percentage'] ?? 0.0).toDouble(),
      date: json['date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subject_id': subjectId,
      'subject_name': subjectName,
      'marks': marks,
      'max_marks': maxMarks,
      'percentage': percentage,
      'date': date,
    };
  }
}

/// Quick action for dashboard
class QuickActionItem {
  final String id;
  final String title;
  final String icon;
  final String route;
  final String color;

  QuickActionItem({
    required this.id,
    required this.title,
    required this.icon,
    required this.route,
    required this.color,
  });

  factory QuickActionItem.fromJson(Map<String, dynamic> json) {
    return QuickActionItem(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      icon: json['icon'] ?? '',
      route: json['route'] ?? '',
      color: json['color'] ?? '#000000',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'icon': icon,
      'route': route,
      'color': color,
    };
  }
}

// Import Notice for this file
import 'notice.dart';

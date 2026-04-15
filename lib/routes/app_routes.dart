import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/auth/login_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/error/error_screen.dart';

class AppRoutes {
  // Route names
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String dashboard = '/dashboard';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String attendance = '/attendance';
  static const String subjects = '/subjects';
  static const String subjectDetail = '/subjects/:id';
  static const String timetable = '/timetable';
  static const String assignments = '/assignments';
  static const String assignmentDetail = '/assignments/:id';
  static const String submitAssignment = '/assignments/:id/submit';
  static const String homework = '/homework';
  static const String homeworkDetail = '/homework/:id';
  static const String submitHomework = '/homework/:id/submit';
  static const String examSchedule = '/exams/schedule';
  static const String examRegistration = '/exams/register';
  static const String results = '/results';
  static const String reportCard = '/report-card';
  static const String fees = '/fees';
  static const String feeDetail = '/fees/:id';
  static const String certificates = '/certificates';
  static const String notices = '/notices';
  static const String noticeDetail = '/notices/:id';
  static const String chat = '/chat';
  static const String library = '/library';
  static const String support = '/support';

  static final GoRouter router = GoRouter(
    initialLocation: login,
    errorBuilder: (context, state) => const ErrorScreen(),
    routes: [
      // Auth routes
      GoRoute(
        path: login,
        builder: (context, state) => const LoginScreen(),
      ),

      // Dashboard
      GoRoute(
        path: dashboard,
        builder: (context, state) => const DashboardScreen(),
      ),

      // Profile routes
      GoRoute(
        path: profile,
        builder: (context, state) => const ProfileScreen(),
      ),

      // Attendance
      GoRoute(
        path: attendance,
        builder: (context, state) => const AttendanceScreen(),
      ),

      // Academic - Subjects
      GoRoute(
        path: subjects,
        builder: (context, state) => const SubjectsScreen(),
      ),

      GoRoute(
        path: subjectDetail,
        builder: (context, state) {
          final id = state.pathParameters['id'];
          return SubjectDetailScreen(id: id ?? '');
        },
      ),

      // Academic - Timetable
      GoRoute(
        path: timetable,
        builder: (context, state) => const TimetableScreen(),
      ),

      // Assignments
      GoRoute(
        path: assignments,
        builder: (context, state) => const AssignmentsScreen(),
      ),

      GoRoute(
        path: assignmentDetail,
        builder: (context, state) {
          final id = state.pathParameters['id'];
          return AssignmentDetailScreen(id: id ?? '');
        },
      ),

      GoRoute(
        path: submitAssignment,
        builder: (context, state) {
          final id = state.pathParameters['id'];
          return SubmitAssignmentScreen(id: id ?? '');
        },
      ),

      // Homework
      GoRoute(
        path: homework,
        builder: (context, state) => const HomeworkScreen(),
      ),

      // Exams
      GoRoute(
        path: examSchedule,
        builder: (context, state) => const ExamScheduleScreen(),
      ),

      GoRoute(
        path: results,
        builder: (context, state) => const ResultsScreen(),
      ),

      GoRoute(
        path: reportCard,
        builder: (context, state) => const ReportCardScreen(),
      ),

      // Fees
      GoRoute(
        path: fees,
        builder: (context, state) => const FeesScreen(),
      ),

      // Certificates
      GoRoute(
        path: certificates,
        builder: (context, state) => const CertificatesScreen(),
      ),

      // Notices
      GoRoute(
        path: notices,
        builder: (context, state) => const NoticesScreen(),
      ),
    ],
  );
}

// TODO: Import actual screen classes
// Placeholder imports - will be replaced with actual screens
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Placeholder();
}

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Placeholder();
}

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Placeholder();
}

class SubjectDetailScreen extends StatelessWidget {
  final String id;

  const SubjectDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Placeholder();
}

class TimetableScreen extends StatelessWidget {
  const TimetableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Placeholder();
}

class AssignmentsScreen extends StatelessWidget {
  const AssignmentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Placeholder();
}

class AssignmentDetailScreen extends StatelessWidget {
  final String id;

  const AssignmentDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Placeholder();
}

class SubmitAssignmentScreen extends StatelessWidget {
  final String id;

  const SubmitAssignmentScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Placeholder();
}

class HomeworkScreen extends StatelessWidget {
  const HomeworkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Placeholder();
}

class ExamScheduleScreen extends StatelessWidget {
  const ExamScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Placeholder();
}

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Placeholder();
}

class ReportCardScreen extends StatelessWidget {
  const ReportCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Placeholder();
}

class FeesScreen extends StatelessWidget {
  const FeesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Placeholder();
}

class CertificatesScreen extends StatelessWidget {
  const CertificatesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Placeholder();
}

class NoticesScreen extends StatelessWidget {
  const NoticesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Placeholder();
}

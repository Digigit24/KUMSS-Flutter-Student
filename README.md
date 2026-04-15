# KUMSSERP Student Mobile App

A comprehensive Flutter mobile application for students to manage their academic life through the KUMSSERP ERP system.

## Features

### Core Modules (13)
1. **Authentication** - Login, Forgot Password, Session Management
2. **Dashboard** - Overview with attendance, fees, notices, and quick actions
3. **Profile Management** - Personal details, guardians, addresses, documents
4. **Attendance** - Calendar view, monthly reports, subject-wise breakdown
5. **Academics - Subjects** - Enrolled subjects with details and syllabus
6. **Academics - Timetable** - Weekly schedule with lab sessions
7. **Assignments & Submissions** - Upload, track, and receive feedback
8. **Homework** - Submit homework with text and file attachments
9. **Examinations - Schedule & Registration** - Exam scheduling and registration
10. **Examinations - Results & Marks** - View results and download report cards
11. **Fees Management** - Fee structure, payment history, receipts
12. **Certificates** - Request and track certificates
13. **Notices & Announcements** - Browse college notices with filters

### Additional Features
- Chat/Messaging (scaffolded)
- Library (scaffolded)
- Support Tickets (scaffolded)
- Dark Mode Support
- Offline Caching with Hive
- Local Storage for tokens

## Tech Stack

- **State Management**: GetX (Getx Controller + GetBuilder)
- **Navigation**: go_router with deep-linking support
- **API Layer**: Repository pattern (Mock + API implementations with toggle flag)
- **Forms**: flutter_form_builder with validators
- **UI**: Material Design 3 with custom theming
- **Local Storage**: flutter_secure_storage (tokens) + hive (cache)
- **HTTP**: Dio with interceptors
- **Charts**: fl_chart for visualizations
- **Logging**: logger package

## Project Structure

```
lib/
├── main.dart                          # App entry point
├── models/                            # Data models
│   ├── auth.dart                     # Authentication models
│   ├── student.dart                  # Student profile models
│   ├── attendance.dart               # Attendance models
│   ├── academic.dart                 # Subjects & Timetable
│   ├── assignment.dart               # Assignment models
│   ├── homework.dart                 # Homework models
│   ├── exam.dart                     # Exam models
│   ├── result.dart                   # Results & Marks
│   ├── fee.dart                      # Fee models
│   ├── certificate.dart              # Certificate models
│   ├── notice.dart                   # Notice models
│   └── dashboard.dart                # Dashboard stats
├── repositories/                      # Repository pattern
│   ├── (interfaces - coming soon)
│   └── impl/
│       ├── (mock implementations - coming soon)
│       └── (API implementations - coming soon)
├── services/
│   ├── api_service.dart              # Dio configuration & interceptors
│   └── config.dart                   # Global configuration
├── controllers/                       # GetX Controllers
│   └── (coming soon)
├── screens/
│   ├── auth/
│   │   └── login_screen.dart
│   ├── dashboard/
│   │   └── dashboard_screen.dart
│   ├── profile/                      # (coming soon)
│   ├── academics/                    # (coming soon)
│   ├── exams/                        # (coming soon)
│   ├── fees/                         # (coming soon)
│   ├── certificates/                 # (coming soon)
│   ├── notices/                      # (coming soon)
│   └── error/
│       └── error_screen.dart
├── widgets/
│   ├── common/                       # (coming soon)
│   └── forms/                        # (coming soon)
├── theme/
│   ├── app_colors.dart               # Color palette
│   ├── app_text_styles.dart          # Typography
│   └── app_theme.dart                # Theme configuration
└── routes/
    └── app_routes.dart               # go_router configuration
```

## Getting Started

### Prerequisites
- Flutter SDK (3.0+)
- Dart 3.0+
- Android Studio / Xcode

### Installation

1. Clone the repository:
```bash
git clone <repo-url>
cd KUMSS-Flutter-Student
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

### Configuration

#### Mock vs Real API
Toggle between mock data and real API in `lib/services/config.dart`:

```dart
class Config {
  static const bool USE_MOCK_DATA = true; // Change to false for real API
  static const String BASE_URL = 'https://kumsserp2.celiyo.com';
}
```

#### Demo Login Credentials
- **Email**: Any valid email
- **Password**: `demo`

## Development Notes

### Architecture Pattern
- **Repository Pattern**: All data access goes through repositories
- **GetX State Management**: Simple and powerful reactive programming
- **Separation of Concerns**: Clear boundaries between UI, logic, and data layers

### Dummy Data Strategy
- Mock implementations provide realistic dummy data
- Can be toggled to real API with a single config flag
- Allows parallel development without backend

### API Integration Checklist
- [ ] Auth module - POST /api/v1/auth/login/
- [ ] Profile module - GET/PATCH /api/v1/students/students/{id}/
- [ ] Dashboard - GET /api/v1/stats/dashboard/
- [ ] Attendance - GET /api/v1/attendance/student-attendance/
- [ ] Subjects - GET /api/v1/academic/subjects/
- [ ] Timetable - GET /api/v1/academic/timetables/
- [ ] Assignments - GET /api/v1/teachers/assignments/
- [ ] Homework - GET /api/v1/students/homework/
- [ ] Exams - GET /api/v1/examinations/exams/
- [ ] Results - GET /api/v1/examinations/results/
- [ ] Fees - GET /api/v1/students/my-fees/
- [ ] Certificates - GET /api/v1/students/certificates/
- [ ] Notices - GET /api/v1/communication/notices/

## Testing

```bash
# Run unit tests
flutter test

# Run integration tests
flutter test integration_test

# Build APK
flutter build apk

# Build iOS
flutter build ios
```

## Color Scheme

| Element | Color | Hex |
|---------|-------|-----|
| Primary | Black | #000000 |
| Background | White | #FFFFFF |
| Surface | Light Gray | #F4F4F4 |
| Success | Green | #22C55E |
| Warning | Orange | #FFA500 |
| Error | Red | #F87171 |
| Muted | Gray | #727272 |

## Contributing

Contributions are welcome! Please follow the existing code style and structure.

## License

This project is proprietary and belongs to KUMSSERP.

## Support

For issues, feature requests, or questions, please contact the development team.

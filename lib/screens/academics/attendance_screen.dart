import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/attendance_controller.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/common/loading_state.dart';
import '../../widgets/common/error_state.dart';
import '../../widgets/common/progress_bar.dart';
import '../../widgets/common/attendance_tile.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  late AttendanceController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(AttendanceController(
      repository: Get.find(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoadingValue) {
          return const LoadingState(message: 'Loading attendance...');
        }

        if (controller.errorValue.isNotEmpty) {
          return ErrorState(
            message: controller.errorValue,
            onRetry: () => controller.refresh(),
          );
        }

        return RefreshIndicator(
          onRefresh: () => controller.refresh(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Summary Section
                _buildSummarySection(),
                const SizedBox(height: 24),

                // Subject-wise Attendance
                _buildSubjectWiseAttendance(),
                const SizedBox(height: 24),

                // Attendance Records
                _buildAttendanceRecords(),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSummarySection() {
    final summary = controller.summaryValue;
    if (summary == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overall Attendance',
          style: AppTextStyles.titleLarge,
        ),
        const SizedBox(height: 16),

        // Overall percentage card
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  '${summary.overallPercentage.toStringAsFixed(1)}%',
                  style: AppTextStyles.displaySmall.copyWith(
                    color: summary.overallPercentage >= 75 ? AppColors.success : AppColors.warning,
                  ),
                ),
                const SizedBox(height: 12),
                ProgressBar(
                  value: summary.overallPercentage / 100,
                  color: summary.overallPercentage >= 75 ? AppColors.success : AppColors.warning,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem(
                      label: 'Present',
                      value: summary.presentDays.toString(),
                      color: AppColors.success,
                    ),
                    _buildStatItem(
                      label: 'Absent',
                      value: summary.absentDays.toString(),
                      color: AppColors.error,
                    ),
                    _buildStatItem(
                      label: 'Late',
                      value: summary.lateDays.toString(),
                      color: AppColors.warning,
                    ),
                    _buildStatItem(
                      label: 'Excused',
                      value: summary.excusedDays.toString(),
                      color: AppColors.info,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem({
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.headlineMedium.copyWith(color: color),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildSubjectWiseAttendance() {
    final summary = controller.summaryValue;
    if (summary == null || summary.subjectWiseAttendance.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Subject-wise Attendance',
          style: AppTextStyles.titleLarge,
        ),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: summary.subjectWiseAttendance.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final subject = summary.subjectWiseAttendance.values.toList()[index];
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        subject.subjectName,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${subject.attendancePercentage.toStringAsFixed(1)}%',
                        style: AppTextStyles.labelLarge.copyWith(
                          fontWeight: FontWeight.bold,
                          color: subject.attendancePercentage >= 75
                              ? AppColors.success
                              : AppColors.warning,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ProgressBar(
                    value: subject.attendancePercentage / 100,
                    color: subject.attendancePercentage >= 75
                        ? AppColors.success
                        : AppColors.warning,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${subject.presentClasses}/${subject.totalClasses} classes',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAttendanceRecords() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Attendance Records',
          style: AppTextStyles.titleLarge,
        ),
        const SizedBox(height: 12),
        Obx(() {
          final records = controller.recordsList;
          if (records.isEmpty) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: Text(
                    'No attendance records found',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: records.length,
            itemBuilder: (context, index) {
              return AttendanceTile(record: records[index]);
            },
          );
        }),
      ],
    );
  }
}

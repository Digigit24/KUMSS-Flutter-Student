import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/academic_controller.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/common/loading_state.dart';
import '../../widgets/common/error_state.dart';
import '../../widgets/common/timetable_tile.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({Key? key}) : super(key: key);

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  late AcademicController controller;
  int _selectedDayIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = Get.put(AcademicController(
      repository: Get.find(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timetable'),
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoadingValue) {
          return const LoadingState(message: 'Loading timetable...');
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
            child: Column(
              children: [
                // Day selector
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: List.generate(
                      controller.daysOfWeek.length,
                      (index) {
                        final day = controller.daysOfWeek[index];
                        final isSelected = index == _selectedDayIndex;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedDayIndex = index),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.primary : AppColors.surface,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected ? AppColors.primary : AppColors.border,
                              ),
                            ),
                            child: Text(
                              day.substring(0, 3),
                              style: AppTextStyles.labelMedium.copyWith(
                                color: isSelected ? AppColors.background : AppColors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Classes for selected day
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Classes on ${controller.daysOfWeek[_selectedDayIndex]}',
                        style: AppTextStyles.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      Obx(() {
                        final dayClasses = controller.getTimetableForDay(
                          controller.daysOfWeek[_selectedDayIndex],
                        );

                        if (dayClasses.isEmpty) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Center(
                                child: Text(
                                  'No classes scheduled',
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
                          itemCount: dayClasses.length,
                          itemBuilder: (context, index) {
                            return TimetableTile(entry: dayClasses[index]);
                          },
                        );
                      }),
                    ],
                  ),
                ),

                // Lab schedules
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lab Schedules',
                        style: AppTextStyles.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      Obx(() {
                        final labs = controller.labSchedulesList;
                        if (labs.isEmpty) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Center(
                                child: Text(
                                  'No lab schedules',
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
                          itemCount: labs.length,
                          itemBuilder: (context, index) {
                            final lab = labs[index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      lab.labName ?? 'Lab Session',
                                      style: AppTextStyles.titleMedium,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '${lab.startTime} - ${lab.endTime}',
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    if (lab.details != null) ...[
                                      const SizedBox(height: 8),
                                      Text(
                                        lab.details!,
                                        style: AppTextStyles.bodySmall,
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

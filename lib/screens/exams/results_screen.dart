import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/result_controller.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/common/loading_state.dart';
import '../../widgets/common/error_state.dart';
import '../../widgets/common/progress_bar.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({Key? key}) : super(key: key);

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  late ResultController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ResultController(
      repository: Get.find(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoadingValue) {
          return const LoadingState(message: 'Loading results...');
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
                // Overall GPA
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary,
                        AppColors.primary.withOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Overall GPA',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.background,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        controller.overallGPA.toStringAsFixed(2),
                        style: AppTextStyles.displayLarge.copyWith(
                          color: AppColors.background,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${controller.passedCount}/${controller.totalExams} Exams Passed',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.background,
                        ),
                      ),
                    ],
                  ),
                ),

                // Exam results
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Exam Results',
                        style: AppTextStyles.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      Obx(() {
                        final results = controller.examResultsList;
                        if (results.isEmpty) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Center(
                                child: Text(
                                  'No results available',
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
                          itemCount: results.length,
                          itemBuilder: (context, index) {
                            final result = results[index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              result.examName,
                                              style: AppTextStyles.titleMedium,
                                            ),
                                            Text(
                                              result.resultDate,
                                              style: AppTextStyles.bodySmall
                                                  .copyWith(
                                                color:
                                                    AppColors.textSecondary,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: result.resultStatus == 'Passed'
                                                ? AppColors.success
                                                    .withOpacity(0.1)
                                                : AppColors.error
                                                    .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            result.resultStatus,
                                            style: AppTextStyles.labelSmall
                                                .copyWith(
                                              color: result.resultStatus ==
                                                      'Passed'
                                                  ? AppColors.success
                                                  : AppColors.error,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    ProgressBar(
                                      value: result.gpa / 4,
                                      label:
                                          'GPA: ${result.gpa.toStringAsFixed(2)} / 4.0',
                                      color: AppColors.primary,
                                    ),
                                    const SizedBox(height: 12),
                                    Column(
                                      children: result.subjectResults
                                          .take(3)
                                          .map((subject) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 8,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  subject.subjectName,
                                                  style:
                                                      AppTextStyles.bodySmall,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Text(
                                                '${subject.marksObtained.toInt()}/${subject.maxMarks.toInt()}',
                                                style: AppTextStyles.labelSmall
                                                    .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
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
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      }),
    );
  }
}

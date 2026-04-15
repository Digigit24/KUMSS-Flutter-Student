import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/student_controller.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/common/loading_state.dart';
import '../../widgets/common/error_state.dart';
import '../../widgets/common/info_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late StudentController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(StudentController(
      repository: Get.find(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Navigate to edit profile screen
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoadingValue) {
          return const LoadingState(message: 'Loading profile...');
        }

        if (controller.errorValue.isNotEmpty) {
          return ErrorState(
            message: controller.errorValue,
            onRetry: () => controller.refresh(),
          );
        }

        final student = controller.studentValue;
        if (student == null) {
          return const ErrorState(
            message: 'Failed to load profile data',
          );
        }

        return RefreshIndicator(
          onRefresh: () => controller.refresh(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                // Profile header
                Container(
                  padding: const EdgeInsets.all(24),
                  color: AppColors.surface,
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary.withOpacity(0.1),
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 40,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        student.fullName,
                        style: AppTextStyles.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        student.admissionNumber,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                // Personal details
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Personal Details',
                        style: AppTextStyles.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      _buildDetailItem('Email', student.email),
                      _buildDetailItem('Phone', student.phone),
                      _buildDetailItem('Date of Birth', student.dateOfBirth),
                      _buildDetailItem('Gender', student.gender),
                      _buildDetailItem('Blood Group', student.bloodGroup ?? 'N/A'),
                      const SizedBox(height: 24),

                      // Academic Details
                      Text(
                        'Academic Details',
                        style: AppTextStyles.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      _buildDetailItem('Department', student.departmentId),
                      _buildDetailItem('Enrollment Year', student.enrollmentYear),
                      _buildDetailItem('Current Semester', student.currentSemester),
                      const SizedBox(height: 24),

                      // Address
                      Text(
                        'Address',
                        style: AppTextStyles.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      _buildDetailItem('Address', student.address),
                      _buildDetailItem('City', student.city),
                      _buildDetailItem('State', student.state),
                      _buildDetailItem('Pincode', student.pincode),
                      const SizedBox(height: 24),

                      // Guardians
                      if (controller.guardiansList.isNotEmpty) ...[
                        Text(
                          'Guardians',
                          style: AppTextStyles.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.guardiansList.length,
                          itemBuilder: (context, index) {
                            final guardian = controller.guardiansList[index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      guardian.name,
                                      style: AppTextStyles.titleMedium,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Relation: ${guardian.relation}',
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Phone: ${guardian.phone}',
                                      style: AppTextStyles.bodySmall,
                                    ),
                                    Text(
                                      'Email: ${guardian.email}',
                                      style: AppTextStyles.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                      ],

                      // Documents
                      if (controller.documentsList.isNotEmpty) ...[
                        Text(
                          'Documents',
                          style: AppTextStyles.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.documentsList.length,
                          itemBuilder: (context, index) {
                            final doc = controller.documentsList[index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          doc.documentType,
                                          style: AppTextStyles.titleMedium,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          doc.documentNumber,
                                          style: AppTextStyles.bodySmall,
                                        ),
                                      ],
                                    ),
                                    if (doc.verificationStatus != null)
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: doc.verificationStatus == 'Verified'
                                              ? AppColors.success.withOpacity(0.1)
                                              : AppColors.warning.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          doc.verificationStatus!,
                                          style: AppTextStyles.labelSmall
                                              .copyWith(
                                            color: doc.verificationStatus ==
                                                    'Verified'
                                                ? AppColors.success
                                                : AppColors.warning,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
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

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

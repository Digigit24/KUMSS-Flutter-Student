import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/certificate_controller.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/common/loading_state.dart';
import '../../widgets/common/error_state.dart';
import '../../widgets/common/status_badge.dart';

class CertificatesScreen extends StatefulWidget {
  const CertificatesScreen({Key? key}) : super(key: key);

  @override
  State<CertificatesScreen> createState() => _CertificatesScreenState();
}

class _CertificatesScreenState extends State<CertificatesScreen> {
  late CertificateController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(CertificateController(
      repository: Get.find(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Certificates'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showRequestDialog(),
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        if (controller.isLoadingValue) {
          return const LoadingState(message: 'Loading certificates...');
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
                // Stats
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        label: 'Issued',
                        count: controller.issuedCount,
                        color: AppColors.success,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        label: 'Ready',
                        count: controller.readyCount,
                        color: AppColors.warning,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        label: 'Processing',
                        count: controller.processingCount,
                        color: AppColors.info,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Certificates list
                Obx(() {
                  if (controller.certificateList.isEmpty) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.card_giftcard,
                                size: 64,
                                color: AppColors.textSecondary,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No Certificates',
                                style: AppTextStyles.titleMedium,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Request your first certificate',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton.icon(
                                onPressed: () => _showRequestDialog(),
                                icon: const Icon(Icons.add),
                                label: const Text('Request Certificate'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.certificateList.length,
                    itemBuilder: (context, index) {
                      final cert = controller.certificateList[index];
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
                                        cert.certificateType,
                                        style: AppTextStyles.titleMedium,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Requested: ${cert.requestDate}',
                                        style: AppTextStyles.bodySmall.copyWith(
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  StatusBadge(
                                    label: cert.status,
                                    status: cert.status.toLowerCase(),
                                  ),
                                ],
                              ),
                              if (cert.remarks != null) ...[
                                const SizedBox(height: 8),
                                Text(
                                  cert.remarks!,
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                              if (cert.issuedDate != null) ...[
                                const SizedBox(height: 8),
                                Text(
                                  'Issued: ${cert.issuedDate}',
                                  style: AppTextStyles.bodySmall,
                                ),
                              ],
                              if (cert.certificateUrl != null && cert.isIssued) ...[
                                const SizedBox(height: 12),
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton.icon(
                                    onPressed: () {
                                      // TODO: Download or view certificate
                                    },
                                    icon: const Icon(Icons.download),
                                    label: const Text('Download Certificate'),
                                  ),
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
        );
      }),
    );
  }

  Widget _buildStatCard({
    required String label,
    required int count,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            count.toString(),
            style: AppTextStyles.headlineSmall.copyWith(color: color),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showRequestDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Request Certificate'),
        content: const Text('Certificate request form implementation coming soon'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

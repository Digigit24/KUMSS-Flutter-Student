import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/fee_controller.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/common/loading_state.dart';
import '../../widgets/common/error_state.dart';
import '../../widgets/common/info_card.dart';
import '../../widgets/common/fee_card.dart';

class FeesScreen extends StatefulWidget {
  const FeesScreen({Key? key}) : super(key: key);

  @override
  State<FeesScreen> createState() => _FeesScreenState();
}

class _FeesScreenState extends State<FeesScreen> {
  late FeeController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(FeeController(
      repository: Get.find(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fees'),
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoadingValue) {
          return const LoadingState(message: 'Loading fees...');
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
                // Summary cards
                Row(
                  children: [
                    Expanded(
                      child: InfoCard(
                        title: 'Total Fees',
                        value: '₹${controller.totalFees.toStringAsFixed(0)}',
                        icon: Icons.currency_rupee,
                        iconColor: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: InfoCard(
                        title: 'Pending',
                        value: '₹${controller.pendingAmount.toStringAsFixed(0)}',
                        icon: Icons.schedule,
                        iconColor: AppColors.warning,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: InfoCard(
                        title: 'Paid',
                        value: '₹${controller.paidAmount.toStringAsFixed(0)}',
                        icon: Icons.check_circle,
                        iconColor: AppColors.success,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: InfoCard(
                        title: 'Overdue',
                        value: '₹${controller.overdueAmount.toStringAsFixed(0)}',
                        icon: Icons.warning,
                        iconColor: AppColors.error,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Fee details
                Text(
                  'Fee Breakdown',
                  style: AppTextStyles.titleLarge,
                ),
                const SizedBox(height: 12),
                Obx(() {
                  if (controller.feeSummaryValue == null ||
                      controller.feeSummaryValue!.fees.isEmpty) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Center(
                          child: Text(
                            'No fees found',
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
                    itemCount: controller.feeSummaryValue!.fees.length,
                    itemBuilder: (context, index) {
                      final fee = controller.feeSummaryValue!.fees[index];
                      return FeeCard(
                        fee: fee,
                        onPayNow: fee.isPending
                            ? () => ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Payment integration coming soon'),
                                  ),
                                )
                            : null,
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
}

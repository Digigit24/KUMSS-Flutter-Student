import 'package:flutter/material.dart';
import '../../models/fee.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import 'status_badge.dart';

class FeeCard extends StatelessWidget {
  final Fee fee;
  final VoidCallback? onTap;
  final VoidCallback? onPayNow;

  const FeeCard({
    Key? key,
    required this.fee,
    this.onTap,
    this.onPayNow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fee.feeType,
                          style: AppTextStyles.titleMedium,
                        ),
                        Text(
                          '${fee.academicYear} - Sem ${fee.semester}',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  StatusBadge(
                    label: fee.status,
                    status: fee.status.toLowerCase(),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Amount',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        '₹${fee.amount.toStringAsFixed(0)}',
                        style: AppTextStyles.titleMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  if (fee.paidAmount != null && fee.paidAmount! > 0)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Paid',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.success,
                          ),
                        ),
                        Text(
                          '₹${fee.paidAmount!.toStringAsFixed(0)}',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.success,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  if (fee.pendingAmount != null && fee.pendingAmount! > 0)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Pending',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: statusColor,
                          ),
                        ),
                        Text(
                          '₹${fee.pendingAmount!.toStringAsFixed(0)}',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              if (fee.fineAmount != null && fee.fineAmount! > 0) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Fine Amount',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                      Text(
                        '₹${fee.fineAmount!.toStringAsFixed(0)}',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.error,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              if (fee.isPending && onPayNow != null) ...[
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onPayNow,
                    child: const Text('Pay Now'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor() {
    switch (fee.status) {
      case 'Paid':
        return AppColors.success;
      case 'Pending':
      case 'Partial':
        return AppColors.warning;
      case 'Overdue':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }
}

import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class StatusBadge extends StatelessWidget {
  final String label;
  final String status; // pending, submitted, graded, overdue, paid, processing, etc.
  final bool outlined;

  const StatusBadge({
    Key? key,
    required this.label,
    required this.status,
    this.outlined = false,
  }) : super(key: key);

  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case 'pending':
      case 'requested':
        return AppColors.warning;
      case 'submitted':
      case 'processing':
        return AppColors.info;
      case 'graded':
      case 'issued':
      case 'paid':
      case 'ready':
        return AppColors.success;
      case 'overdue':
      case 'failed':
      case 'rejected':
        return AppColors.error;
      case 'urgent':
        return AppColors.error;
      case 'high':
        return AppColors.warning;
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getStatusColor();

    if (outlined) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelSmall.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

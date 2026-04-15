import 'package:flutter/material.dart';
import '../../models/assignment.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import 'status_badge.dart';

class AssignmentCard extends StatelessWidget {
  final Assignment assignment;
  final VoidCallback? onTap;
  final VoidCallback? onSubmit;

  const AssignmentCard({
    Key? key,
    required this.assignment,
    this.onTap,
    this.onSubmit,
  }) : super(key: key);

  Color _getStatusColor() {
    if (assignment.isOverdue) return AppColors.error;
    if (assignment.isGraded) return AppColors.success;
    if (assignment.isSubmitted) return AppColors.info;
    return AppColors.warning;
  }

  @override
  Widget build(BuildContext context) {
    final daysLeft = _calculateDaysLeft();
    final statusColor = _getStatusColor();

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border(
              left: BorderSide(color: statusColor, width: 4),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        assignment.title,
                        style: AppTextStyles.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    StatusBadge(
                      label: assignment.status,
                      status: assignment.status.toLowerCase(),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  assignment.description,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (daysLeft != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: daysLeft < 0 ? AppColors.error.withOpacity(0.1) : AppColors.warning.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          daysLeft < 0 ? 'Overdue ${daysLeft.abs()} days' : 'Due in $daysLeft days',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: daysLeft < 0 ? AppColors.error : AppColors.warning,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    if (assignment.obtainedMarks != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${assignment.obtainedMarks}/${assignment.maxMarks}',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.success,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                if (assignment.isPending && onSubmit != null) ...[
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: onSubmit,
                      child: const Text('Submit Assignment'),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  int? _calculateDaysLeft() {
    try {
      final dueDate = DateTime.parse(assignment.dueDate);
      final today = DateTime.now();
      return dueDate.difference(today).inDays;
    } catch (e) {
      return null;
    }
  }
}

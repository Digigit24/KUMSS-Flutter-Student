import 'package:flutter/material.dart';
import '../../models/academic.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class TimetableTile extends StatelessWidget {
  final TimetableEntry entry;
  final VoidCallback? onTap;

  const TimetableTile({
    Key? key,
    required this.entry,
    this.onTap,
  }) : super(key: key);

  Color _getClassTypeColor() {
    switch (entry.classType) {
      case 'Lecture':
        return AppColors.info;
      case 'Lab':
        return AppColors.success;
      case 'Tutorial':
        return AppColors.warning;
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final classColor = _getClassTypeColor();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(8),
          color: classColor.withOpacity(0.02),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: classColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                entry.classType == 'Lab' ? Icons.science : Icons.school,
                color: classColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${entry.startTime} - ${entry.endTime}',
                    style: AppTextStyles.labelMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: classColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    entry.classType,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (entry.roomNumber != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: classColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      entry.roomNumber!,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: classColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                if (entry.teacherName != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      entry.teacherName!,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.end,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Notice / Announcement model
class Notice {
  final int id;
  final String title;
  final String content;
  final String category; // Academic, Event, Holiday, General
  final String priority; // Urgent, High, Normal, Low
  final String createdAt;
  final String validFrom;
  final String? validTill;
  final bool isPinned;
  final String? attachmentUrl;
  final String? attachmentFileName;
  final int views;
  final String createdBy;
  final String? imageUrl;

  Notice({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.priority,
    required this.createdAt,
    required this.validFrom,
    this.validTill,
    required this.isPinned,
    this.attachmentUrl,
    this.attachmentFileName,
    required this.views,
    required this.createdBy,
    this.imageUrl,
  });

  bool get isAcademic => category == 'Academic';
  bool get isEvent => category == 'Event';
  bool get isHoliday => category == 'Holiday';
  bool get isGeneral => category == 'General';

  bool get isUrgent => priority == 'Urgent';
  bool get isHigh => priority == 'High';
  bool get isNormal => priority == 'Normal';
  bool get isLow => priority == 'Low';

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      category: json['category'] ?? 'General',
      priority: json['priority'] ?? 'Normal',
      createdAt: json['created_at'] ?? '',
      validFrom: json['valid_from'] ?? '',
      validTill: json['valid_till'],
      isPinned: json['is_pinned'] ?? false,
      attachmentUrl: json['attachment_url'],
      attachmentFileName: json['attachment_file_name'],
      views: json['views'] ?? 0,
      createdBy: json['created_by'] ?? '',
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'category': category,
      'priority': priority,
      'created_at': createdAt,
      'valid_from': validFrom,
      'valid_till': validTill,
      'is_pinned': isPinned,
      'attachment_url': attachmentUrl,
      'attachment_file_name': attachmentFileName,
      'views': views,
      'created_by': createdBy,
      'image_url': imageUrl,
    };
  }
}

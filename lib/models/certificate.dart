/// Certificate model
class Certificate {
  final int id;
  final int studentId;
  final String certificateType; // Bonafide, Character, etc.
  final String requestDate;
  final String status; // Requested, Processing, Ready, Issued
  final String? issuedDate;
  final String? certificateUrl;
  final String? remarks;
  final String? pickupDate;

  Certificate({
    required this.id,
    required this.studentId,
    required this.certificateType,
    required this.requestDate,
    required this.status,
    this.issuedDate,
    this.certificateUrl,
    this.remarks,
    this.pickupDate,
  });

  bool get isRequested => status == 'Requested';
  bool get isProcessing => status == 'Processing';
  bool get isReady => status == 'Ready';
  bool get isIssued => status == 'Issued';

  factory Certificate.fromJson(Map<String, dynamic> json) {
    return Certificate(
      id: json['id'] ?? 0,
      studentId: json['student_id'] ?? 0,
      certificateType: json['certificate_type'] ?? '',
      requestDate: json['request_date'] ?? '',
      status: json['status'] ?? 'Requested',
      issuedDate: json['issued_date'],
      certificateUrl: json['certificate_url'],
      remarks: json['remarks'],
      pickupDate: json['pickup_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_id': studentId,
      'certificate_type': certificateType,
      'request_date': requestDate,
      'status': status,
      'issued_date': issuedDate,
      'certificate_url': certificateUrl,
      'remarks': remarks,
      'pickup_date': pickupDate,
    };
  }
}

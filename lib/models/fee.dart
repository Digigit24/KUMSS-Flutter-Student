/// Fee model
class Fee {
  final int id;
  final int studentId;
  final String feeType; // Tuition, Hostel, etc.
  final double amount;
  final String academicYear;
  final String semester;
  final String dueDate;
  final String status; // Pending, Paid, Overdue, Partial
  final double? paidAmount;
  final double? pendingAmount;
  final double? fineAmount;
  final String? receiptUrl;

  Fee({
    required this.id,
    required this.studentId,
    required this.feeType,
    required this.amount,
    required this.academicYear,
    required this.semester,
    required this.dueDate,
    required this.status,
    this.paidAmount,
    this.pendingAmount,
    this.fineAmount,
    this.receiptUrl,
  });

  bool get isPending => status == 'Pending';
  bool get isPaid => status == 'Paid';
  bool get isOverdue => status == 'Overdue';
  bool get isPartialPaid => status == 'Partial';

  factory Fee.fromJson(Map<String, dynamic> json) {
    return Fee(
      id: json['id'] ?? 0,
      studentId: json['student_id'] ?? 0,
      feeType: json['fee_type'] ?? '',
      amount: (json['amount'] ?? 0.0).toDouble(),
      academicYear: json['academic_year'] ?? '',
      semester: json['semester'] ?? '',
      dueDate: json['due_date'] ?? '',
      status: json['status'] ?? 'Pending',
      paidAmount: (json['paid_amount'] as num?)?.toDouble(),
      pendingAmount: (json['pending_amount'] as num?)?.toDouble(),
      fineAmount: (json['fine_amount'] as num?)?.toDouble(),
      receiptUrl: json['receipt_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_id': studentId,
      'fee_type': feeType,
      'amount': amount,
      'academic_year': academicYear,
      'semester': semester,
      'due_date': dueDate,
      'status': status,
      'paid_amount': paidAmount,
      'pending_amount': pendingAmount,
      'fine_amount': fineAmount,
      'receipt_url': receiptUrl,
    };
  }
}

/// Fee receipt / Payment history
class FeeReceipt {
  final int id;
  final int studentId;
  final int feeId;
  final double amount;
  final String paymentDate;
  final String paymentMethod; // Online, Cheque, Cash, etc.
  final String transactionId;
  final String receiptNumber;
  final String status; // Successful, Pending, Failed
  final String? receiptUrl;

  FeeReceipt({
    required this.id,
    required this.studentId,
    required this.feeId,
    required this.amount,
    required this.paymentDate,
    required this.paymentMethod,
    required this.transactionId,
    required this.receiptNumber,
    required this.status,
    this.receiptUrl,
  });

  factory FeeReceipt.fromJson(Map<String, dynamic> json) {
    return FeeReceipt(
      id: json['id'] ?? 0,
      studentId: json['student_id'] ?? 0,
      feeId: json['fee_id'] ?? 0,
      amount: (json['amount'] ?? 0.0).toDouble(),
      paymentDate: json['payment_date'] ?? '',
      paymentMethod: json['payment_method'] ?? '',
      transactionId: json['transaction_id'] ?? '',
      receiptNumber: json['receipt_number'] ?? '',
      status: json['status'] ?? 'Successful',
      receiptUrl: json['receipt_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_id': studentId,
      'fee_id': feeId,
      'amount': amount,
      'payment_date': paymentDate,
      'payment_method': paymentMethod,
      'transaction_id': transactionId,
      'receipt_number': receiptNumber,
      'status': status,
      'receipt_url': receiptUrl,
    };
  }
}

/// Fee summary for dashboard
class FeeSummary {
  final double totalFees;
  final double paidAmount;
  final double pendingAmount;
  final double overdueAmount;
  final int totalFeeRecords;
  final int paidRecords;
  final int pendingRecords;
  final int overdueRecords;
  final List<Fee> fees;

  FeeSummary({
    required this.totalFees,
    required this.paidAmount,
    required this.pendingAmount,
    required this.overdueAmount,
    required this.totalFeeRecords,
    required this.paidRecords,
    required this.pendingRecords,
    required this.overdueRecords,
    required this.fees,
  });

  factory FeeSummary.fromJson(Map<String, dynamic> json) {
    final feeList = <Fee>[];
    if (json['fees'] is List) {
      feeList.addAll((json['fees'] as List).map(
            (e) => Fee.fromJson(e as Map<String, dynamic>),
          ));
    }
    return FeeSummary(
      totalFees: (json['total_fees'] ?? 0.0).toDouble(),
      paidAmount: (json['paid_amount'] ?? 0.0).toDouble(),
      pendingAmount: (json['pending_amount'] ?? 0.0).toDouble(),
      overdueAmount: (json['overdue_amount'] ?? 0.0).toDouble(),
      totalFeeRecords: json['total_fee_records'] ?? 0,
      paidRecords: json['paid_records'] ?? 0,
      pendingRecords: json['pending_records'] ?? 0,
      overdueRecords: json['overdue_records'] ?? 0,
      fees: feeList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_fees': totalFees,
      'paid_amount': paidAmount,
      'pending_amount': pendingAmount,
      'overdue_amount': overdueAmount,
      'total_fee_records': totalFeeRecords,
      'paid_records': paidRecords,
      'pending_records': pendingRecords,
      'overdue_records': overdueRecords,
      'fees': fees.map((e) => e.toJson()).toList(),
    };
  }
}

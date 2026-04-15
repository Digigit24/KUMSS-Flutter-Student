import '../models/fee.dart';
import '../services/config.dart';

abstract class FeeRepository {
  Future<FeeSummary> getFeeSummary();
  Future<List<Fee>> getFees();
  Future<Fee> getFeeDetail(int feeId);
  Future<List<FeeReceipt>> getPaymentHistory();
  Future<String> getReceiptUrl(int feeId);
}

class FeeRepositoryImpl implements FeeRepository {
  @override
  Future<FeeSummary> getFeeSummary() async {
    if (Config.USE_MOCK_DATA) {
      await Future.delayed(const Duration(milliseconds: 500));

      final fees = [
        Fee(
          id: 1,
          studentId: 1,
          feeType: 'Tuition',
          amount: 100000,
          academicYear: '2023-2024',
          semester: '6',
          dueDate: '2024-06-30',
          status: 'Paid',
          paidAmount: 100000,
          pendingAmount: 0,
          receiptUrl: 'https://via.placeholder.com/receipt.pdf',
        ),
        Fee(
          id: 2,
          studentId: 1,
          feeType: 'Hostel',
          amount: 50000,
          academicYear: '2023-2024',
          semester: '6',
          dueDate: '2024-07-15',
          status: 'Pending',
          paidAmount: 0,
          pendingAmount: 50000,
        ),
        Fee(
          id: 3,
          studentId: 1,
          feeType: 'Library',
          amount: 2000,
          academicYear: '2023-2024',
          semester: '6',
          dueDate: '2024-05-31',
          status: 'Overdue',
          paidAmount: 0,
          pendingAmount: 2000,
          fineAmount: 200,
        ),
      ];

      return FeeSummary(
        totalFees: 152000,
        paidAmount: 100000,
        pendingAmount: 50000,
        overdueAmount: 2200,
        totalFeeRecords: 3,
        paidRecords: 1,
        pendingRecords: 1,
        overdueRecords: 1,
        fees: fees,
      );
    } else {
      // TODO: Implement real API call
      throw UnimplementedError('Real API implementation pending');
    }
  }

  @override
  Future<List<Fee>> getFees() async {
    final summary = await getFeeSummary();
    return summary.fees;
  }

  @override
  Future<Fee> getFeeDetail(int feeId) async {
    if (Config.USE_MOCK_DATA) {
      await Future.delayed(const Duration(milliseconds: 500));

      return Fee(
        id: feeId,
        studentId: 1,
        feeType: 'Tuition',
        amount: 100000,
        academicYear: '2023-2024',
        semester: '6',
        dueDate: '2024-06-30',
        status: 'Paid',
        paidAmount: 100000,
        pendingAmount: 0,
        receiptUrl: 'https://via.placeholder.com/receipt.pdf',
      );
    } else {
      // TODO: Implement real API call
      throw UnimplementedError('Real API implementation pending');
    }
  }

  @override
  Future<List<FeeReceipt>> getPaymentHistory() async {
    if (Config.USE_MOCK_DATA) {
      await Future.delayed(const Duration(milliseconds: 500));

      return [
        FeeReceipt(
          id: 1,
          studentId: 1,
          feeId: 1,
          amount: 100000,
          paymentDate: '2024-06-25',
          paymentMethod: 'Online',
          transactionId: 'TXN20240625001',
          receiptNumber: 'REC001',
          status: 'Successful',
          receiptUrl: 'https://via.placeholder.com/receipt.pdf',
        ),
      ];
    } else {
      // TODO: Implement real API call
      throw UnimplementedError('Real API implementation pending');
    }
  }

  @override
  Future<String> getReceiptUrl(int feeId) async {
    if (Config.USE_MOCK_DATA) {
      await Future.delayed(const Duration(milliseconds: 500));
      return 'https://via.placeholder.com/receipt.pdf';
    } else {
      // TODO: Implement real API call
      throw UnimplementedError('Real API implementation pending');
    }
  }
}

// Factory constructor
FeeRepository createFeeRepository() {
  return FeeRepositoryImpl();
}

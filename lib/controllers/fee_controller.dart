import 'package:get/get.dart';
import '../models/fee.dart';
import '../repositories/fee_repository.dart';

class FeeController extends GetxController {
  final FeeRepository repository;

  // Observables
  Rx<FeeSummary?> feeSummary = Rx<FeeSummary?>(null);
  RxList<FeeReceipt> paymentHistory = RxList<FeeReceipt>();
  RxBool isLoading = false.obs;
  RxString error = ''.obs;

  // Getters
  FeeSummary? get feeSummaryValue => feeSummary.value;
  List<FeeReceipt> get paymentHistoryList => paymentHistory;
  bool get isLoadingValue => isLoading.value;
  String get errorValue => error.value;

  // Computed properties
  double get totalFees => feeSummary.value?.totalFees ?? 0.0;
  double get paidAmount => feeSummary.value?.paidAmount ?? 0.0;
  double get pendingAmount => feeSummary.value?.pendingAmount ?? 0.0;
  double get overdueAmount => feeSummary.value?.overdueAmount ?? 0.0;
  int get paidRecords => feeSummary.value?.paidRecords ?? 0;
  int get pendingRecords => feeSummary.value?.pendingRecords ?? 0;
  int get overdueRecords => feeSummary.value?.overdueRecords ?? 0;

  FeeController({required this.repository});

  @override
  void onInit() {
    super.onInit();
    getFeeSummary();
    getPaymentHistory();
  }

  Future<void> getFeeSummary() async {
    isLoading.value = true;
    error.value = '';

    try {
      final data = await repository.getFeeSummary();
      feeSummary.value = data;
      error.value = '';
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getPaymentHistory() async {
    try {
      final data = await repository.getPaymentHistory();
      paymentHistory.assignAll(data);
      error.value = '';
    } catch (e) {
      error.value = e.toString();
    }
  }

  Future<String> getReceiptUrl(int feeId) async {
    try {
      final url = await repository.getReceiptUrl(feeId);
      return url;
    } catch (e) {
      error.value = e.toString();
      return '';
    }
  }

  List<Fee> get pendingFees {
    return feeSummary.value?.fees.where((f) => f.isPending || f.isPartialPaid).toList() ?? [];
  }

  List<Fee> get overdueFees {
    return feeSummary.value?.fees.where((f) => f.isOverdue).toList() ?? [];
  }

  double get totalPendingAmount {
    return pendingFees.fold<double>(0, (sum, fee) => sum + (fee.pendingAmount ?? 0));
  }

  double get totalOverdueAmount {
    return overdueFees.fold<double>(0, (sum, fee) => sum + (fee.pendingAmount ?? 0) + (fee.fineAmount ?? 0));
  }

  Future<void> refresh() async {
    await Future.wait([
      getFeeSummary(),
      getPaymentHistory(),
    ]);
  }
}

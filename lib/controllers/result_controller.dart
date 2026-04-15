import 'package:get/get.dart';
import '../models/result.dart';
import '../repositories/result_repository.dart';

class ResultController extends GetxController {
  final ResultRepository repository;

  // Observables
  RxList<ExamResult> examResults = RxList<ExamResult>();
  RxList<ReportCard> reportCards = RxList<ReportCard>();
  Rx<ExamResult?> selectedExamResult = Rx<ExamResult?>(null);
  Rx<ReportCard?> selectedReportCard = Rx<ReportCard?>(null);
  RxBool isLoading = false.obs;
  RxString error = ''.obs;

  // Getters
  List<ExamResult> get examResultsList => examResults;
  List<ReportCard> get reportCardsList => reportCards;
  ExamResult? get selectedExamResultValue => selectedExamResult.value;
  ReportCard? get selectedReportCardValue => selectedReportCard.value;
  bool get isLoadingValue => isLoading.value;
  String get errorValue => error.value;

  ResultController({required this.repository});

  @override
  void onInit() {
    super.onInit();
    getExamResults();
    getReportCards();
  }

  Future<void> getExamResults() async {
    isLoading.value = true;
    error.value = '';

    try {
      final data = await repository.getExamResults();
      examResults.assignAll(data);
      error.value = '';
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getExamResult(int resultId) async {
    isLoading.value = true;
    error.value = '';

    try {
      final data = await repository.getExamResult(resultId);
      selectedExamResult.value = data;
      error.value = '';
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getReportCards() async {
    try {
      final data = await repository.getReportCards();
      reportCards.assignAll(data);
      error.value = '';
    } catch (e) {
      error.value = e.toString();
    }
  }

  Future<void> getReportCard(int reportCardId) async {
    isLoading.value = true;
    error.value = '';

    try {
      final data = await repository.getReportCard(reportCardId);
      selectedReportCard.value = data;
      error.value = '';
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // Computed properties
  double get overallGPA {
    if (reportCards.isEmpty) return 0.0;
    final avgGPA = reportCards.fold<double>(0, (sum, rc) => sum + rc.cumulativeGPA) / reportCards.length;
    return double.parse(avgGPA.toStringAsFixed(2));
  }

  int get passedCount {
    return examResults.where((r) => r.resultStatus == 'Passed').length;
  }

  int get totalExams {
    return examResults.length;
  }

  List<SubjectResult> getPassedSubjects() {
    final passed = <SubjectResult>[];
    for (var result in examResults) {
      passed.addAll(result.subjectResults.where((sr) => sr.isPassed));
    }
    return passed;
  }

  List<SubjectResult> getFailedSubjects() {
    final failed = <SubjectResult>[];
    for (var result in examResults) {
      failed.addAll(result.subjectResults.where((sr) => !sr.isPassed));
    }
    return failed;
  }

  Future<void> refresh() async {
    await Future.wait([
      getExamResults(),
      getReportCards(),
    ]);
  }
}

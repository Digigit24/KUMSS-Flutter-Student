import 'package:get/get.dart';
import '../models/exam.dart';
import '../repositories/exam_repository.dart';

class ExamController extends GetxController {
  final ExamRepository repository;

  // Observables
  RxList<Exam> exams = RxList<Exam>();
  Rx<Exam?> selectedExam = Rx<Exam?>(null);
  Rx<ExamRegistration?> registration = Rx<ExamRegistration?>(null);
  RxBool isLoading = false.obs;
  RxString error = ''.obs;

  // Getters
  List<Exam> get examsList => exams;
  Exam? get selectedExamValue => selectedExam.value;
  ExamRegistration? get registrationValue => registration.value;
  bool get isLoadingValue => isLoading.value;
  String get errorValue => error.value;

  ExamController({required this.repository});

  @override
  void onInit() {
    super.onInit();
    getExams();
  }

  Future<void> getExams() async {
    isLoading.value = true;
    error.value = '';

    try {
      final data = await repository.getExams();
      exams.assignAll(data);
      error.value = '';
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getExamDetail(int examId) async {
    isLoading.value = true;
    error.value = '';

    try {
      final data = await repository.getExamDetail(examId);
      selectedExam.value = data;
      await getRegistration(examId);
      error.value = '';
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> registerForExam(int examId, List<int> subjectIds) async {
    isLoading.value = true;
    error.value = '';

    try {
      final data = await repository.registerForExam(examId, subjectIds);
      registration.value = data;
      error.value = '';
      Get.snackbar('Success', 'Registered for exam successfully');
    } catch (e) {
      error.value = e.toString();
      Get.snackbar('Error', error.value);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getRegistration(int examId) async {
    try {
      final data = await repository.getRegistration(examId);
      registration.value = data;
      error.value = '';
    } catch (e) {
      // Ignore if no registration found
      registration.value = null;
    }
  }

  List<Exam> get upcomingExams {
    final now = DateTime.now();
    return exams.where((e) {
      try {
        final startDate = DateTime.parse(e.startDate);
        return startDate.isAfter(now);
      } catch (e) {
        return false;
      }
    }).toList();
  }

  Future<void> refresh() async {
    await getExams();
  }
}

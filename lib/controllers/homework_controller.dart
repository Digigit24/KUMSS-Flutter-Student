import 'package:get/get.dart';
import '../models/homework.dart';
import '../repositories/homework_repository.dart';

class HomeworkController extends GetxController {
  final HomeworkRepository repository;

  // Observables
  RxList<Homework> homework = RxList<Homework>();
  RxBool isLoading = false.obs;
  RxString error = ''.obs;
  RxString selectedStatus = RxString('All');

  // Getters
  List<Homework> get homeworkList => homework;
  bool get isLoadingValue => isLoading.value;
  String get errorValue => error.value;

  HomeworkController({required this.repository});

  @override
  void onInit() {
    super.onInit();
    getHomework();
  }

  Future<void> getHomework() async {
    isLoading.value = true;
    error.value = '';

    try {
      final data = await repository.getHomework();
      homework.assignAll(data);
      error.value = '';
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> submitHomework(int homeworkId, String text, String? fileUrl) async {
    isLoading.value = true;
    error.value = '';

    try {
      final submission = await repository.submitHomework(homeworkId, text, fileUrl);
      final index = homework.indexWhere((h) => h.id == homeworkId);
      if (index >= 0) {
        homework[index] = homework[index].copyWith(status: 'Submitted');
      }
      error.value = '';
      Get.snackbar('Success', 'Homework submitted successfully');
    } catch (e) {
      error.value = e.toString();
      Get.snackbar('Error', error.value);
    } finally {
      isLoading.value = false;
    }
  }

  int get pendingCount => homework.where((h) => h.isPending).length;
  int get submittedCount => homework.where((h) => h.isSubmitted).length;

  Future<void> refresh() async {
    await getHomework();
  }
}

extension on Homework {
  Homework copyWith({String? status}) {
    return Homework(
      id: id,
      subjectId: subjectId,
      teacherId: teacherId,
      title: title,
      description: description,
      dueDate: dueDate,
      status: status ?? this.status,
      createdAt: createdAt,
      maxMarks: maxMarks,
      attachmentUrl: attachmentUrl,
    );
  }
}

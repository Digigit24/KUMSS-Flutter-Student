import 'package:get/get.dart';
import '../models/assignment.dart';
import '../repositories/assignment_repository.dart';

class AssignmentController extends GetxController {
  final AssignmentRepository repository;

  // Observables
  RxList<Assignment> allAssignments = RxList<Assignment>();
  RxList<Assignment> filteredAssignments = RxList<Assignment>();
  Rx<Assignment?> selectedAssignment = Rx<Assignment?>(null);
  RxBool isLoading = false.obs;
  RxString error = ''.obs;
  RxString selectedFilter = RxString('All');

  // Getters
  List<Assignment> get assignments => filteredAssignments;
  bool get isLoadingValue => isLoading.value;
  String get errorValue => error.value;

  AssignmentController({required this.repository});

  @override
  void onInit() {
    super.onInit();
    getAssignments();
  }

  Future<void> getAssignments({String? status}) async {
    isLoading.value = true;
    error.value = '';

    try {
      final data = await repository.getAssignments(status: status);
      allAssignments.assignAll(data);
      _applyFilter();
      error.value = '';
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAssignmentDetail(int assignmentId) async {
    isLoading.value = true;
    error.value = '';

    try {
      final data = await repository.getAssignmentDetail(assignmentId);
      selectedAssignment.value = data;
      error.value = '';
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> submitAssignment(
    int assignmentId,
    String? text,
    String? fileUrl,
  ) async {
    isLoading.value = true;
    error.value = '';

    try {
      final submission = await repository.submitAssignment(assignmentId, text, fileUrl);
      // Update local assignment
      final index = allAssignments.indexWhere((a) => a.id == assignmentId);
      if (index >= 0) {
        allAssignments[index] = allAssignments[index].copyWith(
          status: 'Submitted',
          submissionId: submission.id.toString(),
        );
      }
      error.value = '';
      Get.snackbar('Success', 'Assignment submitted successfully');
    } catch (e) {
      error.value = e.toString();
      Get.snackbar('Error', error.value);
    } finally {
      isLoading.value = false;
    }
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
    _applyFilter();
  }

  void _applyFilter() {
    if (selectedFilter.value == 'All') {
      filteredAssignments.assignAll(allAssignments);
    } else {
      filteredAssignments.assignAll(
        allAssignments.where((a) => a.status == selectedFilter.value).toList(),
      );
    }
  }

  int get pendingCount => allAssignments.where((a) => a.isPending).length;
  int get submittedCount => allAssignments.where((a) => a.isSubmitted).length;
  int get gradedCount => allAssignments.where((a) => a.isGraded).length;
  int get overdueCount => allAssignments.where((a) => a.isOverdue).length;

  Future<void> refresh() async {
    await getAssignments();
  }
}

// Extension for copyWith
extension on Assignment {
  Assignment copyWith({
    int? id,
    int? subjectId,
    String? title,
    String? description,
    String? dueDate,
    int? maxMarks,
    String? attachmentUrl,
    String? status,
    String? createdAt,
    String? feedbackText,
    int? obtainedMarks,
    String? submissionId,
  }) {
    return Assignment(
      id: id ?? this.id,
      subjectId: subjectId ?? this.subjectId,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      maxMarks: maxMarks ?? this.maxMarks,
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      feedbackText: feedbackText ?? this.feedbackText,
      obtainedMarks: obtainedMarks ?? this.obtainedMarks,
      submissionId: submissionId ?? this.submissionId,
    );
  }
}

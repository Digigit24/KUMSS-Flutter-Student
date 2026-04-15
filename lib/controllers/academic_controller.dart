import 'package:get/get.dart';
import '../models/academic.dart';
import '../repositories/academic_repository.dart';

class AcademicController extends GetxController {
  final AcademicRepository repository;

  // Observables
  RxList<Subject> subjects = RxList<Subject>();
  RxList<TimetableEntry> timetable = RxList<TimetableEntry>();
  RxList<LabSchedule> labSchedules = RxList<LabSchedule>();
  Rx<Subject?> selectedSubject = Rx<Subject?>(null);
  RxBool isLoading = false.obs;
  RxString error = ''.obs;

  // Getters
  List<Subject> get subjectsList => subjects;
  List<TimetableEntry> get timetableList => timetable;
  List<LabSchedule> get labSchedulesList => labSchedules;
  bool get isLoadingValue => isLoading.value;
  String get errorValue => error.value;

  AcademicController({required this.repository});

  @override
  void onInit() {
    super.onInit();
    getEnrolledSubjects();
    getTimetable();
    getLabSchedules();
  }

  Future<void> getEnrolledSubjects() async {
    isLoading.value = true;
    error.value = '';

    try {
      final data = await repository.getEnrolledSubjects();
      subjects.assignAll(data);
      error.value = '';
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getSubjectDetail(int subjectId) async {
    isLoading.value = true;
    error.value = '';

    try {
      final data = await repository.getSubjectDetail(subjectId);
      selectedSubject.value = data;
      error.value = '';
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getTimetable() async {
    try {
      final data = await repository.getTimetable();
      timetable.assignAll(data);
      error.value = '';
    } catch (e) {
      error.value = e.toString();
    }
  }

  Future<void> getLabSchedules() async {
    try {
      final data = await repository.getLabSchedules();
      labSchedules.assignAll(data);
      error.value = '';
    } catch (e) {
      error.value = e.toString();
    }
  }

  List<TimetableEntry> getTimetableForDay(String day) {
    return timetable.where((t) => t.dayOfWeek == day).toList();
  }

  List<String> get daysOfWeek {
    final days = {'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'};
    return days.toList();
  }

  Future<void> refresh() async {
    await Future.wait([
      getEnrolledSubjects(),
      getTimetable(),
      getLabSchedules(),
    ]);
  }
}

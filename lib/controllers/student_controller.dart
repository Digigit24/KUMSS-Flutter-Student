import 'package:get/get.dart';
import '../models/student.dart';
import '../repositories/student_repository.dart';

class StudentController extends GetxController {
  final StudentRepository repository;

  // Observables
  Rx<Student?> student = Rx<Student?>(null);
  RxList<Guardian> guardians = RxList<Guardian>();
  RxList<StudentAddress> addresses = RxList<StudentAddress>();
  RxList<StudentDocument> documents = RxList<StudentDocument>();
  RxBool isLoading = false.obs;
  RxString error = ''.obs;

  // Getters
  Student? get studentValue => student.value;
  List<Guardian> get guardiansList => guardians;
  List<StudentAddress> get addressesList => addresses;
  List<StudentDocument> get documentsList => documents;
  bool get isLoadingValue => isLoading.value;
  String get errorValue => error.value;

  StudentController({required this.repository});

  @override
  void onInit() {
    super.onInit();
    getStudentProfile();
    getGuardians();
    getAddresses();
    getDocuments();
  }

  Future<void> getStudentProfile() async {
    isLoading.value = true;
    error.value = '';

    try {
      final data = await repository.getStudentProfile();
      student.value = data;
      error.value = '';
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateStudentProfile(Student updatedStudent) async {
    isLoading.value = true;
    error.value = '';

    try {
      await repository.updateStudentProfile(updatedStudent);
      student.value = updatedStudent;
      error.value = '';
      Get.snackbar('Success', 'Profile updated successfully');
    } catch (e) {
      error.value = e.toString();
      Get.snackbar('Error', error.value);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getGuardians() async {
    try {
      final data = await repository.getGuardians();
      guardians.assignAll(data);
      error.value = '';
    } catch (e) {
      error.value = e.toString();
    }
  }

  Future<void> getAddresses() async {
    try {
      final data = await repository.getAddresses();
      addresses.assignAll(data);
      error.value = '';
    } catch (e) {
      error.value = e.toString();
    }
  }

  Future<void> getDocuments() async {
    try {
      final data = await repository.getDocuments();
      documents.assignAll(data);
      error.value = '';
    } catch (e) {
      error.value = e.toString();
    }
  }

  StudentAddress? get primaryAddress {
    try {
      return addresses.firstWhere((a) => a.isPrimary);
    } catch (e) {
      return null;
    }
  }

  Future<void> refresh() async {
    await Future.wait([
      getStudentProfile(),
      getGuardians(),
      getAddresses(),
      getDocuments(),
    ]);
  }
}

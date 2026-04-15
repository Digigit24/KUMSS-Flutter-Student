import 'package:get/get.dart';
import '../models/certificate.dart';
import '../repositories/certificate_repository.dart';

class CertificateController extends GetxController {
  final CertificateRepository repository;

  // Observables
  RxList<Certificate> certificates = RxList<Certificate>();
  RxBool isLoading = false.obs;
  RxString error = ''.obs;

  // Getters
  List<Certificate> get certificateList => certificates;
  bool get isLoadingValue => isLoading.value;
  String get errorValue => error.value;

  CertificateController({required this.repository});

  @override
  void onInit() {
    super.onInit();
    getCertificates();
  }

  Future<void> getCertificates() async {
    isLoading.value = true;
    error.value = '';

    try {
      final data = await repository.getCertificates();
      certificates.assignAll(data);
      error.value = '';
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> requestCertificate(String type, String? address) async {
    isLoading.value = true;
    error.value = '';

    try {
      final cert = await repository.requestCertificate(type, address);
      certificates.add(cert);
      error.value = '';
      Get.snackbar('Success', 'Certificate request submitted successfully');
    } catch (e) {
      error.value = e.toString();
      Get.snackbar('Error', error.value);
    } finally {
      isLoading.value = false;
    }
  }

  // Computed properties
  int get totalRequests => certificates.length;
  int get issuedCount => certificates.where((c) => c.isIssued).length;
  int get processingCount => certificates.where((c) => c.isProcessing).length;
  int get readyCount => certificates.where((c) => c.isReady).length;

  List<Certificate> get issuedCertificates {
    return certificates.where((c) => c.isIssued).toList();
  }

  Future<void> refresh() async {
    await getCertificates();
  }
}

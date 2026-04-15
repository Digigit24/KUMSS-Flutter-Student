import '../models/certificate.dart';
import '../services/config.dart';

abstract class CertificateRepository {
  Future<List<Certificate>> getCertificates();
  Future<Certificate> getCertificateDetail(int certificateId);
  Future<Certificate> requestCertificate(String type, String? address);
}

class CertificateRepositoryImpl implements CertificateRepository {
  @override
  Future<List<Certificate>> getCertificates() async {
    if (Config.USE_MOCK_DATA) {
      await Future.delayed(const Duration(milliseconds: 500));

      return [
        Certificate(
          id: 1,
          studentId: 1,
          certificateType: 'Bonafide',
          requestDate: '2024-03-10',
          status: 'Issued',
          issuedDate: '2024-03-15',
          certificateUrl: 'https://via.placeholder.com/bonafide.pdf',
          pickupDate: '2024-03-16',
        ),
        Certificate(
          id: 2,
          studentId: 1,
          certificateType: 'Character',
          requestDate: '2024-02-20',
          status: 'Ready',
          pickupDate: null,
        ),
        Certificate(
          id: 3,
          studentId: 1,
          certificateType: 'Transfer',
          requestDate: '2024-04-01',
          status: 'Processing',
          remarks: 'Under verification. Expected completion in 3-5 days.',
        ),
      ];
    } else {
      // TODO: Implement real API call
      throw UnimplementedError('Real API implementation pending');
    }
  }

  @override
  Future<Certificate> getCertificateDetail(int certificateId) async {
    if (Config.USE_MOCK_DATA) {
      await Future.delayed(const Duration(milliseconds: 500));

      return Certificate(
        id: certificateId,
        studentId: 1,
        certificateType: 'Bonafide',
        requestDate: '2024-03-10',
        status: 'Issued',
        issuedDate: '2024-03-15',
        certificateUrl: 'https://via.placeholder.com/bonafide.pdf',
        pickupDate: '2024-03-16',
      );
    } else {
      // TODO: Implement real API call
      throw UnimplementedError('Real API implementation pending');
    }
  }

  @override
  Future<Certificate> requestCertificate(String type, String? address) async {
    if (Config.USE_MOCK_DATA) {
      await Future.delayed(const Duration(milliseconds: 500));

      return Certificate(
        id: 4,
        studentId: 1,
        certificateType: type,
        requestDate: DateTime.now().toString().split(' ').first,
        status: 'Requested',
      );
    } else {
      // TODO: Implement real API call
      throw UnimplementedError('Real API implementation pending');
    }
  }
}

// Factory constructor
CertificateRepository createCertificateRepository() {
  return CertificateRepositoryImpl();
}

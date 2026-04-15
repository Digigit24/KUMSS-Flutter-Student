import '../models/student.dart';
import '../services/config.dart';

abstract class StudentRepository {
  Future<Student> getStudentProfile();
  Future<void> updateStudentProfile(Student student);
  Future<List<Guardian>> getGuardians();
  Future<List<StudentAddress>> getAddresses();
  Future<List<StudentDocument>> getDocuments();
}

class StudentRepositoryImpl implements StudentRepository {
  @override
  Future<Student> getStudentProfile() async {
    if (Config.USE_MOCK_DATA) {
      await Future.delayed(const Duration(milliseconds: 500));
      return Student(
        id: 1,
        fullName: 'John Doe',
        admissionNumber: 'ADM001',
        email: 'john@university.edu',
        phone: '+91 98765 43210',
        dateOfBirth: '2002-05-15',
        gender: 'Male',
        address: '123 Main Street, Apt 4B',
        city: 'Bangalore',
        state: 'Karnataka',
        pincode: '560001',
        profilePhotoUrl: 'https://via.placeholder.com/150',
        collegeId: 'KUMSS001',
        departmentId: 'CS',
        enrollmentYear: '2020',
        currentSemester: '6',
        registrationDate: '2020-07-15',
        bloodGroup: 'O+',
        emergencyContact: 'Jane Doe',
        emergencyPhone: '+91 98765 43209',
      );
    } else {
      // TODO: Implement real API call
      // final response = await ApiService().dio.get('/students/students/me/');
      // return Student.fromJson(response.data);
      throw UnimplementedError('Real API implementation pending');
    }
  }

  @override
  Future<void> updateStudentProfile(Student student) async {
    if (Config.USE_MOCK_DATA) {
      await Future.delayed(const Duration(milliseconds: 500));
      // Mock implementation - just return successfully
      return;
    } else {
      // TODO: Implement real API call
      throw UnimplementedError('Real API implementation pending');
    }
  }

  @override
  Future<List<Guardian>> getGuardians() async {
    if (Config.USE_MOCK_DATA) {
      await Future.delayed(const Duration(milliseconds: 500));
      return [
        Guardian(
          id: 1,
          studentId: 1,
          name: 'Mr. Robert Doe',
          relation: 'Father',
          phone: '+91 98765 43210',
          email: 'robert.doe@email.com',
          address: '123 Main Street, Apt 4B, Bangalore',
          designation: 'Senior Manager',
        ),
        Guardian(
          id: 2,
          studentId: 1,
          name: 'Mrs. Sarah Doe',
          relation: 'Mother',
          phone: '+91 98765 43211',
          email: 'sarah.doe@email.com',
          address: '123 Main Street, Apt 4B, Bangalore',
          designation: 'Teacher',
        ),
      ];
    } else {
      // TODO: Implement real API call
      throw UnimplementedError('Real API implementation pending');
    }
  }

  @override
  Future<List<StudentAddress>> getAddresses() async {
    if (Config.USE_MOCK_DATA) {
      await Future.delayed(const Duration(milliseconds: 500));
      return [
        StudentAddress(
          id: 1,
          studentId: 1,
          addressType: 'Home',
          address: '123 Main Street, Apt 4B',
          city: 'Bangalore',
          state: 'Karnataka',
          pincode: '560001',
          country: 'India',
          isPrimary: true,
        ),
        StudentAddress(
          id: 2,
          studentId: 1,
          addressType: 'Hostel',
          address: '456 College Avenue, Block C',
          city: 'Bangalore',
          state: 'Karnataka',
          pincode: '560002',
          country: 'India',
          isPrimary: false,
        ),
      ];
    } else {
      // TODO: Implement real API call
      throw UnimplementedError('Real API implementation pending');
    }
  }

  @override
  Future<List<StudentDocument>> getDocuments() async {
    if (Config.USE_MOCK_DATA) {
      await Future.delayed(const Duration(milliseconds: 500));
      return [
        StudentDocument(
          id: 1,
          studentId: 1,
          documentType: 'Aadhar',
          documentNumber: '1234 5678 9012',
          documentUrl: 'https://via.placeholder.com/200x300',
          uploadedAt: '2020-07-15',
          verificationStatus: 'Verified',
        ),
        StudentDocument(
          id: 2,
          studentId: 1,
          documentType: 'PAN',
          documentNumber: 'ABCDE1234F',
          documentUrl: 'https://via.placeholder.com/200x300',
          uploadedAt: '2020-08-20',
          verificationStatus: 'Verified',
        ),
      ];
    } else {
      // TODO: Implement real API call
      throw UnimplementedError('Real API implementation pending');
    }
  }
}

// Factory constructor
StudentRepository createStudentRepository() {
  return StudentRepositoryImpl();
}
